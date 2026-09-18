import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageDetailScreen extends StatelessWidget {
  const PackageDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: const Color(0xFF1A1A1A),
              size: 16.sp,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'বিস্তারিত বিবরণ',
          style: TextStyle(
            color: const Color(0xFF1A1A1A),
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Icon(
              Icons.favorite_border,
              color: const Color(0xFF1A1A1A),
              size: 24.sp,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ---------------- টাইটেল ----------------
            Text(
              '১৯তম বিজেএস প্রিলি পরীক্ষার\nপ্রস্তুতি, ফেব্রুয়ারি',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
                height: 1.3,
              ),
            ),
            SizedBox(height: 16.h),

            // ---------------- প্রাইস ও ডিউরেশন ব্যাজ ----------------
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5B301),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '৳ ১০০০',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF072B3E),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F2F5),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'মেয়াদ: ১১৫৭ দিন',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // ---------------- Course Overview ----------------
            Text(
              'Course Overview',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'BJS-এর সকল পরীক্ষা ও ক্লাস + LM\nসাবজেক্ট কোর্স',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
                height: 1.4,
              ),
            ),
            SizedBox(height: 16.h),

            // ---------------- ৳ 1050 কার্ড ----------------
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                '৳ 1050',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF072B3E),
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // ---------------- ১৯তম BJS প্যাকেজের সুবিধা ----------------
            _buildSectionTitle('১৯তম BJS প্যাকেজের সুবিধা:'),
            SizedBox(height: 10.h),
            _buildBulletPoint('সকল লাইভ ক্লাস'),
            _buildBulletPoint('সকল পরীক্ষা'),
            _buildBulletPoint('কোর্সটি মেয়াদ আছে ১১৫৭ দিন'),
            SizedBox(height: 20.h),

            // ---------------- লাইভ ক্লাস ----------------
            _buildSectionTitle('লাইভ ক্লাস:'),
            SizedBox(height: 10.h),
            _buildBulletPoint('অ্যাপে ভিডিও ক্লাস - ৯০ টি'),
            _buildBulletPoint('রেকর্ডেড ক্লাস - ৫০ টি'),
            _buildBulletPoint('প্রিলি পরীক্ষা - ২০ টি'),
            _buildBulletPoint('প্রিলি মডেল টেস্ট - ১০ টি'),
            _buildBulletPoint('সাম্প্রতিক বিষয়াবলী'),
            SizedBox(height: 20.h),

            // ---------------- কোর্সের অন্যান্য সুবিধা ----------------
            _buildSectionTitle('কোর্সের অন্যান্য সুবিধা:'),
            SizedBox(height: 10.h),
            _buildBulletPoint('প্রতি মাসে লাইভ ক্লাস'),
            _buildBulletPoint('প্রতি মাসে মডেল টেস্ট'),
            _buildBulletPoint('প্রতি মাসে স্পেশাল ক্লাস'),
            SizedBox(height: 20.h),

            // ---------------- আরও সুবিধা ----------------
            _buildSectionTitle('আরও সুবিধা:'),
            SizedBox(height: 10.h),
            _buildBulletPoint('টপিক ভিত্তিক ক্লাস'),
            _buildBulletPoint('রিভিশন ক্লাস'),
            _buildBulletPoint('প্রশ্ন সমাধান ক্লাস'),
            _buildBulletPoint('হ্যান্ডরিটেন নোট'),
            _buildBulletPoint('সকল লেকচার শিট'),
            _buildBulletPoint('অনলাইন এক্সাম'),
            SizedBox(height: 20.h),

            // ---------------- প্যাকেজ মূল্য ----------------
            _buildSectionTitle('প্যাকেজ মূল্য:'),
            SizedBox(height: 10.h),
            _buildBulletPoint('প্রিলি + রিটেন + ভাইভা - ১০,০০০ টাকা'),
            _buildBulletPoint('রিটেন + ভাইভা - ৭,০০০ টাকা'),
            _buildBulletPoint('শুধু প্রিলি - ৩,০০০ টাকা'),
            SizedBox(height: 20.h),

            // ---------------- মেয়াদ ----------------
            _buildSectionTitle('মেয়াদ:'),
            SizedBox(height: 10.h),
            _buildBulletPoint('১১৫৭ দিন'),
            SizedBox(height: 24.h),

            // ---------------- ক্লাস রুটিন ----------------
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16.sp, color: const Color(0xFF072B3E)),
                SizedBox(width: 6.w),
                Text(
                  'ক্লাস রুটিন',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি 16/08/2026',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: const Color(0xFF1A1A1A),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // ---------------- সম্পূর্ণ ক্লাসিনের ফি ----------------
            Text(
              'সম্পূর্ণ ক্লাসিনের ফি',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 24.h),

            // ---------------- প্যাকেজ কিনুন বাটন ----------------
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF072B3E),
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
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  // ---------------- সেকশন টাইটেল হেল্পার ----------------
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

  // ---------------- বুলেট পয়েন্ট হেল্পার ----------------
  Widget _buildBulletPoint(String text) {
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
                fontSize: 13.sp,
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