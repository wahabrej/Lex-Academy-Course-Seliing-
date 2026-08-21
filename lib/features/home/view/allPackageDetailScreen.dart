import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllPackageGridScreen extends StatelessWidget {
  const AllPackageGridScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Grid Item-এর জন্য ডেটা লিস্ট
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Live Exam',
        'subtitle': 'Active live MCQ exams',
        'icon': Icons.radio_button_checked_rounded,
        'iconBgColor': const Color(0xFFFFEBEE),
        'iconColor': Colors.redAccent,
      },
      {
        'title': 'Archive',
        'subtitle': 'Past exams + auto PDF\n(Q + A + explanation)',
        'icon': Icons.archive_rounded,
        'iconBgColor': const Color(0xFFE3F2FD),
        'iconColor': const Color(0xFF1976D2),
      },
      {
        'title': 'Routine',
        'subtitle': 'Long-form routine page',
        'icon': Icons.calendar_month_rounded,
        'iconBgColor': const Color(0xFFE8EAF6),
        'iconColor': const Color(0xFF3F51B5),
      },
      {
        'title': 'Syllabus',
        'subtitle': 'Syllabus PDF',
        'icon': Icons.menu_book_rounded,
        'iconBgColor': const Color(0xFFE0F2F1),
        'iconColor': const Color(0xFF00897B),
      },
      {
        'title': 'Result',
        'subtitle': 'Latest live exam result\n(auto-rotates)',
        'icon': Icons.assignment_turned_in_rounded,
        'iconBgColor': const Color(0xFFFFF8E1),
        'iconColor': const Color(0xFFFFB300),
      },
      {
        'title': 'Wrong & Unanswered',
        'subtitle': 'From every attempted\nexam in this package',
        'icon': Icons.error_outline_rounded,
        'iconBgColor': const Color(0xFFFFEBEE),
        'iconColor': Colors.red,
      },
      {
        'title': 'Favorite',
        'subtitle': 'Saved questions from this package',
        'icon': Icons.favorite_rounded,
        'iconBgColor': const Color(0xFFFCE4EC),
        'iconColor': Colors.pink,
      },
      {
        'title': 'Merit List',
        'subtitle': 'Top scorers for the latest\nlive exam',
        'icon': Icons.bar_chart_rounded,
        'iconBgColor': const Color(0xFFE8F5E9),
        'iconColor': const Color(0xFF388E3C),
      },
      {
        'title': 'Details',
        'subtitle': 'Subject-wise breakdown\nof attempted MCQ\nexams',
        'icon': Icons.insert_chart_outlined_rounded,
        'iconBgColor': const Color(0xFFE0F2F1),
        'iconColor': const Color(0xFF00796B),
      },
      {
        'title': 'Book Reference',
        'subtitle': 'Full book list — General &\nLaw subjects',
        'icon': Icons.import_contacts_rounded,
        'iconBgColor': const Color(0xFFF3E5F5),
        'iconColor': const Color(0xFF8E24AA),
      },
      {
        'title': 'Suggestion',
        'subtitle': 'Subject-wise\nsuggestions — General...',
        'icon': Icons.lightbulb_outline_rounded,
        'iconBgColor': const Color(0xFFFFF3E0),
        'iconColor': Colors.orange,
      },
      {
        'title': 'Note',
        'subtitle': 'Package-scoped Notes\n— General & Law...',
        'icon': Icons.note_alt_outlined,
        'iconBgColor': const Color(0xFFE8F5E9),
        'iconColor': const Color(0xFF2E7D32),
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top Bar Header
            _buildHeader(context),
            SizedBox(height: 12.h),

            // 2. Main Container Wrapping Tags, Title & Grid
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F5F8),
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Filter Badges/Chips Row
                      Row(
                        children: [
                          _buildBadge(
                            text: 'BJS',
                            bgColor: const Color(0xFFFFC107),
                            textColor: Colors.black,
                          ),
                          SizedBox(width: 8.w),
                          _buildBadge(
                            text: 'Preliminary',
                            bgColor: Colors.white,
                            textColor: const Color(0xFF0F2C43),
                          ),
                          SizedBox(width: 8.w),
                          _buildBadge(
                            text: 'Batch 19',
                            bgColor: Colors.white,
                            textColor: const Color(0xFF0F2C43),
                          ),
                        ],
                      ),
                      SizedBox(height: 14.h),

                      // Package Title
                      Text(
                        '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি,ফেব্রুয়ারি',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F2C43),
                          height: 1.3,
                        ),
                      ),
                      SizedBox(height: 18.h),

                      // 2-Column Grid View for Options
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: menuItems.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.95,
                        ),
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return _buildGridCard(
                            title: item['title'],
                            subtitle: item['subtitle'],
                            icon: item['icon'],
                            iconBgColor: item['iconBgColor'],
                            iconColor: item['iconColor'],
                            onTap: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Header Widget
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F7),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18.r,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Text(
            'সকল প্যাকেজ',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2C43),
            ),
          ),
        ],
      ),
    );
  }

  // Helper Widget for Badges
  Widget _buildBadge({
    required String text,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
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

  // Individual Grid Item Card
  Widget _buildGridCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18.r),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon Background Container
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    icon,
                    size: 20.r,
                    color: iconColor,
                  ),
                ),
                SizedBox(height: 10.h),

                // Card Title
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2C43),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),

                // Card Subtitle
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}