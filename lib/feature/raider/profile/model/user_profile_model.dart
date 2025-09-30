class UserProfileModel {
  final String id;
  final String fullName;
  final String dob;
  final String gender;
  final String phoneNumber;
  final String email;
  final String address;
  final String city;
  final String? profileImage;
  final String role;
  final String status;
  final int totalRides;
  final int totalTrips;
  final int averageRating;
  final int reviewCount;
  final double totalDistance; // ✅ Added

  UserProfileModel({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.city,
    this.profileImage,
    required this.role,
    required this.status,
    required this.totalRides,
    required this.totalTrips,
    required this.averageRating,
    required this.reviewCount,
    required this.totalDistance, // ✅ Added
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json["id"] ?? "",
      fullName: json["fullName"] ?? "",
      dob: json["dob"] ?? "",
      gender: json["gender"] ?? "",
      phoneNumber: json["phoneNumber"] ?? "",
      email: json["email"] ?? "",
      address: json["address"] ?? "",
      city: json["city"] ?? "",
      profileImage: json["profileImage"],
      role: json["role"] ?? "",
      status: json["status"] ?? "",
      totalRides: json["totalRides"] ?? 0,
      totalTrips: json["totalTrips"] ?? 0,
      averageRating: json["averageRating"] ?? 0,
      reviewCount: json["reviewCount"] ?? 0,
      totalDistance: (json["totalDistance"] ?? 0).toDouble(), // ✅ Safe convert
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "fullName": fullName,
      "dob": dob,
      "gender": gender,
      "phoneNumber": phoneNumber,
      "email": email,
      "address": address,
      "city": city,
      "profileImage": profileImage,
      "role": role,
      "status": status,
      "totalRides": totalRides,
      "totalTrips": totalTrips,
      "averageRating": averageRating,
      "reviewCount": reviewCount,
      "totalDistance": totalDistance, // ✅ Added
    };
  }
}
