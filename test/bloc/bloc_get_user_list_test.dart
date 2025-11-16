/* 
Created by Neloy on 16 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_list_app/bloc/bloc_get_user_list/bloc_get_user_list.dart';
import 'package:user_list_app/network/app_exception.dart';
import 'package:user_list_app/network/client/client_constant.dart';
import 'package:user_list_app/network/connection_check/i_connection_check.dart';
import 'package:user_list_app/network/model/model_user_list.dart';
import 'package:user_list_app/network/repository/repository_get_user_list/i_repository_get_user_list.dart';

class MockIRepositoryGetUserList extends Mock
    implements IRepositoryGetUserList {}

class MockIConnectionCheck extends Mock implements IConnectionCheck {}

ModelUserList makeModel({
  required int page,
  required int total,
  required List<User> users,
}) {
  return ModelUserList(page: page, total: total, userList: users);
}

User makeUser(int id) {
  return User(
    id: id,
    email: 'test$id@mail.com',
    firstName: 'F$id',
    lastName: 'L$id',
    avatar: 'url$id',
  );
}

void main() {
  group("Get user list bloc", () {
    late BlocGetUserList bloc;
    late MockIRepositoryGetUserList repositoryGetUserList;
    late MockIConnectionCheck connectionCheck;

    setUp(() {
      repositoryGetUserList = MockIRepositoryGetUserList();
      connectionCheck = MockIConnectionCheck();
      bloc = BlocGetUserList(
        repositoryGetUserList: repositoryGetUserList,
        connectionCheck: connectionCheck,
      );
    });

    test("Check initial state", () {
      expect(bloc.state, StateGetUserInitial());
    });

    blocTest<BlocGetUserList, StateGetUserList>(
      "Online user fetch test",
      build: () {
        when(() => connectionCheck.isConnected).thenAnswer((_) async => true);

        when(
          () => repositoryGetUserList.getUserListFromRepository(pageNo: 1),
        ).thenAnswer(
          (_) async => makeModel(page: 1, total: 10, users: [makeUser(1)]),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(const EventGetUserList(pageNo: 1)),
      expect: () => [isA<StateGetUserInitial>(), isA<StateGetUserPass>()],
    );

    blocTest<BlocGetUserList, StateGetUserList>(
      "offline user fetch test",
      build: () {
        when(() => connectionCheck.isConnected).thenAnswer((_) async => false);

        when(
          () => repositoryGetUserList.getLocalUserListFromRepository(),
        ).thenAnswer(
          (_) async => makeModel(page: 1, total: 10, users: [makeUser(1)]),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(const EventGetUserList(pageNo: 1)),
      expect: () => [isA<StateGetUserInitial>(), isA<StateGetUserPass>()],
    );

    blocTest<BlocGetUserList, StateGetUserList>(
      "checking retry option for no local data/ no internet/ local data save fail for the first time",
      build: () {
        when(() => connectionCheck.isConnected).thenAnswer((_) async => false);

        when(
          () => repositoryGetUserList.getLocalUserListFromRepository(),
        ).thenThrow(
          AppException(
            message: "",
            // errorType: ClientConstant.noLocalData,
            errorType: ClientConstant.noInternet,
            // errorType: ClientConstant.localDataSaveFail,
          ),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const EventGetUserList(pageNo: 1)),
      expect: () => [isA<StateGetUserInitial>(), isA<StateGetUserRetry>()],
    );

    blocTest<BlocGetUserList, StateGetUserList>(
      "notify user about api error",
      build: () {
        when(() => connectionCheck.isConnected).thenAnswer((_) async => true);

        when(
          () => repositoryGetUserList.getUserListFromRepository(pageNo: 1),
        ).thenThrow(
          AppException(message: "", errorType: ClientConstant.apiCallFail),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(const EventGetUserList(pageNo: 1)),
      expect: () => [isA<StateGetUserInitial>(), isA<StateDevelopment>()],
    );

    blocTest<BlocGetUserList, StateGetUserList>(
      "checking fail state of other general cases",
      build: () {
        when(() => connectionCheck.isConnected).thenAnswer((_) async => true);

        when(
          () => repositoryGetUserList.getUserListFromRepository(pageNo: 1),
        ).thenThrow(Exception());

        return bloc;
      },
      act: (bloc) => bloc.add(const EventGetUserList(pageNo: 1)),
      expect: () => [isA<StateGetUserInitial>(), isA<StateGetUserFail>()],
    );

    blocTest<BlocGetUserList, StateGetUserList>(
      "load more users successfully",
      build: () {
        bloc.modelUserList = makeModel(
          page: 1,
          total: 4,
          users: [makeUser(1), makeUser(2)],
        );
        bloc.userList = [makeUser(1), makeUser(2)];

        when(
          () => repositoryGetUserList.loadMoreUserFromRepository(pageNo: 2),
        ).thenAnswer(
          (_) async =>
              makeModel(page: 2, total: 4, users: [makeUser(3), makeUser(4)]),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(EventLoadMoreUsers()),
      expect: () => [isA<StateLoadInitial>(), isA<StateGetUserPass>()],
    );

    blocTest<BlocGetUserList, StateGetUserList>(
      "total user fetch completeness check",
      build: () {
        bloc.modelUserList = makeModel(
          page: 1,
          total: 2,
          users: [makeUser(1), makeUser(2)],
        );
        bloc.userList = [makeUser(1), makeUser(2)];

        return bloc;
      },
      act: (bloc) => bloc.add(EventLoadMoreUsers()),
      expect: () => [isA<StateLoadInitial>(), isA<StateLoadMoreFinish>()],
    );

    blocTest<BlocGetUserList, StateGetUserList>(
      "set retry state for load more user if fails",
      build: () {
        bloc.modelUserList = makeModel(
          page: 1,
          total: 10,
          users: [makeUser(1)],
        );
        bloc.userList = [makeUser(1)];

        when(
          () => repositoryGetUserList.loadMoreUserFromRepository(pageNo: 2),
        ).thenThrow(
          AppException(message: "", errorType: ClientConstant.apiCallFail),
        );

        return bloc;
      },
      act: (bloc) => bloc.add(EventLoadMoreUsers()),
      expect: () => [isA<StateLoadInitial>(), isA<StateLoadMoreRetry>()],
    );
  });
}
