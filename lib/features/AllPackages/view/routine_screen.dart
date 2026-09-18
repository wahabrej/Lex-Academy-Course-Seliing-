import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoutineScreen extends StatelessWidget {
  const RoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context, 'Routine'),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // স্ট্যাটস রো
                  _buildStatsRow(),
                  SizedBox(height: 16.h),

                  // ফিল্টার চিপস
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildFilterChip('সবগুলো', true),
                        SizedBox(width: 8.w),
                        _buildFilterChip('স্পর্শ', false),
                        SizedBox(width: 8.w),
                        _buildFilterChip('নাকি আছে', false),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // টেক্সট
                  Center(
                    child: Text(
                      '৪৪টি ক্লাসি সেশনে হচ্ছে',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // আপকামিং কার্ড
                  _buildUpcomingCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- হেডার উইজেট ----------------
  Widget _buildHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF072B3E),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: const Color(0xFF072B3E),
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                '১৯তম বিজেএস লিখিত পরীক্ষার প্রস্তুতি',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- স্ট্যাটস রো ----------------
  Widget _buildStatsRow() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFF0A3A52), // হালকা নেভি
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('৪৯', 'মোট ক্লাস'),
          _buildStatItem('৩১', 'সম্পন্ন'),
          _buildStatItem('৪', 'বাকি আছে'),
          _buildStatItem('—', 'পরবর্তী পরীক্ষা'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.sp,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // ---------------- ফিল্টার চিপ ----------------
  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF072B3E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? const Color(0xFF072B3E) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // ---------------- আপকামিং কার্ড ----------------
  Widget _buildUpcomingCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // হালকা হলুদ
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFFFE082)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upcoming ব্যাজ
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF5B301),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              'Upcoming',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // টাইটেল
          Text(
            '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),
          // ট্যাগ রো
          Row(
            children: [
              _buildTag('আজকের পরীক্ষার লাইভ'),
              SizedBox(width: 6.w),
              _buildTag('প্রিলিমিনারি'),
            ],
          ),
          SizedBox(height: 12.h),
          // পরীক্ষার তারিখ
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey.shade700),
              SizedBox(width: 6.w),
              Text(
                'পরীক্ষা: ০ সেপ্টেম্বর ২০২৬',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // বিবরণ
          _buildBulletText('লেকচার সঞ্চার আইনসমূহ - ১০০'),
          _buildBulletText('লিখিত পরীক্ষা - ১০'),
          _buildBulletText('স্পেশাল সঞ্চার আইনসমূহ - ২৫'),
          SizedBox(height: 16.h),
          // বিস্তারিত বাটন
          SizedBox(
            width: double.infinity,
            height: 42.h,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.visibility, size: 16.sp, color: Colors.white),
              label: Text(
                'বিস্তারিত',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF072B3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFF072B3E).withOpacity(0.08),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF072B3E),
        ),
      ),
    );
  }

  Widget _buildBulletText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 6.w),
            child: Container(
              width: 4.w,
              height: 4.w,
              decoration: const BoxDecoration(
                color: Color(0xFF1A1A1A),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF1A1A1A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
