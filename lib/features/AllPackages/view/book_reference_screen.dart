import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookReferenceScreen extends StatelessWidget {
  const BookReferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context, 'Book Reference'),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- ট্যাব রো ----------------
                  Row(
                    children: [
                      _buildTabChip('General (1)', true),
                      SizedBox(width: 8.w),
                      _buildTabChip('Law (0)', false),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // ---------------- টাইটেল ----------------
                  Text(
                    'General Subjects Books Reference',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // ---------------- বর্ণনা ----------------
                  Text(
                    'নিচের কিছু বইগুলো আপনার কাঙ্ক্ষিত বিষয় ও বিষয়ের এর প্রত্যেকটি বিষয়ের জন্য আলাদা আলাদা বই আছে। কিছু প্রকাশনী নেই সেটাও কিছু বলতে চাই না।',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.grey.shade700,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ---------------- ডিভাইডার ----------------
                  Divider(color: Colors.grey.shade300),
                  SizedBox(height: 12.h),

                  // ---------------- প্রথম অংশ ----------------
                  Text(
                    'প্রিলি ও রিটেন',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ---------------- বাংলা ----------------
                  _buildSectionTitle('বাংলা'),
                  SizedBox(height: 8.h),
                  _buildSubSectionTitle('ব্যাকরণ অংশ:'),
                  _buildBulletText('প্রায় মাসুদ প্রকাশনী বাংলা ব্যাকরণ ও রচিত (এমএস সেলিম স্যার)'),
                  _buildBulletText('মজিবর স্যার, কোচিং বাংলা ব্যাকরণ ও রচনা'),
                  _buildBulletText('অরুণ স্যার, কোচিং বাংলা ব্যাকরণ ও রচনা'),
                  _buildBulletText('ভাষা শহীদ, আলা উদ্দিন আল আজাদ (ইবরাহিম স্যার)'),
                  _buildBulletText('৯ম-১০ম শ্রেণীর বাংলা সাহিত্য'),
                  _buildBulletText('বাংলা সাহিত্য'),
                  _buildBulletText('সাহিত্য বিচিত্রা (মজিবর স্যার)'),
                  _buildBulletText('সাহিত্য অংশ:'),
                  _buildBulletText('বাংলা সাহিত্যের ইতিহাস - মাসুদুল আলম'),
                  _buildBulletText('ক্লাসিক কারেন্ট জার্নাল'),
                  _buildBulletText('সাহিত্য কথা - রশ্নে রায় (কাকলী প্রকাশনী)'),
                  SizedBox(height: 16.h),

                  // ---------------- ইংরেজি ----------------
                  _buildSectionTitle('ইংরেজি'),
                  SizedBox(height: 8.h),
                  _buildSubSectionTitle('ব্যাকরণ অংশ:'),
                  _buildBulletText('মাস্টার (Master) অথবা SOS (মডেল টেস্ট)'),
                  _buildBulletText('সাহিত্য অংশ:'),
                  _buildBulletText('সরকার (Miracle) - ইংরেজি সাহিত্য'),
                  SizedBox(height: 30.h),
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
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- ট্যাব চিপ ----------------
  Widget _buildTabChip(String label, bool isSelected) {
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1A1A),
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF1A1A1A),
        ),
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
