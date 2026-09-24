import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveExamScreen extends StatefulWidget {
  const LiveExamScreen({super.key});

  @override
  State<LiveExamScreen> createState() => _LiveExamScreenState();
}

class _LiveExamScreenState extends State<LiveExamScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context),
          Container(
            color: const Color(0xFF072B3E),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFFF5B301),
              indicatorWeight: 3,
              labelColor: const Color(0xFFF5B301),
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: 'Live Exams'),
                Tab(text: 'Archived'),
                Tab(text: 'Past Exams'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildExamList('Live'),
                _buildExamList('Archived'),
                _buildExamList('Past'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFF072B3E),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 10.h),
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
              Text('Exams', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExamList(String type) {
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: 3,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => _buildExamCard(type),
    );
  }

  Widget _buildExamCard(String type) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: type == 'Live' ? Colors.red.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text(
                  type == 'Live' ? 'LIVE NOW' : type.toUpperCase(),
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: type == 'Live' ? Colors.red : Colors.grey[700]),
                ),
              ),
              Text('Time: 10:00 AM', style: TextStyle(fontSize: 11.sp, color: Colors.grey)),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'দেওয়ানি কার্যবিধি - পূর্ণাঙ্গ মডেল টেস্ট ০২',
            style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E)),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.help_outline, size: 14, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text('100 Qs', style: TextStyle(fontSize: 11.sp, color: Colors.grey[700])),
                  SizedBox(width: 12.w),
                  const Icon(Icons.timer_outlined, size: 14, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text('60 Mins', style: TextStyle(fontSize: 11.sp, color: Colors.grey[700])),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: type == 'Live' ? const Color(0xFFF5B301) : const Color(0xFF072B3E),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                  elevation: 0,
                ),
                child: Text(
                  type == 'Live' ? 'Start Exam' : 'View Details',
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: type == 'Live' ? const Color(0xFF072B3E) : Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
