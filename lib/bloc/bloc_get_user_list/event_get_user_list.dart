/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_get_user_list.dart';

abstract class EventUserList extends Equatable {
  const EventUserList();

  @override
  List<Object?> get props => [];
}

class EventGetUserList extends EventUserList {
  final int pageNo;

  const EventGetUserList({required this.pageNo});

  @override
  List<Object?> get props => [pageNo];
}

class EventLoadMoreUsers extends EventUserList {}
