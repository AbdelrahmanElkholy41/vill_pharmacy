import 'dart:io';

class CreateOrderRequestModel {
  final String details;
  final String? pharmacyId;
  final File? prescriptionImage;

  CreateOrderRequestModel({
    required this.details,
    this.pharmacyId,
    this.prescriptionImage,
  });
}

class OrderModel {
  final String id;
  final String details;
  final String status;
  final String customerId;
  final String? pharmacyId;
  final String? prescriptionImage;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.details,
    required this.status,
    required this.customerId,
    this.pharmacyId,
    this.prescriptionImage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json["id"],
      details: json["details"],
      status: json["status"],
      customerId: json["customerId"],
      pharmacyId: json["pharmacyId"],
      prescriptionImage: json["prescriptionImage"],
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
    );
  }
}