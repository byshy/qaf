import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qaf/features/Auth/auth_provider.dart';
import 'package:qaf/features/Auth/complete_acc.dart';
import 'package:qaf/features/Auth/login_screen.dart';
import 'package:qaf/features/Auth/otp.dart';
import 'package:qaf/features/home/home_provider.dart';
import 'package:qaf/features/home/home_screen.dart';
import 'package:qaf/features/pre_app/pre_app_provider.dart';
import 'package:qaf/features/pre_app/pre_app_screen.dart';

import '../../di.dart';
import 'routes.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case preAppScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: preAppScreen),
          builder: (_) => ChangeNotifierProvider.value(
            child: const PreAppScreen(),
            value: sl<PreAppProvider>(),
          ),
        );
      case loginScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: loginScreen),
          builder: (_) => ChangeNotifierProvider.value(
            child: const LoginScreen(),
            value: sl<AuthProvider>(),
          ),
        );
      case completeAccountScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: completeAccountScreen),
          builder: (_) => ChangeNotifierProvider.value(
            child: const CompleteAccountScreen(),
            value: sl<AuthProvider>(),
          ),
        );
      case otpScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: otpScreen),
          builder: (_) => ChangeNotifierProvider.value(
            child: const OTP(),
            value: sl<AuthProvider>(),
          ),
        );
      case homeScreen:
        return MaterialPageRoute(
          settings: const RouteSettings(name: homeScreen),
          builder: (_) => ChangeNotifierProvider.value(
            child: const HomeScreen(),
            value: sl<HomeProvider>(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
