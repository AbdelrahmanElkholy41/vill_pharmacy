/// حالة المنتج في رحلة التوصيل
enum DeliveryState { onTheWay, delivered }

/// موديل تجريبي بسيط — استبدله لاحقًا بالموديل الحقيقي
class DeliveryItem {
  final String productName;
  final String quantity; // مثال: "2 علبة"
  final String orderNumber;
  final String customerName;

  /// للـ onTheWay: الوقت المتوقع للوصول. للـ delivered: تاريخ/وقت التوصيل
  final String timeLabel;
  final DeliveryState state;

  const DeliveryItem({
    required this.productName,
    required this.quantity,
    required this.orderNumber,
    required this.customerName,
    required this.timeLabel,
    required this.state,
  });

  /// بيانات تجريبية ثابتة للعرض فقط
  static const List<DeliveryItem> mock = [
    DeliveryItem(
      productName: 'بانادول اكسترا',
      quantity: '2 علبة',
      orderNumber: '#ORD-12345',
      customerName: 'أحمد محمد',
      timeLabel: 'الوصول المتوقع: اليوم 4:30 م',
      state: DeliveryState.onTheWay,
    ),
    DeliveryItem(
      productName: 'فيتامين د - 5000 وحدة',
      quantity: '1 علبة',
      orderNumber: '#ORD-12340',
      customerName: 'منى السيد',
      timeLabel: 'الوصول المتوقع: اليوم 6:00 م',
      state: DeliveryState.onTheWay,
    ),
    DeliveryItem(
      productName: 'أوجمنتين 1 جم',
      quantity: '3 علب',
      orderNumber: '#ORD-12301',
      customerName: 'محمود علي',
      timeLabel: 'تم التوصيل: 2024-01-14',
      state: DeliveryState.delivered,
    ),
    DeliveryItem(
      productName: 'كونجستال شراب',
      quantity: '1 زجاجة',
      orderNumber: '#ORD-12298',
      customerName: 'سارة إبراهيم',
      timeLabel: 'تم التوصيل: 2024-01-10',
      state: DeliveryState.delivered,
    ),
  ];
}
