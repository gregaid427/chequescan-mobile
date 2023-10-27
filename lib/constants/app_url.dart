class AppUrl {
  static const String liveBaseURL = "http://136.244.77.140:5000/api";
  static const String localBaseURL = "http://192.168.43.53:5000/api";
  static const String baseURL = liveBaseURL;

//  static const String baseURL = localBaseURL;
  static const String login = "$baseURL/users/login";
  static const String register = "$baseURL/users";
  static const String forgotPassword = "$baseURL/forgot-password";
  static const String getuserprofilebyid = "$baseURL/users/";

  static const String gettransactionsbyuserid = "$baseURL/transactions";

  static const String getlinkedaccountsbyuserid = "$baseURL/linkedaccounts/";

  static const String postscandata = "$baseURL/scan/upload/";

  static const String userlinkedaccount = baseURL + "/linkedaccounts/";
  static const String accountTransactions = baseURL + "/transactions/";
  static const String otpReset = baseURL + "/users/pinreset/";
  static const String uploadscandata = baseURL + "/scan/upload/";

  static const String otpVerify = baseURL + "/users/UpdatePinStatus/";
  static const String getbanks = baseURL + "/linkedaccounts/banks/";

}
