/* 
Created by Neloy on 16 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:user_list_app/network/api/api_get_user_list/api_call_get_user_list.dart';
import 'package:user_list_app/network/app_exception.dart';
import 'package:user_list_app/network/client/client.dart';
import 'package:user_list_app/network/client/client_constant.dart';

class MockClient extends Mock implements Client {}

class MockDio extends Mock implements Dio {}

void main() {
  late MockClient client;
  late MockDio dio;
  late ApiCallGetUserList api;

  setUp(() {
    client = MockClient();
    dio = MockDio();

    when(() => client.request).thenReturn(dio);

    api = ApiCallGetUserList(client: client);
  });

  test("check 200 status code", () async {
    final testJson = {
      "page": 1,
      "total": 2,
      "data": [
        {
          "id": 1,
          "email": "a@test.com",
          "first_name": "A",
          "last_name": "T",
          "avatar": "url1",
        },
      ],
    };

    when(
      () => dio.get("", queryParameters: {ClientConstant.page: 1}),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ""),
        data: testJson,
        statusCode: 200,
      ),
    );

    final result = await api.getUserList(data: {ClientConstant.page: 1});

    expect(result.page, 1);
    expect(result.userList!.length, 1);
    expect(result.userList!.first.id, 1);
  });

  test("check exception for other status codes", () async {
    when(
      () => dio.get("", queryParameters: {ClientConstant.page: 1}),
    ).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: ""),
        statusCode: 500,
        data: {},
      ),
    );

    expect(
      () => api.getUserList(data: {ClientConstant.page: 1}),
      throwsA(
        isA<AppException>().having(
          (e) => e.errorType,
          'errorType',
          ClientConstant.apiCallFail,
        ),
      ),
    );
  });
}
