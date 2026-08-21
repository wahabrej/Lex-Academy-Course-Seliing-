import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lexverse/core/routes/routesName.dart';

class AllPackageScreen extends StatelessWidget {
  const AllPackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildHeader(context),
              SizedBox(height: 20.h),

              // Preliminary Packages Section
              _buildSectionWrapper(
                title: 'প্রিলিমিনারি প্যাকেজ',
                subtitle: 'MCQ / Preliminary প্রস্তুতির প্যাকেজ',
                countText: '৩টি',
                child: Column(
                  children: [
                    _buildDarkPackageCard(context),
                    SizedBox(height: 16.h),
                    _buildDarkPackageCard(context),
                    SizedBox(height: 16.h),
                    _buildDarkPackageCard(context),
                  ],
                ),
              ),
              SizedBox(height: 20.h),

              // Written Packages Section
              _buildSectionWrapper(
                title: 'রিটেন প্যাকেজ',
                subtitle: 'Written exam প্রস্তুতির প্যাকেজ',
                countText: '১ টি',
                child: _buildYellowPackageCard(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Header Widget
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18.r,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BJS Packages',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2C43),
                  ),
                ),
                Text(
                  'Bangladesh Judicial Service',
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.notifications_none_rounded,
            size: 20.r,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  // Section Wrapper Widget (Grey Background Block)
  Widget _buildSectionWrapper({
    required String title,
    required String subtitle,
    required String countText,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F7),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2C43),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  countText,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }

  // Dark Package Card (Preliminary)
  Widget _buildDarkPackageCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0B253A),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'BJS - Preliminary',
                  style: TextStyle(
                    color: const Color(0xFF0B253A),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.shield,
                    color: const Color(0xFFFFC107),
                    size: 14.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Premium',
                    style: TextStyle(
                      color: const Color(0xFFFFC107),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Title
          Text(
            '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি,ফেব্রুয়ারি',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12.h),

          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '৳ ১০৫০',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                '/ সম্পূর্ণ প্যাকেজ',
                style: TextStyle(color: Colors.white70, fontSize: 11.sp),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Buttons
          _buildOutlineButton(
            context: context,
            title: 'বিস্তারিত',
            onTap: () {
              Navigator.pushNamed(context, RouteName.packageDetailScreen);
            },
          ),
          SizedBox(height: 8.h),
          _buildOutlineButton(
            context: context,
            title: 'রুটিন',
            onTap: () {
              Navigator.pushNamed(context, RouteName.packageRoutineScreen);
            },
          ),
          SizedBox(height: 8.h),
          _buildFilledButton(
            title: 'প্যাকেজে প্রবেশ করুন',
            bgColor: const Color(0xFFFFC107),
            textColor: Colors.black,
            onTap: () {
              Navigator.pushNamed(context, RouteName.allPackageGridScreen);
            },
          ),
        ],
      ),
    );
  }

  // Yellow Package Card (Written)
  Widget _buildYellowPackageCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFFC107),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Badge Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  'BJS - Written',
                  style: TextStyle(
                    color: const Color(0xFF0B253A),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.shield,
                    color: const Color(0xFF0B253A),
                    size: 14.r,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    'Premium',
                    style: TextStyle(
                      color: const Color(0xFF0B253A),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Title
          Text(
            '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি,ফেব্রুয়ারি',
            style: TextStyle(
              color: const Color(0xFF0B253A),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          SizedBox(height: 12.h),

          // Price
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '৳ ২০০০',
                style: TextStyle(
                  color: const Color(0xFF0B253A),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 6.w),
              Text(
                '/ সম্পূর্ণ প্যাকেজ',
                style: TextStyle(
                  color: const Color(0xFF0B253A).withValues(alpha: 0.8),
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // Buttons
          _buildOutlineButton(
            title: 'বিস্তারিত',
            borderColor: const Color(0xFF0B253A),
            textColor: const Color(0xFF0B253A),
            onTap: () {},
          ),
          SizedBox(height: 8.h),
          _buildFilledButton(
            title: 'প্যাকেজে প্রবেশ করুন',
            bgColor: const Color(0xFF0B253A),
            textColor: Colors.white,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  // Helper Widget: Outline Button with Arrow
  Widget _buildOutlineButton({
    BuildContext? context,
    required String title,
    Color borderColor = Colors.white38,
    Color textColor = Colors.white,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 38.h,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor, width: 1.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.arrow_forward, color: textColor, size: 14.r),
          ],
        ),
      ),
    );
  }

  // Helper Widget: Filled Button with Arrow
  Widget _buildFilledButton({
    required String title,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 38.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.arrow_forward, color: textColor, size: 14.r),
          ],
        ),
      ),
    );
  }
}
