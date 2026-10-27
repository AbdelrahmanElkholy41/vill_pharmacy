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


class IncomingOrderModel {
  final String id;
  final String orderNumber;
  final String details;
  final bool hasPrescriptionImage;
  final bool isTargeted;
  final DateTime createdAt;

  final String? prescriptionImage;
  final double? price;
  final int? estimatedDeliveryMinutes;
  final String? rejectionReason;

  // بيانات العميل
  final CustomerOrderModel? customer;


  IncomingOrderModel({
    required this.id,
    required this.orderNumber,
    required this.details,
    required this.hasPrescriptionImage,
    required this.isTargeted,
    required this.createdAt,
    this.prescriptionImage,
    this.price,
    this.estimatedDeliveryMinutes,
    this.rejectionReason,
    this.customer,
  });

  factory IncomingOrderModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return IncomingOrderModel(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      details: json['details'] as String? ?? '',
      hasPrescriptionImage:
      json['hasPrescriptionImage'] as bool? ?? false,
      isTargeted: json['isTargeted'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),

      // رابط صورة الروشتة
      prescriptionImage:
      json['prescriptionImageUrl'] as String?,

      price: (json['price'] as num?)?.toDouble(),
      estimatedDeliveryMinutes:
      (json['estimatedDeliveryMinutes'] as num?)?.toInt(),
      rejectionReason: json['rejectionReason'] as String?,
      // بيانات العميل
      customer: json['customer'] is Map<String, dynamic>
          ? CustomerOrderModel.fromJson(
        json['customer'] as Map<String, dynamic>,
      )
          : null,
    );
  }
}

class CustomerOrderModel {
  final String id;
  final String fullName;
  final String phone;
  final String address;
  final CustomerLocationModel? location;
  final String? locationUrl;

  CustomerOrderModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    this.location,
    this.locationUrl,
  });

  factory CustomerOrderModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CustomerOrderModel(
      id: json['id'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      address: json['address'] as String? ?? '',
      location: json['location'] is Map<String, dynamic>
          ? CustomerLocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      )
          : null,
      locationUrl: json['locationUrl'] as String?,
    );
  }
}

class CustomerLocationModel {
  final double? lat;
  final double? lng;

  CustomerLocationModel({
    this.lat,
    this.lng,
  });

  factory CustomerLocationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return CustomerLocationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }
}
