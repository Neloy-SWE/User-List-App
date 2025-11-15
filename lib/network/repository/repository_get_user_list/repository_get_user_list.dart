/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:user_list_app/network/api/api_get_user_list/i_api_call_get_user_list.dart';
import 'package:user_list_app/network/app_exception.dart';
import 'package:user_list_app/network/local/local_get_user_list/i_local_get_user_list.dart';
import 'package:user_list_app/network/model/model_user_list.dart';

import '../../client/client_constant.dart';
import 'i_repository_get_user_list.dart';

class RepositoryGetUserList extends IRepositoryGetUserList {
  final IApiCallGetUserList apiCallGetUserList;
  final ILocalGetUserList localGetUserList;

  RepositoryGetUserList({
    required this.apiCallGetUserList,
    required this.localGetUserList,
  });

  @override
  Future<ModelUserList> getUserListFromRepository({required int pageNo}) async {
    try {
      Map<String, dynamic> data = {
        ClientConstant.page: pageNo,
        ClientConstant.perPage: 10,
      };
      ModelUserList modelUserList = await apiCallGetUserList.getUserList(
        data: data,
      );
      localGetUserList.saveLocalUserList(modelUserList: modelUserList);
      return modelUserList;
    } on DioException {
      throw AppException(
        errorType: ClientConstant.noInternet,
        message: ClientConstant.checkYourInternetConnection,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ModelUserList> getLocalUserListFromRepository() {
    try {
      return localGetUserList.getUserList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ModelUserList> loadMoreUserFromRepository({required int pageNo}) async {
    try {
      Map<String, dynamic> data = {
        ClientConstant.page: pageNo,
        ClientConstant.perPage: 10,
      };
      ModelUserList modelUserList = await apiCallGetUserList.getUserList(
        data: data,
      );
      return modelUserList;
    } on DioException {
      throw AppException(
        errorType: ClientConstant.noInternet,
        message: ClientConstant.checkYourInternetConnection,
      );
    } catch (e) {
      rethrow;
    }
  }
}
