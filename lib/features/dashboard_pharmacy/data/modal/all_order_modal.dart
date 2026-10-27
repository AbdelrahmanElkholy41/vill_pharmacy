class AllOrderModal {
  final String id;
  final String orderNumber;
  final String status;
  final StatusLabel statusLabel;
  final String details;
  final bool hasPrescriptionImage;
  final String? prescriptionImageUrl;
  final bool isTargeted;
  final double? price;
  final String currency;
  final int? estimatedDeliveryMinutes;
  final String? rejectionReason;
  final CustomerModel customer;
  final DateTime? acceptedAt;
  final DateTime? preparingAt;
  final DateTime? deliveredAt;
  final DateTime? rejectedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const AllOrderModal({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.statusLabel,
    required this.details,
    required this.hasPrescriptionImage,
    required this.prescriptionImageUrl,
    required this.isTargeted,
    required this.price,
    required this.currency,
    required this.estimatedDeliveryMinutes,
    required this.rejectionReason,
    required this.customer,
    required this.acceptedAt,
    required this.preparingAt,
    required this.deliveredAt,
    required this.rejectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AllOrderModal.fromJson(Map<String, dynamic> json) {
    return AllOrderModal(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      status: json['status'] as String,
      statusLabel: StatusLabel.fromJson(
        json['statusLabel'] as Map<String, dynamic>,
      ),
      details: json['details'] as String,
      hasPrescriptionImage: json['hasPrescriptionImage'] as bool? ?? false,
      prescriptionImageUrl: json['prescriptionImageUrl'] as String?,
      isTargeted: json['isTargeted'] as bool? ?? false,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'EGP',
      estimatedDeliveryMinutes:
      (json['estimatedDeliveryMinutes'] as num?)?.toInt(),
      rejectionReason: json['rejectionReason'] as String?,
      customer: CustomerModel.fromJson(
        json['customer'] as Map<String, dynamic>,
      ),
      acceptedAt: _parseDate(json['acceptedAt']),
      preparingAt: _parseDate(json['preparingAt']),
      deliveredAt: _parseDate(json['deliveredAt']),
      rejectedAt: _parseDate(json['rejectedAt']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'status': status,
      'statusLabel': statusLabel.toJson(),
      'details': details,
      'hasPrescriptionImage': hasPrescriptionImage,
      'prescriptionImageUrl': prescriptionImageUrl,
      'isTargeted': isTargeted,
      'price': price,
      'currency': currency,
      'estimatedDeliveryMinutes': estimatedDeliveryMinutes,
      'rejectionReason': rejectionReason,
      'customer': customer.toJson(),
      'acceptedAt': acceptedAt?.toIso8601String(),
      'preparingAt': preparingAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'rejectedAt': rejectedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.parse(value as String);
  }
}

class StatusLabel {
  final String ar;
  final String en;

  const StatusLabel({
    required this.ar,
    required this.en,
  });

  factory StatusLabel.fromJson(Map<String, dynamic> json) {
    return StatusLabel(
      ar: json['ar'] as String,
      en: json['en'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ar': ar,
      'en': en,
    };
  }
}

class CustomerModel {
  final String id;
  final String fullName;
  final String phone;
  final String? address;
  final CustomerLocation? location;
  final String? locationUrl;

  const CustomerModel({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.address,
    required this.location,
    required this.locationUrl,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phone: json['phone'] as String,
      address: json['address'] as String?,
      location: json['location'] == null
          ? null
          : CustomerLocation.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      locationUrl: json['locationUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'phone': phone,
      'address': address,
      'location': location?.toJson(),
      'locationUrl': locationUrl,
    };
  }
}

class CustomerLocation {
  final double lat;
  final double lng;

  const CustomerLocation({
    required this.lat,
    required this.lng,
  });

  factory CustomerLocation.fromJson(Map<String, dynamic> json) {
    return CustomerLocation(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}