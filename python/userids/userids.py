#!/usr/bin/env python3
# Usage:  userids.py [system|normal]
#
# With no arguments, this program gives the same output as the command:
#   $ id USERNAME
# for every username listed in /etc/passwd. That is, output is the same as:
#   $ sed 's/:.*$//' /etc/passwd |while read uname; do id $uname; done
#
# With the argument 'system' only user IDs less than 1000 will be shown.
# With the argument 'normal' only user IDs greater or equal to 1000 will be shown.
##############################################################################
#import sys

##############################################################################
class User:

  def __init__(self, etc_passwd_line):
    self.uname, f2, self.uid, self.gid, f5,f6,f7 = etc_passwd_line.split(":")

##############################################################################
class Users:

  def __init__(self, etc_passwd_fname="/etc/passwd"):
    self.unames = {}			# Lookup uname by uid
    self.gids = {}			# Lookup gid by uid
    self.uids_orig_order = []

    f_obj = open(etc_passwd_fname, "r")
    for line in f_obj:
      u = User(line)
      self.unames[u.uid] = u.uname
      self.gids[u.uid] = u.gid
      self.uids_orig_order.append(u.uid)
    f_obj.close()

##############################################################################
class Group:

  def __init__(self, etc_group_line):
    self.gname, f2, self.gid, unames_str = etc_group_line.split(":")
    self.unames = unames_str.rstrip('\n').split(",")

##############################################################################
class Groups:

  def __init__(self, etc_group_fname="/etc/group"):
    self.gnames = {}
    self.unames_list = {}
    self.gids_orig_order = []

    f_obj = open(etc_group_fname, "r")
    for line in f_obj:
      g = Group(line)
      self.gnames[g.gid] = g.gname
      self.unames_list[g.gid] = g.unames
      self.gids_orig_order.append(g.gid)
    f_obj.close()

  def gids_by_uname(self, uname):
    gids = []
    for gid in self.gids_orig_order:
      if uname in self.unames_list[gid]:
        gids.append(gid)
    return gids

##############################################################################
# main()
##############################################################################
# FIXME: Process command-line arguments

users = Users("../../etc/userids/etc_passwd")
groups = Groups("../../etc/userids/etc_group")

for uid in users.uids_orig_order:
  group_strs = [ "%s(%s)" % (users.gids[uid], groups.gnames[ users.gids[uid] ]) ]
  gids_without_prim = [ gid for gid in groups.gids_by_uname(users.unames[uid]) if gid not in [ users.gids[uid] ] ]
  for gid in gids_without_prim:
    group_strs.append("%s(%s)" % (gid, groups.gnames[gid]))
  print("uid=%s(%s) gid=%s(%s) groups=%s" % (uid, users.unames[uid], users.gids[uid], groups.gnames[ users.gids[uid] ], ",".join(group_strs)) )

