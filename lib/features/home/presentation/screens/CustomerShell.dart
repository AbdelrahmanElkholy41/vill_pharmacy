import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import '../../../auth/data/datasource/auth_local_data_source_impl.dart';
import '../../../order_status/data/dataSource/order_history_remote_dataSource_imp.dart';
import '../../../order_status/data/repoistory/order_history_repoistory.dart';
import '../../../order_status/presentation/cubit/order_history_cubit.dart';

class CustomerShell extends StatelessWidget {
  final Widget child;

  const CustomerShell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderHistoryCubit(
        OrderHistoryRepoistory(
          OrderHistoryRemoteDatasourceImp(
            Dio(),
            AuthLocalDataSourceImpl(),
          ),
        ),
      )..getOrderHistory(),
      child: child,
    );
  }
}