class Urls {
  //static const String baseUrl = 'https://yahya-backend.vercel.app/api/v1';
  static const String baseUrl = 'https://patrkamh.onrender.com/api/v1';
  static const String socketBaseUrl = 'ws://patrkamh.onrender.com';
  static const String googleApiKey = 'AIzaSyATkpZxtsIVek6xHnGRsse_i4yVEofqQbI';
  static const String stripePublishKey =
      'pk_test_51M6Z1MDEId8XEA8p159zFg9OCLAKfTBqMAu7UpE2A924djtOxBv0GRgp5gf34wcMQKDxZkhhgsOgZvR0sK6oxvuz00y7FngibS';
  static const String stripeSecretkey =
      'sk_test_51M6Z1MDEId8XEA8pgprV6IXPuYSBqVNbLQHKz03sjcj8DxRbbluhrIquES1qB2XeDyaNIeoXeWmntSPzB7Hw5NzH00PupDVDOy';

  static const String stripePublishableKey2 =
      "pk_test_51Qbw9kDLg7WG0GxrgsoFCAguT4cJH0zvW602k7s49MoRWyuE4xgHUqoxd82PFhYGiooV89LO3IYqniXHNtYetLv100yyfGLc6j";
  static const String stripeSecretKey2 =
      "sk_test_51Qbw9kDLg7WG0GxrW1ixIFxRAuw4sMStDC4WdmQxSy1L4BNBG2Szt2RcU8wiCtbyCuzep0eySNfi85I64f6mAKF200k4MykfS8";

  static const String login = '$baseUrl/auth/login';
  static const String authentication = '$baseUrl/auth/verify-auth';
  static const String logout = '$baseUrl/auth/logout';
  static const String fetchProfile = '$baseUrl/auth/profile';
  static const String updateProfile = '$baseUrl/users/profile';
  //static const String getFavourite = '$baseUrl/property/favorite/user';
  static const String getFavourite = '$baseUrl/favorite/my/list';

  static const String forgotPass = '$baseUrl/auth/forgot-password';
  static const String pickUpLocation = '$baseUrl/user/pickup-locations';
  static String getCalendar(String date, String locationUuid) =>
      '$baseUrl/calendar?date=$date&pickup_location_uuid=$locationUuid';
  static const String userProjectDetails = '$baseUrl/projects';
  static const String tasks = '$baseUrl/tasks';
  static const String profile = '$baseUrl/profile/';
  static const String portfolios = '$baseUrl/portfolios/';
  static const String socialMedia = '$baseUrl/socialAccount/all/social';
  static const String updateprotfolio = '$baseUrl/portfolios';
  static const String profileupdate = '$baseUrl/users/me';
  static const String authorizePayment = '$baseUrl/payment/authorize-payment';
  static const String capturePayment = '$baseUrl/payment/capture-payment';
  static const String notifications = '$baseUrl/notifications';
}
