import 'dart:convert';

import 'location_searching_model.dart';
// Assuming NearbyDriverModel is in the same file or import it
// import 'nearby_driver_model.dart'; // If in a separate file

class RidePlan2 {
  final String? id;
  final String? userId;
  final String? pickup;
  final String? pickupDate;
  final String? pickupTime;
  final String? dropOff;
  final double? pickupLat;
  final double? pickupLng;
  final double? dropOffLat;
  final double? dropOffLng;
  final int? rideTime;
  final int? waitingTime;
  final double? distance;
  final int? estimatedFare;
  final String? serviceType;
  final String? createdAt;
  final String? updatedAt;

  final List<NearbyDriver>? availableDrivers;

  final List<CarTransport>? carTransport;

  RidePlan2({
    this.id,
    this.userId,
    this.pickup,
    this.pickupDate,
    this.pickupTime,
    this.dropOff,
    this.pickupLat,
    this.pickupLng,
    this.dropOffLat,
    this.dropOffLng,
    this.rideTime,
    this.waitingTime,
    this.distance,
    this.estimatedFare,
    this.serviceType,
    this.createdAt,
    this.updatedAt,
    this.availableDrivers,
    this.carTransport,
  });

  factory RidePlan2.fromJson(Map<String, dynamic> json) {
    List<NearbyDriver>? parsedAvailableDrivers;
    if (json['nearbyDrivers'] != null && json['nearbyDrivers'] is List) {
      parsedAvailableDrivers = (json['nearbyDrivers'] as List<dynamic>)
          .map((e) => NearbyDriver.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    List<CarTransport>? parsedCarTransport;
    if (json['carTransport'] != null && json['carTransport'] is List) {
      parsedCarTransport = (json['carTransport'] as List<dynamic>)
          .map((e) => CarTransport.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return RidePlan2(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      pickup: json['pickup'] as String?,
      pickupDate: json['pickupDate'] as String?,
      pickupTime: json['pickupTime'] as String?,
      dropOff: json['dropOff'] as String?,
      pickupLat: (json['pickupLat'] as num?)?.toDouble(),
      pickupLng: (json['pickupLng'] as num?)?.toDouble(),
      dropOffLat: (json['dropOffLat'] as num?)?.toDouble(),
      dropOffLng: (json['dropOffLng'] as num?)?.toDouble(),
      rideTime: json['rideTime'] as int?,
      waitingTime: json['waitingTime'] as int?,
      distance: (json['distance'] as num?)?.toDouble(),
      estimatedFare: json['estimatedFare'] as int?,
      serviceType: json['serviceType'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      availableDrivers: parsedAvailableDrivers,
      carTransport: parsedCarTransport,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "pickup": pickup,
      "pickupDate": pickupDate,
      "pickupTime": pickupTime,
      "dropOff": dropOff,
      "pickupLat": pickupLat,
      "pickupLng": pickupLng,
      "dropOffLat": dropOffLat,
      "dropOffLng": dropOffLng,
      "rideTime": rideTime,
      "waitingTime": waitingTime,
      "distance": distance,
      "estimatedFare": estimatedFare,
      "serviceType": serviceType,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "availableDrivers": availableDrivers?.map((e) => e.toJson()).toList(),
      "carTransport": carTransport?.map((e) => e.toJson()).toList(),
    };
  }

  static List<RidePlan2> listFromJson(String str) =>
      List<RidePlan2>.from(json.decode(str).map((x) => RidePlan2.fromJson(x as Map<String,dynamic>)));

  static String listToJson(List<RidePlan2> data) =>
      json.encode(data.map((x) => x.toJson()).toList());
}

class CarTransport {
  final String? id;
  final String? userId;
  final String? vehicleId;
  final String? pickupLocation;
  final String? dropOffLocation;
  final double? pickupLat;
  final double? pickupLng;
  final double? dropOffLat;
  final double? dropOffLng;
  final double? driverLat;
  final double? driverLng;
  final int? totalAmount;
  final double? distance;
  final int? platformFee;
  final String? platformFeeType;
  final String? paymentMethod;
  final String? paymentStatus;
  final bool? isPayment;
  final String? pickupDate;
  final String? pickupTime;
  final int? rideTime;
  final int? waitingTime;
  final String? status;
  final String? assignedDriver;
  final String? assignedDriverReqStatus;
  final bool? isDriverReqCancel;
  final bool? arrivalConfirmation;
  final bool? journeyStarted;
  final bool? journeyCompleted;
  final String? serviceType;
  final String? specialNotes;
  final List<dynamic>? beforePickupImages;
  final List<dynamic>? afterPickupImages;
  final String? cancelReason;
  final String? createdAt;
  final String? updatedAt;
  final String? ridePlanId;

  CarTransport({
    this.id,
    this.userId,
    this.vehicleId,
    this.pickupLocation,
    this.dropOffLocation,
    this.pickupLat,
    this.pickupLng,
    this.dropOffLat,
    this.dropOffLng,
    this.driverLat,
    this.driverLng,
    this.totalAmount,
    this.distance,
    this.platformFee,
    this.platformFeeType,
    this.paymentMethod,
    this.paymentStatus,
    this.isPayment,
    this.pickupDate,
    this.pickupTime,
    this.rideTime,
    this.waitingTime,
    this.status,
    this.assignedDriver,
    this.assignedDriverReqStatus,
    this.isDriverReqCancel,
    this.arrivalConfirmation,
    this.journeyStarted,
    this.journeyCompleted,
    this.serviceType,
    this.specialNotes,
    this.beforePickupImages,
    this.afterPickupImages,
    this.cancelReason,
    this.createdAt,
    this.updatedAt,
    this.ridePlanId,
  });

  factory CarTransport.fromJson(Map<String, dynamic> json) {
    return CarTransport(
      id: json['id'] as String?,
      userId: json['userId'] as String?,
      vehicleId: json['vehicleId'] as String?,
      pickupLocation: json['pickupLocation'] as String?,
      dropOffLocation: json['dropOffLocation'] as String?,
      pickupLat: (json['pickupLat'] as num?)?.toDouble(),
      pickupLng: (json['pickupLng'] as num?)?.toDouble(),
      dropOffLat: (json['dropOffLat'] as num?)?.toDouble(),
      dropOffLng: (json['dropOffLng'] as num?)?.toDouble(),
      driverLat: (json['driverLat'] as num?)?.toDouble(),
      driverLng: (json['driverLng'] as num?)?.toDouble(),
      totalAmount: json['totalAmount'] as int?,
      distance: (json['distance'] as num?)?.toDouble(),
      platformFee: json['platformFee'] as int?,
      platformFeeType: json['platformFeeType'] as String?,
      paymentMethod: json['paymentMethod'] as String?,
      paymentStatus: json['paymentStatus'] as String?,
      isPayment: json['isPayment'] as bool?,
      pickupDate: json['pickupDate'] as String?,
      pickupTime: json['pickupTime'] as String?,
      rideTime: json['rideTime'] as int?,
      waitingTime: json['waitingTime'] as int?,
      status: json['status'] as String?,
      assignedDriver: json['assignedDriver'] as String?,
      assignedDriverReqStatus: json['assignedDriverReqStatus'] as String?,
      isDriverReqCancel: json['isDriverReqCancel'] as bool?,
      arrivalConfirmation: json['arrivalConfirmation'] as bool?,
      journeyStarted: json['journeyStarted'] as bool?,
      journeyCompleted: json['journeyCompleted'] as bool?,
      serviceType: json['serviceType'] as String?,
      specialNotes: json['specialNotes'] as String?,
      beforePickupImages: json['beforePickupImages'] as List<dynamic>?,
      afterPickupImages: json['afterPickupImages'] as List<dynamic>?,
      cancelReason: json['cancelReason'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      ridePlanId: json['ridePlanId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "vehicleId": vehicleId,
      "pickupLocation": pickupLocation,
      "dropOffLocation": dropOffLocation,
      "pickupLat": pickupLat,
      "pickupLng": pickupLng,
      "dropOffLat": dropOffLat,
      "dropOffLng": dropOffLng,
      "driverLat": driverLat,
      "driverLng": driverLng,
      "totalAmount": totalAmount,
      "distance": distance,
      "platformFee": platformFee,
      "platformFeeType": platformFeeType,
      "paymentMethod": paymentMethod,
      "paymentStatus": paymentStatus,
      "isPayment": isPayment,
      "pickupDate": pickupDate,
      "pickupTime": pickupTime,
      "rideTime": rideTime,
      "waitingTime": waitingTime,
      "status": status,
      "assignedDriver": assignedDriver,
      "assignedDriverReqStatus": assignedDriverReqStatus,
      "isDriverReqCancel": isDriverReqCancel,
      "arrivalConfirmation": arrivalConfirmation,
      "journeyStarted": journeyStarted,
      "journeyCompleted": journeyCompleted,
      "serviceType": serviceType,
      "specialNotes": specialNotes,
      "beforePickupImages": beforePickupImages,
      "afterPickupImages": afterPickupImages,
      "cancelReason": cancelReason,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "ridePlanId": ridePlanId,
    };
  }
}