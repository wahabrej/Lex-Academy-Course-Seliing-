import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoticeScreen extends StatelessWidget {
  const NoticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, 'Announcements'),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: 4,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                return _buildNoticeCard(
                  title: 'পরীক্ষার সময় পরিবর্তন সংক্রান্ত জরুরি বিজ্ঞপ্তি',
                  date: '২৪ সেপ্টেম্বর ২০২৬',
                  isPinned: index == 0,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

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
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF072B3E), size: 16.sp),
                ),
              ),
              SizedBox(width: 16.w),
              Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoticeCard({required String title, required String date, bool isPinned = false}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: isPinned ? Border.all(color: const Color(0xFFF5B301), width: 1) : null,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isPinned)
                Row(
                  children: [
                    const Icon(Icons.push_pin, color: Color(0xFFF5B301), size: 14),
                    SizedBox(width: 4.w),
                    Text('PINNED', style: TextStyle(fontSize: 10.sp, color: const Color(0xFFF5B301), fontWeight: FontWeight.bold)),
                  ],
                ),
              Text(date, style: TextStyle(fontSize: 11.sp, color: Colors.grey[600])),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E), height: 1.4),
          ),
          SizedBox(height: 12.h),
          Text(
            'আগামীকালের বিজেএস প্রিলি পরীক্ষাটি সকাল ১০টার পরিবর্তে দুপুর ২টায় অনুষ্ঠিত হবে। বিস্তারিত জানতে লিংকে ক্লিক করুন...',
            style: TextStyle(fontSize: 12.sp, color: Colors.grey[700], height: 1.5),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
