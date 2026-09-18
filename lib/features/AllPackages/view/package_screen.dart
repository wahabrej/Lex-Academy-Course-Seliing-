import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lexverse/core/routes/routesName.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার (Custom Header) ----------------
          _buildHeader(context, 'সকল প্যাকেজ'),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- টপ ব্যাজ রো ----------------
                  Row(
                    children: [
                      _buildTopBadge('BJS', const Color(0xFFF5B301), const Color(0xFF072B3E)),
                      SizedBox(width: 8.w),
                      _buildTopBadge('Preliminary', const Color(0xFFE0E0E0), const Color(0xFF1A1A1A)),
                      SizedBox(width: 8.w),
                      _buildTopBadge('Batch 19', const Color(0xFFE0E0E0), const Color(0xFF1A1A1A)),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // ---------------- টাইটেল ----------------
                  Text(
                    '১৯তম বিজেএস প্রিলি পরীক্ষার\nপ্রস্তুতি,ফেব্রুয়ারি',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ---------------- গ্রিড ভিউ ----------------
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _menuItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 0.95,
                    ),
                    itemBuilder: (context, index) {
                      return _buildMenuCard(context, _menuItems[index]);
                    },
                  ),
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

  // ---------------- টপ ব্যাজ হেল্পার ----------------
  Widget _buildTopBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  // ---------------- মেনু কার্ড হেল্পার ----------------
  Widget _buildMenuCard(BuildContext context, MenuItem item) {
    return GestureDetector(
      onTap: () {
        if (item.routeName != null) {
          Navigator.pushNamed(context, item.routeName!);
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: item.iconBgColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                item.icon,
                color: item.iconColor,
                size: 20.sp,
              ),
            ),
            const Spacer(),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              item.subtitle,
              style: TextStyle(
                fontSize: 10.sp,
                color: Colors.grey.shade600,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------- মেনু আইটেম ডেটা মডেল ----------------
class MenuItem {
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? routeName;

  MenuItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    this.routeName,
  });
}

// ---------------- মেনু আইটেম লিস্ট ----------------
final List<MenuItem> _menuItems = [
  MenuItem(
    icon: Icons.videocam,
    iconBgColor: const Color(0xFFFFEBEE),
    iconColor: const Color(0xFFE53935),
    title: 'Live Exam',
    subtitle: 'Active live MCQ exams',
    routeName: RouteName.liveExamScreen,
  ),
  MenuItem(
    icon: Icons.archive,
    iconBgColor: const Color(0xFFE3F2FD),
    iconColor: const Color(0xFF1E88E5),
    title: 'Archive',
    subtitle: 'Past exams + auto PDF',
    routeName: RouteName.archivescreen,
  ),
  MenuItem(
    icon: Icons.calendar_month,
    iconBgColor: const Color(0xFFE8F5E9),
    iconColor: const Color(0xFF43A047),
    title: 'Routine',
    subtitle: 'Long-form routine page',
    routeName: RouteName.routineScreen,
  ),
  MenuItem(
    icon: Icons.menu_book,
    iconBgColor: const Color(0xFFE3F2FD),
    iconColor: const Color(0xFF1E88E5),
    title: 'Syllabus',
    subtitle: 'Syllabus PDF',
    routeName: RouteName.syllabusScreen,
  ),
  MenuItem(
    icon: Icons.assignment_turned_in,
    iconBgColor: const Color(0xFFFFF8E1),
    iconColor: const Color(0xFFF5B301),
    title: 'Result',
    subtitle: 'Latest live exam result',
    routeName: RouteName.resultScreen,
  ),
  MenuItem(
    icon: Icons.error_outline,
    iconBgColor: const Color(0xFFFFEBEE),
    iconColor: const Color(0xFFE53935),
    title: 'Wrong &\nUnanswered',
    subtitle: 'From attempted exams',
  ),
  MenuItem(
    icon: Icons.favorite,
    iconBgColor: const Color(0xFFFCE4EC),
    iconColor: const Color(0xFFD81B60),
    title: 'Favorite',
    subtitle: 'Saved questions',
  ),
  MenuItem(
    icon: Icons.bar_chart,
    iconBgColor: const Color(0xFFE8EAF6),
    iconColor: const Color(0xFF3949AB),
    title: 'Merit List',
    subtitle: 'Top scorers',
    routeName: RouteName.resultScreen,
  ),
  MenuItem(
    icon: Icons.assignment,
    iconBgColor: const Color(0xFFE0F7FA),
    iconColor: const Color(0xFF00ACC1),
    title: 'Details',
    subtitle: 'MCQ breakdown',
    routeName: RouteName.resultScreen,
  ),
  MenuItem(
    icon: Icons.menu_book,
    iconBgColor: const Color(0xFFF3E5F5),
    iconColor: const Color(0xFF8E24AA),
    title: 'Book Reference',
    subtitle: 'Full book list',
    routeName: RouteName.bookReferenceScreen,
  ),
  MenuItem(
    icon: Icons.lightbulb,
    iconBgColor: const Color(0xFFFFF3E0),
    iconColor: const Color(0xFFFB8C00),
    title: 'Suggestion',
    subtitle: 'Subject-wise suggestions',
    routeName: RouteName.suggestionScreen,
  ),
  MenuItem(
    icon: Icons.sticky_note_2,
    iconBgColor: const Color(0xFFE8F5E9),
    iconColor: const Color(0xFF43A047),
    title: 'Note',
    subtitle: 'Package-scoped Notes',
    routeName: RouteName.notesScreen,
  ),
  MenuItem(
    icon: Icons.show_chart,
    iconBgColor: const Color(0xFFE0F2F1),
    iconColor: const Color(0xFF00897B),
    title: 'Analytics',
    subtitle: 'Performance tracking',
    routeName: RouteName.dashboardScreen,
  ),
  MenuItem(
    icon: Icons.notifications_active,
    iconBgColor: const Color(0xFFFFF3E0),
    iconColor: const Color(0xFFFB8C00),
    title: 'Notice',
    subtitle: 'Package announcements',
    routeName: RouteName.noticeScreen,
  ),
  MenuItem(
    icon: Icons.video_library,
    iconBgColor: const Color(0xFFFFEBEE),
    iconColor: const Color(0xFFE53935),
    title: 'Live Class',
    subtitle: 'Scheduled live classes',
  ),
];
