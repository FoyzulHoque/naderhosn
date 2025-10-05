class Urls {

  static const String _baseUrl = 'https://brother-taxi.onrender.com/api/v1';
  static const String socketUrl = 'ws://brother-taxi.onrender.com';
  static const String login = '$_baseUrl/auth/login';
  static const String resetPassword = '$_baseUrl/auth/reset-password';
  static const String authentication = '$_baseUrl/auth/verify-auth';
  static const String logout = '$_baseUrl/auth/logout';
  static const String forgotPass = '$_baseUrl/auth/forgot-password';
  static const String pickUpLocation = '$_baseUrl/carTransports/ride-plan';
  static const String carTransportsMyRidePlans = '$_baseUrl/carTransports/my-ride-plans';
  static const String carTransportsCreate = '$_baseUrl/carTransports/create';
  static const String paymentsCreateCard = '$_baseUrl/payments/create-card';
  static const String paymentsSavedCards = '$_baseUrl/payments/saved-cards';
  static const String paymentsCardPayment = '$_baseUrl/payments/card-payment';
  static const String reviewsCreate = '$_baseUrl/reviews/create';
  static  String carTransportsSingle(String id) => '$_baseUrl/carTransports/single/$id';
  static  String riderRideCancel(String id) => '$_baseUrl/carTransports/$id/cancel';
  static  String carTransportsCompleted(String id) => '$_baseUrl/carTransports/$id/completed';

  static String getCalendar(String date, String locationUuid) =>
      '$_baseUrl/calendar?date=$date&pickup_location_uuid=$locationUuid';


  static const String googleApiKey = "AIzaSyC7AoMhe2ZP3iHflCVr6a3VeL0ju0bzYVE";
}




