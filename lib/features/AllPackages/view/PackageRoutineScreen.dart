import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageRoutineScreen extends StatelessWidget {
  const PackageRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context, 'এই প্যাকেজের রুটিন'),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- Active সেকশন ----------------
                  _buildSectionHeader(
                    title: 'Active',
                    count: '১',
                    icon: Icons.calendar_today,
                  ),
                  SizedBox(height: 12.h),
                  _buildRoutineCard(),
                  SizedBox(height: 24.h),

                  // ---------------- Archived সেকশন ----------------
                  _buildSectionHeader(
                    title: 'Archived',
                    count: '৩টি',
                    icon: Icons.archive_outlined,
                  ),
                  SizedBox(height: 12.h),
                  _buildRoutineCard(),
                  SizedBox(height: 16.h),
                  _buildRoutineCard(),
                  SizedBox(height: 16.h),
                  _buildRoutineCard(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- হেডার ----------------
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
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- সেকশন হেডার ----------------
  Widget _buildSectionHeader({
    required String title,
    required String count,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: const Color(0xFF072B3E)),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF5B301),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              count,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- রুটিন কার্ড ----------------
  Widget _buildRoutineCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active ব্যাজ
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9), // হালকা সবুজ
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: const Color(0xFF4CAF50).withOpacity(0.3)),
              ),
              child: Text(
                'Active',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2E7D32),
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
                _buildTag('আজকের লাইভ ক্লাস'),
                SizedBox(width: 6.w),
                _buildTag('প্রিলিমিনারি'),
              ],
            ),
            SizedBox(height: 12.h),

            // পরীক্ষা রো
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14.sp, color: Colors.grey.shade600),
                SizedBox(width: 6.w),
                Text(
                  'পরীক্ষা: ১৪ আগস্ট ২০২৬',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF1A1A1A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),

            // বিবরণ
            Text(
              'বিষয়সমূহ: প্রিলিমিনারি',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'সময়: ১০:০০ টা',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'স্থান/লিংক: অনলাইন',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 16.h),

            // বিস্তারিত বাটন
            SizedBox(
              width: double.infinity,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF5B301),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'বিস্তারিত',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF072B3E),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward,
                      size: 14.sp,
                      color: const Color(0xFF072B3E),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- ট্যাগ হেল্পার ----------------
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
}
