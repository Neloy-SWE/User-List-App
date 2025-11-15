/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

class AppException implements Exception {
  final String errorType;
  final String message;

  AppException({required this.errorType, required this.message});
}