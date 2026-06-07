import 'package:flutter/material.dart';
import 'package:pharmacy_app/core/routing/routes.dart';

import '../../features/auth/presentation/screens/login.dart';
import '../../features/home/presentation/screens/home.dart';
class AppRouter {
  Route generateRoute(RouteSettings settings) {
    //this arguments to be passed in any screen like this ( arguments as ClassName )
    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const Login());
        case Routes.homeScreen:
          return MaterialPageRoute(builder: (_)=> PharmacyHomeScreen(onDashboard: () {  }, onNewOrder: () {  }, onTrack: () {  },));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }



  }
}

