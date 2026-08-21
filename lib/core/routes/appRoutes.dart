import 'package:flutter/material.dart';
import 'package:lexverse/core/routes/routesName.dart';
import 'package:lexverse/features/parentScreen/screen/parent_screen.dart';
import 'package:lexverse/features/splash/splashScreen.dart';

import '../../features/auth/ReadyToGo/view/ReadyToGoScreen.dart';
import '../../features/auth/login/view/loginScreen.dart';
import '../../features/auth/signup/view/signUpScreen.dart';
import '../../features/home/view/allPackageDetailScreen.dart';
import '../../features/home/view/allPackageScreen.dart';
import '../../features/home/view/packageDetailScreen.dart';
import '../../features/home/view/packageRoutingScreen.dart';
import '../../features/splash/onboardingScreen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const Splashscreen(),
    RouteName.parentScreen: (context) => const ParentScreen(),
    RouteName.allPackageScreen: (context) => const AllPackageScreen(),
    RouteName.packageDetailScreen: (context) => const PackageDetailScreen(),
    RouteName.packageRoutineScreen: (context) => const PackageRoutineScreen(),
    RouteName.allPackageGridScreen: (context) => const AllPackageGridScreen(),
    RouteName.loginScreen: (context) => const LoginScreen(),
    RouteName.signUpScreen: (context) => const SignUpScreen(),
    RouteName.readyToGoScreen: (context) => const ReadyToGoScreen(),
    RouteName.onboardingScreen: (context) => const OnboardingScreen(),
  };
}
