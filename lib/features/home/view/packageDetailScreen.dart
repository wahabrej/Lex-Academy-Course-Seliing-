import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageDetailScreen extends StatefulWidget {
  const PackageDetailScreen({super.key});

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Bottom Sticky Purchase Button
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {
              // Buy action
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F2C43),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
              elevation: 0,
            ),
            child: Text(
              'প্যাকেজ কিনুন',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Bar
              _buildHeader(context),
              SizedBox(height: 20.h),

              // 2. Course Title & Badges
              Text(
                '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি,ফেব্রুয়ারি',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2C43),
                  height: 1.3,
                ),
              ),
              SizedBox(height: 12.h),

              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '৳ ১০৫০',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F2F5),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      'মেয়াদ: ১৯তম ব্যাচ',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // 3. Course Overview Card
              _buildCourseOverviewCard(),
              SizedBox(height: 24.h),

              // 4. Package Benefits & Details Section
              Text(
                '১৯তম BJS প্যাকেজের সুবিধা:',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2C43),
                ),
              ),
              SizedBox(height: 12.h),

              _buildBenefitsCard(),
              SizedBox(height: 24.h),

              // 5. Routine Preview Section
              _buildRoutineSection(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Header Bar
  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        Text(
          'বিস্তারিত বিবরণ',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2C43),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              isFavorite = !isFavorite;
            });
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
              size: 20.r,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  // Course Overview Box
  Widget _buildCourseOverviewCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Course Overview',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'BJS-এর সকল পরীক্ষা ও ক্লাস + LM সাবজেক্ট কেয়ার',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2C43),
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Text(
                '৳ ১০৫০',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2C43),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '৳ ১,৮০০',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(width: 8.w),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'অফার মূল্য',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.green[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Detailed Benefits Card
  Widget _buildBenefitsCard() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Total Live Exams Banner
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: const Color(0xFF0F2C43),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.sensors, color: Colors.redAccent, size: 20.r),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'রুটিনের মোট লাইভ পরীক্ষা: ৯০টি',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Exam Breakdown Chips Grid
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              _buildExamTypeBadge('আইন বিষয়ক', '৪০ টি'),
              _buildExamTypeBadge('জেনারেল পার্ট', '৩০ টি'),
              _buildExamTypeBadge('রিভিশন', '১০ টি'),
              _buildExamTypeBadge('ফুল মডেল টেস্ট', '১০ টি'),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 12.h),

          // Features List
          _buildFeatureTile(
            icon: Icons.menu_book_rounded,
            title: 'বার ও বিজেএস জব সল্যুশন: ২৫ টি',
            subtitle: 'অথেনটিক রেফারেন্স থেকে ব্যাখ্যাসহ',
          ),
          _buildFeatureTile(
            icon: Icons.newspaper_rounded,
            title: 'সাম্প্রতিক সমাচারের পরীক্ষা',
            subtitle: 'মাসে কমপক্ষে ২ টি',
          ),
          _buildFeatureTile(
            icon: Icons.assignment_turned_in_rounded,
            title: 'প্রতি মাসে ফুল মডেল টেস্ট',
            subtitle: 'মাসে কমপক্ষে ১ টি',
          ),
          _buildFeatureTile(
            icon: Icons.inventory_2_rounded,
            title: 'আর্কাইভে প্রশ্নসংখ্যা',
            subtitle: '১৮ হাজার+',
            iconColor: Colors.amber[800],
          ),

          SizedBox(height: 12.h),
          const Divider(),
          SizedBox(height: 12.h),

          // Other Advantages
          Text(
            'অন্যান্য সুবিধা:',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2C43),
            ),
          ),
          SizedBox(height: 8.h),
          _buildBulletPoint('টপিক গুরু, কুইজ মাস্টার, স্মার্ট সার্চ, ডায়নামিক প্যানেল ইত্যাদি'),
          _buildBulletPoint('এই প্যাকেজ চলাকালীন BJS-এর অন্য কোর্স দেওয়া হলে তার Access থাকবে'),
          _buildBulletPoint('মেয়াদ: ১৯তম BJS প্রিলি পরীক্ষা বা সর্বোচ্চ ৯০ টি পরীক্ষা'),
        ],
      ),
    );
  }

  // Helper Widget: Exam Breakdown Badge
  Widget _buildExamTypeBadge(String title, String count) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$title: ',
            style: TextStyle(fontSize: 11.sp, color: Colors.grey[800]),
          ),
          Text(
            count,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2C43),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Feature Tile
  Widget _buildFeatureTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Color? iconColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: (iconColor ?? const Color(0xFF0F2C43)).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 16.r,
              color: iconColor ?? const Color(0xFF0F2C43),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF0F2C43),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget: Bullet Point
  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Icon(
              Icons.check_circle_rounded,
              size: 14.r,
              color: Colors.green,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[800],
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Routine Preview Section
  Widget _buildRoutineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.calendar_month_rounded, color: const Color(0xFF0F2C43), size: 20.r),
            SizedBox(width: 8.w),
            Text(
              'রুটিন প্রিভিউ',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F2C43),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFFC107),
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F2C43),
                    ),
                  ),
                ],
              ),
              Text(
                '16/08/2026',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Navigate to full routine
            },
            child: Text(
              'সম্পূর্ণ রুটিন দেখুন',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F2C43),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}