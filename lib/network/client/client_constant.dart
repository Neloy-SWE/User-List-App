/* 
Created by Neloy on 15 November, 2025.
Email: taufiqneloy.swe@gmail.com
*/

class ClientConstant {
  static const String baseUrl = "https://reqres.in/api/users";

  // api header keys, values:
  static const String xApiKey = "x-api-key";
  static const String token = "reqres-free-v1";

  // general messages and keys:
  static const String contactWithDeveloper = "Contact with developer!";
  static const String apiCallFail = "apiCallFail";

  static const String checkYourInternetConnection =
      "Check your internet connection.";
  static const String noLocalData = "noLocalData";

  static const String needInternetConnectionThisTime = "Need internet connection this time.";
  static const String noInternet = "noInternet";

  static const String failedToSaveOfflineData = "Failed to save offline data.";
  static const String localDataSaveFail = "localDataSaveFail";
  static const String noMoreUserAvailable = "No more user available.";


  // body/param keys, values:
  static const String page = "page";
  static const String perPage = "per_page";

  // local storage key:
  static const String saveUserList = "saveUserList";
}
