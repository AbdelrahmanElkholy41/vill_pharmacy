import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/routing/routes.dart';

import '../../features/auth/presentation/screens/login.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard.dart';
import '../../features/home/presentation/screens/home.dart';
import '../../features/new_order/presentation/screens/new_order.dart';
import '../../features/order_status/presentation/screens/order_status.dart';
import '../helpers/extensions.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => Login());
      case Routes.homeScreen:
        return MaterialPageRoute(
            builder: (_) => PharmacyHomeScreen(
                  onDashboard: () {},
                  onNewOrder: () {},
                  onTrack: () {},
                ));
      case Routes.registrationScreen:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case Routes.dashboardScreen:
        return MaterialPageRoute(
            builder: (_) => PharmacyDashboardScreen(
                  onBack: () {
                    Navigator.pop(_);
                  },
                ));

      case Routes.track:
        return MaterialPageRoute(
            builder: (_) => OrderStatusScreen(
                  onBack: () {
                    Navigator.pop(_);
                  },
                ));

      case Routes.newOrder:
        return MaterialPageRoute(
            builder: (_) => NewOrderScreen(
                  onBack: () {
                    Navigator.pop(_);
                  },
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
