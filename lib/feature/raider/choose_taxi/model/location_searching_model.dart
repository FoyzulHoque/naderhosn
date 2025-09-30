class RideDataModel {
  final RidePlan ridePlan;
  final List<NearbyDriver> nearbyDrivers;

  RideDataModel({
    required this.ridePlan,
    required this.nearbyDrivers,
  });

  factory RideDataModel.fromJson(Map<String, dynamic> json) {
    return RideDataModel(
      ridePlan: RidePlan.fromJson(json['ridePlan']),
      nearbyDrivers: (json['nearbyDrivers'] as List<dynamic>)
          .map((e) => NearbyDriver.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ridePlan': ridePlan.toJson(),
      'nearbyDrivers': nearbyDrivers.map((e) => e.toJson()).toList(),
    };
  }
}

// -------------------------------------------------------------

class RidePlan {
  final String id;
  final String userId;
  final String pickup;
  final String dropOff;
  final double pickupLat;
  final double pickupLng;
  final double dropOffLat;
  final double dropOffLng;
  final int rideTime;
  final int waitingTime;
  final double distance;
  final int estimatedFare;
  final String serviceType;
  final DateTime createdAt;
  final DateTime updatedAt;

  RidePlan({
    required this.id,
    required this.userId,
    required this.pickup,
    required this.dropOff,
    required this.pickupLat,
    required this.pickupLng,
    required this.dropOffLat,
    required this.dropOffLng,
    required this.rideTime,
    required this.waitingTime,
    required this.distance,
    required this.estimatedFare,
    required this.serviceType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RidePlan.fromJson(Map<String, dynamic> json) {
    return RidePlan(
      id: json['id'] as String,
      userId: json['userId'] as String,
      pickup: json['pickup'] as String,
      dropOff: json['dropOff'] as String,
      pickupLat: json['pickupLat'] as double,
      pickupLng: json['pickupLng'] as double,
      dropOffLat: json['dropOffLat'] as double,
      dropOffLng: json['dropOffLng'] as double,
      rideTime: json['rideTime'] as int,
      waitingTime: json['waitingTime'] as int,
      distance: json['distance'] as double,
      estimatedFare: json['estimatedFare'] as int,
      serviceType: json['serviceType'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'pickup': pickup,
      'dropOff': dropOff,
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'dropOffLat': dropOffLat,
      'dropOffLng': dropOffLng,
      'rideTime': rideTime,
      'waitingTime': waitingTime,
      'distance': distance,
      'estimatedFare': estimatedFare,
      'serviceType': serviceType,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

// -------------------------------------------------------------

class NearbyDriver {
  final String id;
  final String? fullName; // Can be "null" in the JSON, so it's nullable
  final double lat;
  final double lng;
  final String vehicleId;
  final String vehicleName;
  final double distance;

  NearbyDriver({
    required this.id,
    this.fullName,
    required this.lat,
    required this.lng,
    required this.vehicleId,
    required this.vehicleName,
    required this.distance,
  });

  factory NearbyDriver.fromJson(Map<String, dynamic> json) {
    // Handle "null" string value for fullName
    final String? name = json['fullName'] as String?;

    return NearbyDriver(
      id: json['id'] as String,
      // If the string is "null" or empty, treat it as null/empty string
      fullName: (name == null || name == 'null') ? null : name,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      vehicleId: json['vehicleId'] as String,
      vehicleName: json['vehicleName'] as String,
      distance: json['distance'] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'lat': lat,
      'lng': lng,
      'vehicleId': vehicleId,
      'vehicleName': vehicleName,
      'distance': distance,
    };
  }
}