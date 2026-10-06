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
import '../../features/AllPackages/view/question_bank_screen.dart';
import '../../features/home/view/enrolledPackageDashboardScreen.dart';
import '../../features/auth/ReadyToGo/view/ReadyToGoScreen.dart';
import '../../features/auth/login/view/loginScreen.dart';
import '../../features/auth/signup/view/signUpScreen.dart';
import '../../features/auth/signup/view/signUpStepTwoScreen.dart';
import '../../features/home/view/allPackageScreen.dart' as home;
import '../../features/splash/onboardingScreen.dart';
import '../../features/library/view/legal_dictionary_screen.dart';

class AppRoutes {
  static Map<String, dynamic> _packageArguments(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Map<String, dynamic>) return arguments;
    throw ArgumentError(
      'A package must be selected before opening this module.',
    );
  }

  static String _requiredPackageId(BuildContext context) {
    final packageId = _packageArguments(context)['packageId'];
    if (packageId is String && packageId.isNotEmpty) return packageId;
    throw ArgumentError('The selected package is missing its ID.');
  }

  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const Splashscreen(),
    RouteName.parentScreen: (context) => const ParentScreen(),
    RouteName.allPackageScreen: (context) => const AllPackagesScreen(),
    RouteName.packageDetailScreen: (context) => const PackageDetailScreen(),
    RouteName.packageRoutineScreen: (context) => const PackageRoutineScreen(),
    RouteName.allPackageGridScreen: (context) => const home.AllPackageScreen(),
    RouteName.loginScreen: (context) => const LoginScreen(),
    RouteName.signUpScreen: (context) => const SignUpScreen(),
    RouteName.signUpStepTwoScreen: (context) => const SignUpStepTwoScreen(),
    RouteName.readyToGoScreen: (context) => const ReadyToGoScreen(),
    RouteName.onboardingScreen: (context) => const OnboardingScreen(),
    RouteName.packageScreen: (context) => const PackageScreen(),
    RouteName.liveExamScreen: (context) => const LiveExamScreen(),
    RouteName.archivescreen: (context) => const ArchiveScreen(),
    RouteName.routineScreen: (context) => RoutineScreen(
      packageId: _requiredPackageId(context),
      programType: _packageArguments(context)['program']?.toString() ?? 'bjs',
    ),
    RouteName.notesScreen: (context) => const NotesScreen(),
    RouteName.noticeScreen: (context) => NoticeScreen(
      packageId: _requiredPackageId(context),
      packageName: _packageArguments(context)['packageName']?.toString(),
    ),
    RouteName.resultScreen: (context) =>
        ResultScreen(packageId: _requiredPackageId(context)),
    RouteName.syllabusScreen: (context) => SyllabusScreen(
      packageId: _requiredPackageId(context),
      packageName: _packageArguments(context)['packageName']?.toString(),
    ),
    RouteName.dashboardScreen: (context) => DashboardScreen(
      packageId: _requiredPackageId(context),
      packageName: _packageArguments(context)['packageName']?.toString(),
    ),
    RouteName.suggestionScreen: (context) => SuggestionScreen(
      packageId: _requiredPackageId(context),
      packageName: _packageArguments(context)['packageName']?.toString(),
      programType: _packageArguments(context)['program']?.toString(),
      track: _packageArguments(context)['track']?.toString(),
    ),
    RouteName.bookReferenceScreen: (context) => BookReferenceScreen(
      packageId: _requiredPackageId(context),
      packageName: _packageArguments(context)['packageName']?.toString(),
    ),
    RouteName.legalDictionaryScreen: (context) => const LegalDictionaryScreen(),
    RouteName.enrolledPackageDashboard: (context) =>
        const EnrolledPackageDashboardScreen(),
    RouteName.questionBanks: (context) =>
        QuestionBankScreen(packageId: _requiredPackageId(context)),
  };
}
