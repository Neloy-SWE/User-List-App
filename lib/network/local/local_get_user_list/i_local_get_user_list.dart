/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import '../../model/model_user_list.dart';

abstract class ILocalGetUserList {
  Future<ModelUserList> getUserList();

  Future<void> saveLocalUserList({required ModelUserList modelUserList});
}
