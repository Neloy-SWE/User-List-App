/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:user_list_app/network/api/api_get_user_list/i_api_call_get_user_list.dart';
import 'package:user_list_app/network/model/model_user_list.dart';

import '../../client/client_constant.dart';
import 'i_repository_get_user_list.dart';

class RepositoryGetUserList extends IRepositoryGetUserList {
  final IApiCallGetUserList apiCallGetUserList;

  RepositoryGetUserList({required this.apiCallGetUserList});

  @override
  Future<ModelUserList> getUserListFromRepository({required int pageNo}) async {
    try {
      Map<String, dynamic> data = {
        ClientConstant.page: pageNo,
        ClientConstant.perPage: 10,
      };
      return await apiCallGetUserList.getUserList(data: data);
    } on DioException {
      throw Exception(ClientConstant.checkYourInternetConnection);
    } catch (e) {
      rethrow;
    }
  }
}
