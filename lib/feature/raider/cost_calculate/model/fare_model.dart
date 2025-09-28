class FareModel {
  final String id;
  final double baseFare;
  final double costPerKm;
  final double costPerMin;
  final double minimumFare;
  final double waitingPerMin;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  FareModel({
    required this.id,
    required this.baseFare,
    required this.costPerKm,
    required this.costPerMin,
    required this.minimumFare,
    required this.waitingPerMin,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  /// From JSON → Model
  factory FareModel.fromJson(Map<String, dynamic> json) {
    return FareModel(
      id: json["id"] ?? "",
      baseFare: (json["baseFare"] ?? 0).toDouble(),
      costPerKm: (json["costPerKm"] ?? 0).toDouble(),
      costPerMin: (json["costPerMin"] ?? 0).toDouble(),
      minimumFare: (json["minimumFare"] ?? 0).toDouble(),
      waitingPerMin: (json["waitingPerMin"] ?? 0).toDouble(),
      isActive: json["isActive"] ?? false,
      createdAt: DateTime.tryParse(json["createdAt"] ?? "") ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? "") ?? DateTime.now(),
    );
  }
}
