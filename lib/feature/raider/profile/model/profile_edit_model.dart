class UpdateProfileResponse {
  final bool success;
  final String message;
  final ProfileData data;

  UpdateProfileResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      success: json['success'],
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}

class ProfileData {
  final String id;
  final String fullName;
  final String dob;
  final String gender;
  final String? nidNumber;
  final String? address;
  final String phoneNumber;
  final String? email;
  final String? city;
  final String profileImage;
  final String status;

  ProfileData({
    required this.id,
    required this.fullName,
    required this.dob,
    required this.gender,
    this.nidNumber,
    this.address,
    required this.phoneNumber,
    this.email,
    this.city,
    required this.profileImage,
    required this.status,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json['id'],
      fullName: json['fullName'] ?? '',
      dob: json['dob'] ?? '',
      gender: json['gender'] ?? '',
      nidNumber: json['nidNumber'],
      address: json['address'],
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'],
      city: json['city'],
      profileImage: json['profileImage'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
