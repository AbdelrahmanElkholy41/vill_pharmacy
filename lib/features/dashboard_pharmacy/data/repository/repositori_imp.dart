import '../dataSource/all_order_remote_datasource_imp.dart';
import '../modal/all_order_modal.dart';

class RepositoriImp {
  final AllOrderRemoteDatasourceImp allOrderRemoteDatasourceImp ;
  RepositoriImp(this.allOrderRemoteDatasourceImp);
  Future<List<AllOrderModal>> getAllOrders() async {
    return await allOrderRemoteDatasourceImp.getAllOrders();
  }

}

