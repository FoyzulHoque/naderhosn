class NetworkPath{
  static const String _baseUrl="https://brother-taxi.onrender.com/api/v1";
  static const String login="${_baseUrl}/users/create-user/register";
  static const String authVerifyLogin="${_baseUrl}/auth/verify-login";

  static const String getMe = '$_baseUrl/users/get-me';
  static const String  myRides = '$_baseUrl/carTransports/my-rides';
  static const String myRidesHistory = "$_baseUrl/carTransports/my-rides-history";
  static const String updateProfile = "$_baseUrl/users/update-profile";
  static const String currentFare = "$_baseUrl/fares/current"; // GET current fare
}
class APIKeys {

  static const String stripeAPILink="https://api.stripe.com/v1/payment_intents";
  static const String stripePublishable_key= "pk_test_51S1B2KGuTKt9FvErKUcjnU9Cm1mR2RXR9biSbz0gEEk49VajT7cVFBMrNdqsfwvFCrdTMKshUXmCZnYwjG8PWkvc00pIq2BfQz";
  static const String stripeSecret_key= "sk_test_51S1B2KGuTKt9FvErd0wCR1bqr3EfClcTxtG9XkN2JbNfJszh2FB7w9rWZofvzt0KWnEG1dWpTon1qqdgMRvRPFBp00Zk0B0G6L";


  static const String stripePublishable_keys =
      "pk_test_51Qbw9kDLg7WG0GxrgsoFCAguT4cJH0zvW602k7s49MoRWyuE4xgHUqoxd82PFhYGiooV89LO3IYqniXHNtYetLv100yyfGLc6j";
  static const String stripeSecret_keys =
      "sk_test_51Qbw9kDLg7WG0GxrW1ixIFxRAuw4sMStDC4WdmQxSy1L4BNBG2Szt2RcU8wiCtbyCuzep0eySNfi85I64f6mAKF200k4MykfS8";

}