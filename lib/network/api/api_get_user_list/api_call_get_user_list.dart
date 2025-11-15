/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:user_list_app/network/client/client.dart';
import 'package:user_list_app/network/model/model_user_list.dart';

import '../../client/client_constant.dart';
import 'i_api_call_get_user_list.dart';

class ApiCallGetUserList extends IApiCallGetUserList {
  final Client client;

  ApiCallGetUserList({required this.client});

  @override
  Future<ModelUserList> getUserList({
    required Map<String, dynamic> data,
  }) async {
    Response response = await client.request.get("", queryParameters: data);
    if (response.statusCode == 200) {
      return ModelUserList.fromJson(response.data);
    } else {
      throw Exception(ClientConstant.somethingWentWrong);
    }
  }
}
