enum OrderStatus { onTheWay, searching, delivered }

class OrderModel1 {
  final String id;
  final String orderNumber;
  final String title;
  final int extraItems;
  final String pharmacyName;
  final String timeLabel;
  final OrderStatus status;
  final int? etaMinutes;

  const OrderModel1({
    required this.id,
    required this.orderNumber,
    required this.title,
    required this.pharmacyName,
    required this.timeLabel,
    required this.status,
    this.extraItems = 0,
    this.etaMinutes,
  });

  bool get isActive => status != OrderStatus.delivered;
}
