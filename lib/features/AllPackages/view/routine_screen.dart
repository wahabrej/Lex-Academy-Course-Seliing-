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
          _buildHeader(context, 'Class & Exam Routine'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // স্ট্যাটাস কার্ড
                  _buildStatusOverview(),
                  SizedBox(height: 24.h),
                  
                  Text('Upcoming Schedule', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
                  SizedBox(height: 12.h),
                  
                  _buildRoutineCard(
                    title: 'দেওয়ানি কার্যবিধি - লেকচার ০১',
                    type: 'Class',
                    time: '০৭:৩০ PM',
                    date: '২৫ সেপ্টেম্বর',
                    status: 'Upcoming',
                  ),
                  SizedBox(height: 12.h),
                  _buildRoutineCard(
                    title: 'সাপ্তাহিক মডেল টেস্ট - ০৫',
                    type: 'Exam',
                    time: '১০:০০ AM',
                    date: '২৬ সেপ্টেম্বর',
                    status: 'Pending',
                  ),
                ],
              ),
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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: SafeArea(
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
              Text(title, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusOverview() {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF072B3E),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statusItem('৯০', 'Total'),
          _statusItem('১২', 'Done'),
          _statusItem('৭৮', 'Remaining'),
        ],
      ),
    );
  }

  Widget _statusItem(String count, String label) {
    return Column(
      children: [
        Text(count, style: TextStyle(color: const Color(0xFFF5B301), fontSize: 18.sp, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white60, fontSize: 11.sp)),
      ],
    );
  }

  Widget _buildRoutineCard({required String title, required String type, required String time, required String date, required String status}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(color: const Color(0xFFF4F5F8), borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              children: [
                Text(date.split(' ')[0], style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
                Text(date.split(' ')[1], style: TextStyle(fontSize: 10.sp, color: Colors.grey)),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 12.sp, color: Colors.grey),
                    SizedBox(width: 4.w),
                    Text(time, style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
                    SizedBox(width: 12.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(color: type == 'Class' ? Colors.blue.withOpacity(0.1) : Colors.orange.withOpacity(0.1), borderRadius: BorderRadius.circular(4.r)),
                      child: Text(type, style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: type == 'Class' ? Colors.blue : Colors.orange)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
