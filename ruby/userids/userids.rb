#!/usr/bin/ruby
# Usage:  userids.rb [system|normal]
#
# With no arguments, this program gives the same output as the command:
#   $ id USERNAME
# for every username listed in /etc/passwd. That is, output is the same as:
#   $ sed 's/:.*$//' /etc/passwd |while read uname; do id $uname; done
#
# With the argument 'system' only user IDs less than 1000 will be shown.
# With the argument 'normal' only user IDs greater or equal to 1000 will be shown.
##############################################################################
class User
  attr_reader :uname, :uid, :gid

  def initialize(etc_passwd_line)
    @uname, f2, @uid, @gid, f5_7 = etc_passwd_line.split(":", 5)
  end
end

##############################################################################
class Users
  attr_reader :unames, :gids

  def initialize(etc_passwd_fname="/etc/passwd")
    @unames = {}		# Lookup uname by uid
    @gids = {}			# Lookup gid by uid
    File.readlines(etc_passwd_fname).each {|line|
      u = User.new(line)
      @unames[u.uid] = u.uname
      @gids[u.uid] = u.gid
    }
  end
end

##############################################################################
class Group
  attr_reader :gname, :gid, :unames

  def initialize(etc_group_line)
    @gname, f2, @gid, unames_str = etc_group_line.split(":")
    @unames = unames_str.chomp.split(",")
  end
end

##############################################################################
class Groups
  attr_reader :gnames, :unames_list

  def initialize(etc_group_fname="/etc/group")
    @gnames = {}
    @unames_list = {}
    File.readlines(etc_group_fname).each {|line|
      g = Group.new(line)
      @gnames[g.gid] = g.gname
      @unames_list[g.gid] = g.unames
    }
  end

  def gids_by_uname(uname)
    @unames_list.inject([]){|gids, (gid, unames)| gids << gid if unames.include?(uname); gids }
  end
end

##############################################################################
# main()
##############################################################################
# Process command-line arguments
report = :all
if ARGV.length > 0
  report = :system if ARGV[0].downcase == "system"
  report = :normal if ARGV[0].downcase == "normal"
end

# Read and process /etc/passwd and /etc/group files
users = Users.new("../../etc/userids/etc_passwd")
groups = Groups.new("../../etc/userids/etc_group")

users.unames.each{|uid, uname|
  next if report == :system && uid.to_i >= 1000	# System UIDs: 0-999
  next if report == :normal && uid.to_i < 1000	# Normal UIDs: 1000-

  group_strs = [ "#{users.gids[uid]}(#{groups.gnames[ users.gids[uid] ]})" ]
  ( groups.gids_by_uname(uname) - [ users.gids[uid] ] ).each{|gid|
    group_strs << "#{gid}(#{groups.gnames[gid]})"
  }
  puts "uid=#{uid}(#{uname}) gid=#{users.gids[uid]}(#{groups.gnames[ users.gids[uid] ]}) groups=#{group_strs.join(',')}"
}

