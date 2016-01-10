#!/usr/bin/env escript
% userids.erl
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-module(userids).
-export([main/1, main/0, readUsers/1, readUsers/0, readGroups/1, readGroups/0]).

etc_passwd_fname() -> "/etc/passwd".	% Default users file
etc_group_fname() -> "/etc/group".	% Default groups file

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main/1: 1 command line arg
main([Arg1Str]) ->
  Report = Arg1Str,
  processUserGroupInfo(Report);

% main/1: 0,2,3,... command line args
main(_) ->
  Report = "all",
  processUserGroupInfo(Report).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% main/0
main() ->
  Report = "all",
  processUserGroupInfo(Report).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
processUserGroupInfo(Report) ->
  Users = readUsers("../../etc/userids/etc_passwd"),
  Groups = readGroups("../../etc/userids/etc_group"),
  showUserGroupInfo(Users, Users, Groups, string:to_lower(Report)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
showUserGroupInfo([], _Users, _Groups, _Report) -> no_op;

showUserGroupInfo([UserRec|T], Users, Groups, Report) ->
  { {uid, Uid}, {uname, Uname}, {gid, Gid} } = UserRec,			% Get user record
  UidInt = binary_to_integer(Uid),
  if
    (Report =/= "system") and (Report =/= "normal") or
    (Report =:= "system") and (UidInt < 1000) or
    (Report =:= "normal") and (UidInt >= 1000) ->
      { {gname, Gname}, _, _ } = lists:keyfind({gid, Gid}, 2, Groups),	% Get group name
      GroupsString = getGroupsString(Uname, Gid, Gname, Groups),
      io:format("uid=~s(~s) gid=~s(~s) groups=~s\n", [Uid, Uname, Gid, Gname, GroupsString]);

    true -> no_op
  end,
  showUserGroupInfo(T, Users, Groups, Report).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Iterate through Groups looking for Uname within (secondary) Unames list
% and return any matching group IDs (Gid) and group names (Gname). Also
% return the primary group ID/name first in the string. Eg. format:
%   "107(qemu),36(kvm)"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  getGroupsString(Uname, Gid, Gname, Groups) ->
    PrimaryGroupIdName = [ io_lib:format("~s(~s)", [Gid, Gname]) ],

    % Filter-in only secondary groups for this user
    SecondaryGroups = lists:filter(
      fun(GroupRec1) ->
        { _, _, {unames, Unames1} } = GroupRec1,
        lists:member(Uname, Unames1)
      end,
      Groups
    ),

    % Map tuple info into list of strings, eg. ["36(kvm)", ...]
    SecondaryGroupsIdsNames = lists:map(
      fun(GroupRec2) ->
        { {gname, Gname2}, {gid, Gid2}, _ } = GroupRec2,
        io_lib:format("~s(~s)", [Gid2, Gname2])
      end,
      SecondaryGroups
    ),

    % Remove primary group from secondary list if it is present, then prepend it.
    AllGroupsIdsNames = PrimaryGroupIdName ++ (SecondaryGroupsIdsNames -- PrimaryGroupIdName),
    string:join(AllGroupsIdsNames, ",").	% Return joined-list

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% User functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
readUsers() -> readUsers( etc_passwd_fname() ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
readUsers(Etc_passwd_fname) ->
  {ok, FileStr} = file:read_file(Etc_passwd_fname),
  Lines = binary:split(FileStr, <<"\n">>, [global]),
  file:close(FileStr),
  Users = linesToUsers(Lines),
  Users.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linesToUsers([]) -> [];

linesToUsers([Line|T]) ->
  if
    Line =/= <<>> ->
      [Uname, _, Uid, Gid, _, _, _] = binary:split(Line, <<":">>, [global]),
      [ { {uid, Uid}, {uname, Uname}, {gid, Gid} } ] ++ linesToUsers(T);

    true -> linesToUsers(T)
  end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Group functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
readGroups() -> readGroups( etc_group_fname() ).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
readGroups(Etc_group_fname) ->
  {ok, FileStr} = file:read_file(Etc_group_fname),
  Lines = binary:split(FileStr, <<"\n">>, [global]),
  file:close(FileStr),
  Groups = linesToGroups(Lines),
  Groups.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
linesToGroups([]) -> [];

linesToGroups([Line|T]) ->
  if
    Line =/= <<>> ->
      [Gname, _, Gid, UnamesStr] = binary:split(Line, <<":">>, [global]),
      Unames = binary:split(UnamesStr, <<",">>, [global]),
      [ { {gname, Gname}, {gid, Gid}, {unames, Unames} } ] ++ linesToGroups(T);

    true -> linesToGroups(T)
  end.

