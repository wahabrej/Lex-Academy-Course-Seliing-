import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lexverse/core/routes/routesName.dart';

class PackageScreen extends StatelessWidget {
  const PackageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // হালকা অফ-হোয়াইট ব্যাকগ্রাউন্ড
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        centerTitle: false,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: IconButton(
            icon: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: const Color(0xFF1A1A1A),
                size: 16.sp,
              ),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'সকল প্যাকেজ',
          style: TextStyle(
            color: const Color(0xFF1A1A1A),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
                childAspectRatio: 0.95, // কার্ডের উচ্চতা ও প্রস্থের অনুপাত
              ),
              itemBuilder: (context, index) {
                return _buildMenuCard(context, _menuItems[index]);
              },
            ),
            SizedBox(height: 30.h),
          ],
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
            // আইকন কন্টেইনার
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
            // টাইটেল
            Text(
              item.title,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 4.h),
            // সাবটাইটেল
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
    iconBgColor: const Color(0xFFFFEBEE), // হালকা লাল
    iconColor: const Color(0xFFE53935), // লাল
    title: 'Live Exam',
    subtitle: 'Active live MCQ exams',
    routeName: RouteName.liveExamScreen,
  ),
  MenuItem(
    icon: Icons.archive,
    iconBgColor: const Color(0xFFE3F2FD), // হালকা নীল
    iconColor: const Color(0xFF1E88E5), // নীল
    title: 'Archive',
    subtitle: 'Past exams + auto PDF\n(Q + A + explanation)',
    routeName: RouteName.archivescreen,
  ),
  MenuItem(
    icon: Icons.calendar_month,
    iconBgColor: const Color(0xFFE8F5E9), // হালকা সবুজ
    iconColor: const Color(0xFF43A047), // সবুজ
    title: 'Routine',
    subtitle: 'Long-form routine page',
    routeName: RouteName.routineScreen,
  ),
  MenuItem(
    icon: Icons.menu_book,
    iconBgColor: const Color(0xFFE3F2FD), // হালকা নীল
    iconColor: const Color(0xFF1E88E5), // নীল
    title: 'Syllabus',
    subtitle: 'Syllabus PDF',
    routeName: RouteName.syllabusScreen,
  ),
  MenuItem(
    icon: Icons.assignment_turned_in,
    iconBgColor: const Color(0xFFFFF8E1), // হালকা হলুদ
    iconColor: const Color(0xFFF5B301), // হলুদ
    title: 'Result',
    subtitle: 'Latest live exam result\n(auto-rotates)',
    routeName: RouteName.resultScreen,
  ),
  MenuItem(
    icon: Icons.error_outline,
    iconBgColor: const Color(0xFFFFEBEE), // হালকা লাল
    iconColor: const Color(0xFFE53935), // লাল
    title: 'Wrong &\nUnanswered',
    subtitle: 'From every attempted\nexam in this package',
  ),
  MenuItem(
    icon: Icons.favorite,
    iconBgColor: const Color(0xFFFCE4EC), // হালকা গোলাপি
    iconColor: const Color(0xFFD81B60), // গোলাপি
    title: 'Favorite',
    subtitle: 'Saved questions from this\npackage',
  ),
  MenuItem(
    icon: Icons.bar_chart,
    iconBgColor: const Color(0xFFE8EAF6), // হালকা ইন্ডিগো
    iconColor: const Color(0xFF3949AB), // ইন্ডিগো
    title: 'Merit List',
    subtitle: 'Top scorers for the latest\nlive exam',
  ),
  MenuItem(
    icon: Icons.assignment,
    iconBgColor: const Color(0xFFE0F7FA), // হালকা সায়ান
    iconColor: const Color(0xFF00ACC1), // সায়ান
    title: 'Details',
    subtitle: 'Subject-wise breakdown\nof attempted MCQ\nexams',
  ),
  MenuItem(
    icon: Icons.menu_book,
    iconBgColor: const Color(0xFFF3E5F5), // হালকা পার্পল
    iconColor: const Color(0xFF8E24AA), // পার্পল
    title: 'Book Reference',
    subtitle: 'Full book list — General &\nLaw subjects',
    routeName: RouteName.bookReferenceScreen,
  ),
  MenuItem(
    icon: Icons.lightbulb,
    iconBgColor: const Color(0xFFFFF3E0), // হালকা কমলা
    iconColor: const Color(0xFFFB8C00), // কমলা
    title: 'Suggestion',
    subtitle: 'Subject-wise\nsuggestions — General\n& Law',
    routeName: RouteName.suggestionScreen,
  ),
  MenuItem(
    icon: Icons.sticky_note_2,
    iconBgColor: const Color(0xFFE8F5E9), // হালকা সবুজ
    iconColor: const Color(0xFF43A047), // সবুজ
    title: 'Note',
    subtitle: 'Package-scoped Notes\n— General & Law',
    routeName: RouteName.notesScreen,
  ),
  MenuItem(
    icon: Icons.show_chart,
    iconBgColor: const Color(0xFFE0F2F1), // হালকা টিল
    iconColor: const Color(0xFF00897B), // টিল
    title: 'Analytics',
    subtitle: 'Average performance\nacross all exams',
    routeName: RouteName.dashboardScreen,
  ),
  MenuItem(
    icon: Icons.notifications_active,
    iconBgColor: const Color(0xFFFFF3E0), // হালকা কমলা
    iconColor: const Color(0xFFFB8C00), // কমলা
    title: 'Notice',
    subtitle: 'Package announcements',
    routeName: RouteName.noticeScreen,
  ),
  MenuItem(
    icon: Icons.video_library,
    iconBgColor: const Color(0xFFFFEBEE), // হালকা লাল
    iconColor: const Color(0xFFE53935), // লাল
    title: 'Live Class',
    subtitle: 'Scheduled live classes',
  ),
];
