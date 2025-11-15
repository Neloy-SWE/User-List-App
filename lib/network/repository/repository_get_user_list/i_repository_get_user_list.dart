/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:user_list_app/network/model/model_user_list.dart';

abstract class IRepositoryGetUserList {
  Future<ModelUserList> getUserListFromRepository({required int pageNo});
}
