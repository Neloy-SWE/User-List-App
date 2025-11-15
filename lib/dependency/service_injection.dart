/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:get_it/get_it.dart';
import 'package:user_list_app/network/api/api_get_user_list/api_call_get_user_list.dart';
import 'package:user_list_app/network/api/api_get_user_list/i_api_call_get_user_list.dart';
import 'package:user_list_app/network/client/client.dart';
import 'package:user_list_app/network/connection_check/connection_check.dart';
import 'package:user_list_app/network/connection_check/i_connection_check.dart';
import 'package:user_list_app/network/local/local_get_user_list/i_local_get_user_list.dart';
import 'package:user_list_app/network/local/local_get_user_list/local_get_user_list.dart';
import 'package:user_list_app/network/repository/repository_get_user_list/i_repository_get_user_list.dart';
import 'package:user_list_app/network/repository/repository_get_user_list/repository_get_user_list.dart';

final serviceInjector = GetIt.instance;

Future<void> injectService() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceInjector.registerSingleton<SharedPreferences>(sharedPreferences);
  serviceInjector.registerSingleton<Client>(Client());

  serviceInjector.registerSingleton<Connectivity>(Connectivity());

  serviceInjector.registerSingleton<ILocalGetUserList>(
    LocalGetUserList(sharedPreferences: serviceInjector<SharedPreferences>()),
  );

  serviceInjector.registerSingleton<IApiCallGetUserList>(
    ApiCallGetUserList(client: serviceInjector<Client>()),
  );

  serviceInjector.registerSingleton<IRepositoryGetUserList>(
    RepositoryGetUserList(
      apiCallGetUserList: serviceInjector<IApiCallGetUserList>(),
      localGetUserList: serviceInjector<ILocalGetUserList>(),
    ),
  );

  serviceInjector.registerSingleton<IConnectionCheck>(
    ConnectionCheck(connectivity: serviceInjector<Connectivity>()),
  );

  // serviceInjector.registerFactory<BlocGetUserList>(
  //   () => BlocGetUserList(
  //     repositoryGetUserList: serviceInjector<IRepositoryGetUserList>(),
  //   ),
  // );
}
