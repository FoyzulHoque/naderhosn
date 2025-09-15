class RideHistoryModel {
  final String id;
  final String pickupLocation;
  final String dropOffLocation;
  final double pickupLat;
  final double pickupLng;
  final double dropOffLat;
  final double dropOffLng;
  final double totalAmount;
  final String paymentMethod;
  final String paymentStatus;
  final String pickupDate;
  final String pickupTime;
  final String status;
  final String specialNotes;
  final List<String> beforePickupImages;
  final List<String> afterPickupImages;
  final String createdAt;
  final String updatedAt;

  final UserModel user;
  final VehicleModel vehicle;

  RideHistoryModel({
    required this.id,
    required this.pickupLocation,
    required this.dropOffLocation,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropOffLat,
    required this.dropOffLng,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.pickupDate,
    required this.pickupTime,
    required this.status,
    required this.specialNotes,
    required this.beforePickupImages,
    required this.afterPickupImages,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.vehicle,
  });

  factory RideHistoryModel.fromJson(Map<String, dynamic> json) {
    return RideHistoryModel(
      id: json["id"] ?? "",
      pickupLocation: json["pickupLocation"] ?? "",
      dropOffLocation: json["dropOffLocation"] ?? "",
      pickupLat: (json["pickupLat"] ?? 0).toDouble(),
      pickupLng: (json["pickupLng"] ?? 0).toDouble(),
      dropOffLat: (json["dropOffLat"] ?? 0).toDouble(),
      dropOffLng: (json["dropOffLng"] ?? 0).toDouble(),
      totalAmount: (json["totalAmount"] ?? 0).toDouble(),
      paymentMethod: json["paymentMethod"] ?? "",
      paymentStatus: json["paymentStatus"] ?? "",
      pickupDate: json["pickupDate"] ?? "",
      pickupTime: json["pickupTime"] ?? "",
      status: json["status"] ?? "",
      specialNotes: json["specialNotes"] ?? "",
      beforePickupImages: List<String>.from(json["beforePickupImages"] ?? []),
      afterPickupImages: List<String>.from(json["afterPickupImages"] ?? []),
      createdAt: json["createdAt"] ?? "",
      updatedAt: json["updatedAt"] ?? "",
      user: UserModel.fromJson(json["user"] ?? {}),
      vehicle: VehicleModel.fromJson(json["vehicle"] ?? {}),
    );
  }
}

class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String profileImage;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"] ?? "",
      fullName: json["fullName"] ?? "",
      email: json["email"] ?? "",
      profileImage: json["profileImage"] ?? "",
    );
  }
}

class VehicleModel {
  final String id;
  final String manufacturer;
  final String model;
  final String licensePlateNumber;
  final String image;
  final String color;

  VehicleModel({
    required this.id,
    required this.manufacturer,
    required this.model,
    required this.licensePlateNumber,
    required this.image,
    required this.color,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json["id"] ?? "",
      manufacturer: json["manufacturer"] ?? "",
      model: json["model"] ?? "",
      licensePlateNumber: json["licensePlateNumber"] ?? "",
      image: json["image"] ?? "",
      color: json["color"] ?? "",
    );
  }
}
