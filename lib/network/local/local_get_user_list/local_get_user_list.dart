/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:convert';

import 'package:user_list_app/network/client/client_constant.dart';
import 'package:user_list_app/network/model/model_user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_exception.dart';
import 'i_local_get_user_list.dart';

class LocalGetUserList extends ILocalGetUserList {
  final SharedPreferences sharedPreferences;

  LocalGetUserList({required this.sharedPreferences});

  @override
  Future<ModelUserList> getUserList() async {
    final jsonString = sharedPreferences.getString(ClientConstant.saveUserList);
    if (jsonString != null) {
      return ModelUserList.fromRawJson(jsonString);
    } else {
      throw AppException(
        errorType: ClientConstant.noLocalData,
        message: ClientConstant.needInternetConnectionThisTime,
      );
    }
  }

  @override
  Future<void> saveLocalUserList({required ModelUserList modelUserList}) async {
    try {
      await sharedPreferences.setString(
        ClientConstant.saveUserList,
        json.encode(modelUserList),
      );
    } on Exception {
      throw AppException(
        errorType: ClientConstant.localDataSaveFail,
        message: ClientConstant.failedToSaveOfflineData,
      );
    }
  }
}
