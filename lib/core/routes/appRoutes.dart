import 'package:flutter/material.dart';
import 'package:lexverse/core/routes/routesName.dart';
import 'package:lexverse/features/parentScreen/screen/parent_screen.dart';
import 'package:lexverse/features/splash/splashScreen.dart';

import '../../features/AllPackages/view/AllPackagesScreen.dart';
import '../../features/AllPackages/view/PackageDetailScreen.dart';
import '../../features/AllPackages/view/PackageRoutineScreen.dart';
import '../../features/AllPackages/view/archive_screen.dart';
import '../../features/AllPackages/view/book_reference_screen.dart';
import '../../features/AllPackages/view/dashboard_screen.dart';
import '../../features/AllPackages/view/live_exam_screen.dart';
import '../../features/AllPackages/view/notes_screen.dart';
import '../../features/AllPackages/view/notice_screen.dart';
import '../../features/AllPackages/view/package_screen.dart';
import '../../features/AllPackages/view/result_screen.dart';
import '../../features/AllPackages/view/routine_screen.dart';
import '../../features/AllPackages/view/suggestion_screen.dart';
import '../../features/AllPackages/view/syllabus_screen.dart';
import '../../features/auth/ReadyToGo/view/ReadyToGoScreen.dart';
import '../../features/auth/login/view/loginScreen.dart';
import '../../features/auth/signup/view/signUpScreen.dart';
import '../../features/home/view/allPackageDetailScreen.dart';
import '../../features/home/view/allPackageScreen.dart' as home;
import '../../features/home/view/packageDetailScreen.dart' as home_detail;
import '../../features/home/view/packageRoutingScreen.dart' as home_routing;
import '../../features/splash/onboardingScreen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const Splashscreen(),
    RouteName.parentScreen: (context) => const ParentScreen(),
    RouteName.allPackageScreen: (context) => const AllPackagesScreen(),
    RouteName.packageDetailScreen: (context) => const PackageDetailScreen(),
    RouteName.packageRoutineScreen: (context) => const PackageRoutineScreen(),
    RouteName.allPackageGridScreen: (context) => const home.AllPackageScreen(),
    RouteName.loginScreen: (context) => const LoginScreen(),
    RouteName.signUpScreen: (context) => const SignUpScreen(),
    RouteName.readyToGoScreen: (context) => const ReadyToGoScreen(),
    RouteName.onboardingScreen: (context) => const OnboardingScreen(),
    RouteName.packageScreen: (context) => const PackageScreen(),
    RouteName.liveExamScreen: (context) => const LiveExamScreen(),
    RouteName.archivescreen: (context) => const ArchiveScreen(),
    RouteName.routineScreen: (context) => const RoutineScreen(),
    RouteName.notesScreen: (context) => const NotesScreen(),
    RouteName.noticeScreen: (context) => const NoticeScreen(),
    RouteName.resultScreen: (context) => const ResultScreen(),
    RouteName.syllabusScreen: (context) => const SyllabusScreen(),
    RouteName.dashboardScreen: (context) => const DashboardScreen(),
    RouteName.suggestionScreen: (context) => const SuggestionScreen(),
    RouteName.bookReferenceScreen: (context) => const BookReferenceScreen(),
  };
}
