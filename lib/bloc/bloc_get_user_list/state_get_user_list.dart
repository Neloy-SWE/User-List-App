/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_get_user_list.dart';

abstract class StateGetUserList extends Equatable {
  const StateGetUserList();

  @override
  List<Object?> get props => [];
}

class StateGetUserInitial extends StateGetUserList {}
class StateLoadInitial extends StateGetUserList {}

class StateGetUserFail extends StateGetUserList {
  final String message;

  const StateGetUserFail({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateGetUserRetry extends StateGetUserList {
  final String message;

  const StateGetUserRetry({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateLoadMoreRetry extends StateGetUserList {
  final String message;

  const StateLoadMoreRetry({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateDevelopment extends StateGetUserList {
  final String message;

  const StateDevelopment({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateLoadMoreFinish extends StateGetUserList {
  final String message;

  const StateLoadMoreFinish({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateGetUserPass extends StateGetUserList {
  final List<User> userList;

  const StateGetUserPass({required this.userList});

  @override
  List<Object?> get props => [userList];
}
