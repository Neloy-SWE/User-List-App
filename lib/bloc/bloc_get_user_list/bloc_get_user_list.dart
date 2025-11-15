/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:user_list_app/network/app_exception.dart';
import 'package:user_list_app/network/model/model_user_list.dart';
import 'package:user_list_app/network/repository/repository_get_user_list/i_repository_get_user_list.dart';

import '../../network/client/client_constant.dart';
import '../../network/connection_check/i_connection_check.dart';

part 'event_get_user_list.dart';

part 'state_get_user_list.dart';

class BlocGetUserList extends Bloc<EventUserList, StateGetUserList> {
  final IRepositoryGetUserList repositoryGetUserList;
  final IConnectionCheck connectionCheck;

  BlocGetUserList({
    required this.repositoryGetUserList,
    required this.connectionCheck,
  }) : super(StateGetUserInitial()) {
    on<EventGetUserList>(_onGetUserList, transformer: sequential());
    on<EventLoadMoreUsers>(_onLoadMoreUsers);
  }

  late ModelUserList modelUserList;
  List<User> userList = [];

  Future<void> _onGetUserList(
    EventGetUserList event,
    Emitter<StateGetUserList> emit,
  ) async {
    emit(StateGetUserInitial());
    try {
      if (await connectionCheck.isConnected) {
        ModelUserList modelUserList = await repositoryGetUserList
            .getUserListFromRepository(pageNo: event.pageNo);
        this.modelUserList = modelUserList;
      } else {
        ModelUserList modelUserList =
            await repositoryGetUserList.getLocalUserListFromRepository();
        this.modelUserList = modelUserList;
      }
      userList = modelUserList.userList!;
      emit(StateGetUserPass(userList: userList));
    } on AppException catch (e) {
      if (e.errorType == ClientConstant.noInternet ||
          e.errorType == ClientConstant.noLocalData ||
          e.errorType == ClientConstant.localDataSaveFail) {
        emit(StateGetUserRetry(message: e.message));
      } else if (e.errorType == ClientConstant.apiCallFail) {
        emit(StateDevelopment(message: e.message));
      } else {
        emit(StateGetUserFail(message: e.message));
      }
    } catch (e) {
      emit(StateGetUserFail(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreUsers(
    EventLoadMoreUsers event,
    Emitter<StateGetUserList> emit,
  ) async {
    emit(StateLoadInitial());
    try {
      if (userList.length < modelUserList.total!) {
        ModelUserList modelUserList = await repositoryGetUserList
            .loadMoreUserFromRepository(pageNo: this.modelUserList.page! + 1);
        this.modelUserList = modelUserList;
        userList.addAll(modelUserList.userList!);
        emit(StateGetUserPass(userList: userList));
      } else {
        emit(StateLoadMoreFinish(message: ClientConstant.noMoreUserAvailable));
      }
    } on AppException catch (e) {
      emit(StateLoadMoreRetry(message: e.message));
    } catch (e) {
      emit(StateGetUserFail(message: e.toString()));
    }
  }
}
