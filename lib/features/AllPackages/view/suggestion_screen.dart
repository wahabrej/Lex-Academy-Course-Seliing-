import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuggestionScreen extends StatelessWidget {
  const SuggestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context, 'Suggestion'),

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
                      _buildTabChip('Law (1)', false),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // ---------------- বিষয়বস্তু (General) ----------------
                  _buildGeneralContent(),

                  SizedBox(height: 30.h),

                  // ---------------- বিষয়বস্তু (Law) ----------------
                  _buildLawContent(),
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

  // ---------------- General কন্টেন্ট ----------------
  Widget _buildGeneralContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // টাইটেল
        Text(
          'সাধারণ পাঠ্য',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: 16.h),

        // কার্ড ১: LEX ACADEMY
        _buildInfoCard(
          title: 'LEX ACADEMY',
          lines: [
            'নিচের পাঠ্যক্রম প্রস্তুতি',
            'পাঠ্য (Mathematics)',
            'নিচের প্রতিলিপি ও লিখিত সরকারি',
            'সকল সরকারি',
            '২০২৫ সালের সিলেবাস অনুযায়ী প্রস্তুতি',
          ],
        ),
        SizedBox(height: 16.h),

        // কার্ড ২: স¤পাদক
        _buildInfoCard(
          title: 'স¤পাদক',
          lines: [
            'Mostafiz Billah',
            'Founder & Chief Mentor, Lex Academy',
            'Mobile: 01701-659089',
            'Website: www.lexacademyonline.com',
            'App: LexVerse',
          ],
        ),
        SizedBox(height: 16.h),

        // কার্ড ৩: সূচিপত্র
        _buildInfoCard(
          title: 'সূচিপত্র',
          lines: [
            '১. মেধা শূন্য - পলিটিক্যাল সাইন্স',
            '২. মেধা শূন্য - সোশ্যাল সাইন্স',
            '৩. মেধা শূন্য - ফিন্যান্স অ্যান্ড',
            '৪. মেধা শূন্য - অ্যাকাউন্টিং',
            '৫. মেধা শূন্য - সোশ্যাল সাইন্স',
            '৬. মেধা শূন্য - সোশ্যাল সাইন্স (২০টি)',
          ],
        ),
        SizedBox(height: 16.h),

        // কার্ড ৪: ইংরেজি
        _buildInfoCard(
          title: 'ইংরেজি',
          lines: [
            'প্রায় মাসুদ',
            'মাস্টার (Master) অথবা SOS (মডেল টেস্ট)',
            'সাহিত্য অংশ:',
            'সরকার (Miracle) - ২২-২৩-২৪ ইংরেজি (ক্লাস নোট)',
          ],
        ),
      ],
    );
  }

  // ---------------- Law কন্টেন্ট ----------------
  Widget _buildLawContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // টাইটেল
        Text(
          'আইন বিষয়াবলী',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        SizedBox(height: 16.h),

        // কার্ড: একটি এডিট
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Text(
            'এটি একটি এডিটর সাপেক্ষে সেটা বাদ দেওয়া হয়েছে কিছু প্রয়োজন',
            style: TextStyle(
              fontSize: 13.sp,
              color: const Color(0xFF1A1A1A),
              height: 1.5,
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // ট্যাব রো (ধারা, আপিল, রিভিউ)
        Row(
          children: [
            _buildSubTabChip('ধারা', true),
            SizedBox(width: 8.w),
            _buildSubTabChip('আপিল', false),
            SizedBox(width: 8.w),
            _buildSubTabChip('রিভিউ', false),
          ],
        ),
        SizedBox(height: 16.h),

        // ধারা কন্টেন্ট
        _buildSectionTitle('ধারা'),
        SizedBox(height: 8.h),
        _buildBulletText('প্রায় মাসুদ প্রকাশনী বাংলা ব্যাকরণ ও রচিত (এমএস সেলিম স্যার)'),
        _buildBulletText('মজিবর স্যার, কোচিং বাংলা ব্যাকরণ ও রচনা'),
        _buildBulletText('অরুণ স্যার, কোচিং বাংলা ব্যাকরণ ও রচনা'),
        _buildBulletText('ভাষা শহীদ, আলা উদ্দিন আল আজাদ (ইবরাহিম স্যার)'),
        _buildBulletText('৯ম-১০ম শ্রেণীর বাংলা সাহিত্য'),
        _buildBulletText('বাংলা সাহিত্য'),
        _buildBulletText('সাহিত্য বিচিত্রা (মজিবর স্যার)'),
        _buildBulletText('সাহিত্য অংশ:'),
        _buildBulletText('বাংলা সাহিত্যের ইতিহাস - মাসুদul আলম'),
        _buildBulletText('ক্লাসিক কারেন্ট জার্নাল'),
        _buildBulletText('সাহিত্য কথা - রশ্নে রায় (কাকলী প্রকাশনী)'),
        SizedBox(height: 16.h),

        // ইংরেজি
        _buildSectionTitle('ইংরেজি'),
        SizedBox(height: 8.h),
        _buildBulletText('প্রায় মাসুদ'),
        _buildBulletText('মাস্টার (Master) অথবা SOS (মডেল টেস্ট)'),
        _buildBulletText('সাহিত্য অংশ:'),
        _buildBulletText('সরকার (Miracle) - ২২-২৩-২৪ ইংরেজি (ক্লাস নোট)'),
        SizedBox(height: 30.h),
      ],
    );
  }

  // ---------------- ইনফো কার্ড ----------------
  Widget _buildInfoCard({required String title, required List<String> lines}) {
    return Container(
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
          Text(
            title,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 10.h),
          ...lines.map((line) => Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              line,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade700,
                height: 1.5,
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildSubTabChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF5B301) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? const Color(0xFF072B3E) : Colors.black,
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
