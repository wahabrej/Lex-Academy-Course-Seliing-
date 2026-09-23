import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:lexverse/core/routes/routesName.dart';
import '../../core/constant/TokenStorage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final AppStorage _storage = AppStorage();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final bool loggedIn = await _storage.isLoggedIn();
    if (loggedIn) {
      Navigator.pushReplacementNamed(context, RouteName.parentScreen);
    } else {
      Navigator.pushReplacementNamed(context, RouteName.onboardingScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF082A42),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Logo Box
              Image.asset(
                "assets/icons/splash.png",
                height: 220.h,
                width: 220.w,

                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.balance_rounded,
                  color: const Color(0xFFFFC107),
                  size: 80.r,
                ),
              ),

              SizedBox(height: 24.h),

              const Spacer(),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }
}
