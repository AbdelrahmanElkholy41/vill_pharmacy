import 'package:pharmacy_app/features/dashboard_pharmacy/data/modal/all_order_modal.dart';

abstract class AllOrderRemoteDatasource {
  Future<List<AllOrderModal>> getAllOrders();

}