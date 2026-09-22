import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../viewModel/package_view_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackageViewModel>().fetchLiveExamsSummary();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PackageViewModel>();
    final bjsSummary = viewModel.liveExamsSummary['bjs'];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _buildTabChip('Overview', true),
                      SizedBox(width: 8.w),
                      _buildTabChip('Subject', false),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // ---------------- Live Exam Stats from API ----------------
                  if (bjsSummary != null)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFF072B3E),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.sensors, color: Color(0xFFF5B301), size: 20),
                            SizedBox(width: 8.w),
                            Text("BJS Live Exams", style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildSummaryItem("Total Exams", "${bjsSummary.liveExamCount}"),
                            _buildSummaryItem("Next Exam", bjsSummary.nextUpcomingDate != null 
                                ? "${bjsSummary.nextUpcomingDate!.day}/${bjsSummary.nextUpcomingDate!.month}" 
                                : "N/A"),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  _buildStatsGrid(),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white70, fontSize: 11.sp)),
        SizedBox(height: 4.h),
        Text(value, style: TextStyle(color: const Color(0xFFF5B301), fontSize: 18.sp, fontWeight: FontWeight.bold)),
      ],
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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF072B3E), size: 16.sp),
                ),
              ),
              SizedBox(width: 16.w),
              Text('Dashboard', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF072B3E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: isSelected ? const Color(0xFF072B3E) : Colors.grey.shade300),
      ),
      child: Text(label, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.black)),
    );
  }

  Widget _buildStatsGrid() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('20', 'Questions Answered', const Color(0xFFE3F2FD), const Color(0xFF1E88E5), Icons.help_outline)),
        SizedBox(width: 12.w),
        Expanded(child: _buildStatCard('2', 'Correct', const Color(0xFFE8F5E9), const Color(0xFF43A047), Icons.check_circle_outline)),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, Color color, Color iconColor, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
          SizedBox(height: 12.h),
          Text(value, style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1A1A1A))),
          Text(label, style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade700, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
