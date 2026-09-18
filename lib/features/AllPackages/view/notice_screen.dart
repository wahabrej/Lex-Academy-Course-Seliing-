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
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context),

          // ---------------- বডি ----------------
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              itemCount: notices.length,
              itemBuilder: (context, index) {
                return _buildNoticeCard(notices[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          child: Row(
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

  Widget _buildNoticeCard(Map<String, dynamic> notice) {
    final bool isNew = notice['isNew'] as bool;
    final List<String> tags = List<String>.from(notice['tags']);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isNew ? const Color(0xFFFFE0B2) : Colors.grey.shade200,
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
          Row(
            children: tags.map((tag) => Container(
              margin: EdgeInsets.only(right: 4.w),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: tag == 'New' || tag == 'Updated' ? const Color(0xFFE53935) : const Color(0xFFF5B301),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                tag,
                style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            )).toList(),
          ),
          SizedBox(height: 12.h),
          Text(notice['title'], style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1A1A1A))),
          SizedBox(height: 8.h),
          Text(notice['description'], style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700, height: 1.5)),
          SizedBox(height: 12.h),
          Text(notice['date'], style: TextStyle(fontSize: 10.sp, color: Colors.grey.shade500)),
        ],
      ),
    );
  }
}
