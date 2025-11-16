/* 
Created by Neloy on 16 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_list_app/network/api/api_get_user_list/i_api_call_get_user_list.dart';
import 'package:user_list_app/network/app_exception.dart';
import 'package:user_list_app/network/client/client_constant.dart';
import 'package:user_list_app/network/local/local_get_user_list/i_local_get_user_list.dart';
import 'package:user_list_app/network/model/model_user_list.dart';
import 'package:user_list_app/network/repository/repository_get_user_list/repository_get_user_list.dart';

class MockApiCall extends Mock implements IApiCallGetUserList {}

class MockLocalData extends Mock implements ILocalGetUserList {}

void main() {
  late MockApiCall apiCall;
  late MockLocalData localData;
  late RepositoryGetUserList repository;

  setUp(() {
    apiCall = MockApiCall();
    localData = MockLocalData();
    repository = RepositoryGetUserList(
      apiCallGetUserList: apiCall,
      localGetUserList: localData,
    );
  });

  final model = ModelUserList(
    page: 1,
    total: 1,
    userList: [
      User(id: 1, firstName: "a", lastName: "b", email: "c", avatar: "d"),
    ],
  );
  test("remote and local data fetch check", () async {
    when(
      () => apiCall.getUserList(data: any(named: "data")),
    ).thenAnswer((_) async => model);

    when(
      () => localData.saveLocalUserList(modelUserList: model),
    ).thenAnswer((_) async {});

    final result = await repository.getUserListFromRepository(pageNo: 1);

    expect(result, equals(model));

    verify(() => apiCall.getUserList(data: any(named: "data"))).called(1);
    verify(() => localData.saveLocalUserList(modelUserList: model)).called(1);
  });

  test("DioException check", () async {
    when(
      () => apiCall.getUserList(data: any(named: "data")),
    ).thenThrow(DioException(requestOptions: RequestOptions(path: "")));

    expect(
      () => repository.getUserListFromRepository(pageNo: 1),
      throwsA(
        isA<AppException>().having(
          (e) => e.errorType,
          'errorType',
          ClientConstant.noInternet,
        ),
      ),
    );
  });

  test("general exceptions check", () async {
    when(
      () => apiCall.getUserList(data: any(named: "data")),
    ).thenThrow(Exception());

    expect(
      () => repository.getUserListFromRepository(pageNo: 1),
      throwsA(isA<Exception>()),
    );
  });

  test("get local data", () async {
    when(() => localData.getUserList()).thenAnswer((_) async => model);

    final result = await repository.getLocalUserListFromRepository();

    expect(result, model);
  });

  test("load more data", () async {
    when(
      () => apiCall.getUserList(data: any(named: "data")),
    ).thenAnswer((_) async => model);

    final result = await repository.loadMoreUserFromRepository(pageNo: 2);

    expect(result, model);
  });
}
