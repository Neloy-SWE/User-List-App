/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:connectivity_plus/connectivity_plus.dart';

import 'i_connection_check.dart';

class ConnectionCheck extends IConnectionCheck {
  final Connectivity connectivity;

  ConnectionCheck({required this.connectivity});

  @override
  Future<bool> get isConnected async {
    final result = await connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }
}
