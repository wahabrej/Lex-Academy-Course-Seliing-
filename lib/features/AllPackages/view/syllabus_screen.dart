import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SyllabusScreen extends StatelessWidget {
  const SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context, 'Syllabus'),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // টাইটেল
                    Text(
                      'BJS-এর সকল পরীক্ষা ও ক্লাস + LM লাইভ ক্লাস',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // প্রাইস
                    Text(
                      '৳ 600',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF5B301),
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // সাব-টাইটেল
                    Text(
                      '১৪তম BJS প্যাকেজের সুবিধা:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // ---------------- পরীক্ষা সেকশন ----------------
                    _buildSectionTitle('পরীক্ষা:'),
                    SizedBox(height: 8.h),
                    _buildBulletText('লাইভ লাইভ পরীক্ষা: ১০টি'),
                    _buildBulletText('প্রিলি মডেল টেস্ট: ৫০টি'),
                    _buildBulletText('সাবজেক্ট ভিত্তিক পরীক্ষা: ১০টি'),
                    _buildBulletText('মডেল টেস্ট: ১০টি'),
                    _buildBulletText('সাবজেক্ট ভিত্তিক পরীক্ষা: ১০টি'),
                    SizedBox(height: 16.h),

                    // ---------------- আরও সুবিধা ----------------
                    _buildSectionTitle('আরও সুবিধা:'),
                    SizedBox(height: 8.h),
                    _buildBulletText('টপিক ভিত্তিক ক্লাস'),
                    _buildBulletText('রিভিশন ক্লাস'),
                    _buildBulletText('প্রশ্ন সমাধান ক্লাস'),
                    _buildBulletText('হ্যান্ডনোট'),
                    _buildBulletText('সকল লেকচার শিট'),
                    _buildBulletText('অনলাইন এক্সাম'),
                    _buildBulletText('প্রিলি + রিটেন + ভাইভা'),
                    _buildBulletText('সাবজেক্ট ভিত্তিক পরীক্ষা'),
                    SizedBox(height: 16.h),

                    // ---------------- প্যাকেজ মূল্য ----------------
                    _buildSectionTitle('প্যাকেজ মূল্য:'),
                    SizedBox(height: 8.h),
                    _buildBulletText('প্রিলি + রিটেন + ভাইভা - ১০,০০০ টাকা'),
                    _buildBulletText('রিটেন + ভাইভা - ৭,০০০ টাকা'),
                    _buildBulletText('শুধু প্রিলি - ৩,০০০ টাকা'),
                    SizedBox(height: 16.h),

                    // ---------------- মেয়াদ ----------------
                    _buildSectionTitle('মেয়াদ:'),
                    SizedBox(height: 8.h),
                    _buildBulletText('১১৫৭ দিন'),
                    SizedBox(height: 30.h),
                  ],
                ),
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
              SizedBox(height: 8.h),
              Text(
                '১৯তম বিজেএস লিখিত পরীক্ষার প্রস্তুতি',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _buildBulletText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 8.w),
            child: Container(
              width: 5.w,
              height: 5.w,
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
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
