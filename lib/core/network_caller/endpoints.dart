class Urls {
  static const String baseURL = 'https://brother-taxi.onrender.com/api/v1';
  static const String socketUrl = 'ws://brother-taxi.onrender.com';
  static const String login = '$baseURL/auth/login';
  static const String resetPassword = '$baseURL/auth/reset-password';
  static const String authentication = '$baseURL/auth/verify-auth';
  static const String logout = '$baseURL/auth/logout';
  static const String forgotPass = '$baseURL/auth/forgot-password';
  static const String pickUpLocation = '$baseURL/carTransports/ride-plan';
  static const String carTransportsMyRidePlans = '$baseURL/carTransports/my-ride-plans';
  static String getCalendar(String date, String locationUuid) =>
      '$baseURL/calendar?date=$date&pickup_location_uuid=$locationUuid';


  static const String googleApiKey="AIzaSyC7AoMhe2ZP3iHflCVr6a3VeL0ju0bzYVE";

}
