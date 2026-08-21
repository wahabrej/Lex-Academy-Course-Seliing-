import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:lexverse/core/routes/routesName.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteName.onboardingScreen);
      }
    });
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
