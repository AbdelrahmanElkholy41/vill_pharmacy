
class OrderHistoryModel {
  final String id;
  final String orderNumber;
  final String customerId;
  final String? targetPharmacyId;
  final String? acceptedPharmacyId;
  final String? acceptedBy;
  final String details;
  final String? prescriptionImageUrl;
  final bool hasPrescriptionImage;
  final String status;
  final double? price;
  final String currency;
  final int? estimatedDeliveryMinutes;
  final String? rejectionReason;
  final DateTime? acceptedAt;
  final DateTime? preparingAt;
  final DateTime? deliveredAt;
  final DateTime? rejectedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderHistoryModel({
    required this.id,
    required this.orderNumber,
    required this.customerId,
    required this.targetPharmacyId,
    required this.acceptedPharmacyId,
    required this.acceptedBy,
    required this.details,
    required this.prescriptionImageUrl,
    required this.hasPrescriptionImage,
    required this.status,
    required this.price,
    required this.currency,
    required this.estimatedDeliveryMinutes,
    required this.rejectionReason,
    required this.acceptedAt,
    required this.preparingAt,
    required this.deliveredAt,
    required this.rejectedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    return OrderHistoryModel(
      id: json['id'] as String,
      orderNumber: json['orderNumber'] as String,
      customerId: json['customerId'] as String,
      targetPharmacyId: json['targetPharmacyId'] as String?,
      acceptedPharmacyId: json['acceptedPharmacyId'] as String?,
      acceptedBy: json['acceptedBy'] as String?,
      details: json['details'] as String? ?? '',
      prescriptionImageUrl: json['prescriptionImageUrl'] as String?,
      hasPrescriptionImage:
      json['hasPrescriptionImage'] as bool? ?? false,
      status: json['status'] as String? ?? 'pending',
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String? ?? 'EGP',
      estimatedDeliveryMinutes:
      (json['estimatedDeliveryMinutes'] as num?)?.toInt(),
      rejectionReason: json['rejectionReason'] as String?,
      acceptedAt: _parseDate(json['acceptedAt']),
      preparingAt: _parseDate(json['preparingAt']),
      deliveredAt: _parseDate(json['deliveredAt']),
      rejectedAt: _parseDate(json['rejectedAt']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    return DateTime.parse(value as String);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orderNumber': orderNumber,
      'customerId': customerId,
      'targetPharmacyId': targetPharmacyId,
      'acceptedPharmacyId': acceptedPharmacyId,
      'acceptedBy': acceptedBy,
      'details': details,
      'prescriptionImageUrl': prescriptionImageUrl,
      'hasPrescriptionImage': hasPrescriptionImage,
      'status': status,
      'price': price,
      'currency': currency,
      'estimatedDeliveryMinutes': estimatedDeliveryMinutes,
      'rejectionReason': rejectionReason,
      'acceptedAt': acceptedAt?.toIso8601String(),
      'preparingAt': preparingAt?.toIso8601String(),
      'deliveredAt': deliveredAt?.toIso8601String(),
      'rejectedAt': rejectedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
