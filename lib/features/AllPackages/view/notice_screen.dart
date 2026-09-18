import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notices = [
      {
        'isNew': true,
        'title': 'প্যাকেজ সংক্রান্ত নোটিশ',
        'description': 'আপনার প্রিয় লেকচারার এর কিছু পরিবর্তন এসেছে নতুন প্যাকেজের অন্তর্ভুক্ত করা হয়েছে। বিস্তারিত জানতে কল করুন ০১৭০১-৬৫৯০৮৯।',
        'date': '28/08/2026, 1:03 AM',
        'tags': ['Updated', 'Version Update', 'প্যাকেজ সংক্রান্ত'],
      },
      {
        'isNew': true,
        'title': 'সাধারণ নোটিশ',
        'description': 'সম্মানিত শিক্ষার্থী, আমাদের ক্লাস ও পরীক্ষার সময়সূচিতে কিছু পরিবর্তন আনা হয়েছে। বিস্তারিত জানতে নিচের নোটিশটি পড়ুন।',
        'date': '31/07/2026, 3:38 PM',
        'tags': ['সাধারণ নোটিশ', 'New'],
      },
      {
        'isNew': true,
        'title': 'সাধারণ নোটিশ',
        'description': 'আগামীকাল থেকে নিয়মিত ক্লাস শুরু হবে। সকল শিক্ষার্থীকে সময়মতো উপস্থিত থাকার অনুরোধ করা হচ্ছে।',
        'date': '26/07/2026, 11:25 PM',
        'tags': ['সাধারণ নোটিশ', 'New'],
      },
      {
        'isNew': true,
        'title': 'সাধারণ নোটিশ',
        'description': 'আগামী শুক্রবার বিশ্ববিদ্যালয় বন্ধ থাকবে। ঐ দিন কোনো ক্লাস হবে না।',
        'date': '26/07/2026, 10:58 AM',
        'tags': ['সাধারণ নোটিশ', 'New'],
      },
      {
        'isNew': false,
        'title': '১৭তম বিজেএস প্রিলি পরীক্ষার রুটিন',
        'description': 'আগামী ১৫ আগস্ট ২০২৬ তারিখে ১৭তম বিজেএস প্রিলি পরীক্ষা অনুষ্ঠিত হবে। পরীক্ষার সময়সূচি ও বিস্তারিত তথ্য নিচে দেওয়া হয়েছে। পরীক্ষার জন্য প্রস্তুতি নিন।',
        'date': '25/07/2026, 1:47 PM',
        'tags': ['সাধারণ নোটিশ', 'New'],
      },
      {
        'isNew': false,
        'title': 'বিশেষ চিকিৎসা সংক্রান্ত নোটিশ',
        'description': 'আমাদের কিছু শিক্ষার্থীর স্বাস্থ্যগত সমস্যা দেখা দিয়েছে। তাদেরকে দ্রুত চিকিৎসা সেবা প্রদান করা হবে। বিস্তারিত জানতে নিচের নোটিশটি পড়ুন।',
        'date': '25/07/2026, 1:31 PM',
        'tags': ['সাধারণ নোটিশ', 'New'],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF072B3E),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context),

          // ---------------- বডি ----------------
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  return _buildNoticeCard(notices[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- হেডার ----------------
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFF072B3E),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 16.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: const Color(0xFF072B3E),
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                'Notice',
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

  // ---------------- নোটিশ কার্ড ----------------
  Widget _buildNoticeCard(Map<String, dynamic> notice) {
    final bool isNew = notice['isNew'] as bool;
    final List<String> tags = List<String>.from(notice['tags']);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isNew ? const Color(0xFFFFE0B2) : Colors.grey.shade200,
          width: isNew ? 1.5 : 1,
        ),
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
          // ---------------- ট্যাগ রো ----------------
          Row(
            children: [
              // প্রথম ট্যাগ (লাল)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE53935),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  tags[0],
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 4.w),
              // দ্বিতীয় ট্যাগ (কমলা)
              if (tags.length > 1)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5B301),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Text(
                    tags[1],
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              SizedBox(width: 4.w),
              // তৃতীয় ট্যাগ (হালকা কমলা)
              if (tags.length > 2)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: const Color(0xFFFFE0B2)),
                  ),
                  child: Text(
                    tags[2],
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE65100),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),

          // ---------------- টাইটেল ----------------
          Text(
            notice['title'],
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 8.h),

          // ---------------- বর্ণনা ----------------
          Text(
            notice['description'],
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          SizedBox(height: 12.h),

          // ---------------- তারিখ ----------------
          Text(
            notice['date'],
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }
}