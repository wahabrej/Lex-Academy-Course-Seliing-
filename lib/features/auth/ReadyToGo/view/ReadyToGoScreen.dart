import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lexverse/core/routes/routesName.dart';

class ReadyToGoScreen extends StatelessWidget {
  const ReadyToGoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF082A42),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // 1. App Logo Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/splash.png',
                    width: 180.w,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.balance_rounded,
                          color: const Color(0xFFFFC107),
                          size: 32.r,
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Image.asset(
                'assets/icons/readytogo.png',
                height: 200.h,
                width: 200.w,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 180.r,
                  height: 180.r,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC3E0FA),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 100.r,
                      height: 120.r,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Icon(
                        Icons.check_circle,
                        color: const Color(0xFF29B6F6),
                        size: 48.r,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40.h),

              // 3. Title Text
              Text(
                'You are all Set!',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),

              SizedBox(height: 12.h),

              // 4. Subtitle Text
              Text(
                'Start learning and unlock your potential.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.5.sp, color: Colors.white70),
              ),

              const Spacer(flex: 3),

              // 5. Action Button (Lets Start)
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.parentScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC107),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: Text(
                    'Lets Start',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
