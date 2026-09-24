import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lexverse/core/routes/routesName.dart';

class EnrolledPackageDashboardScreen extends StatelessWidget {
  final String? packageName;

  const EnrolledPackageDashboardScreen({
    super.key,
    this.packageName,
  });

  @override
  Widget build(BuildContext context) {
    // আপনার ডকুমেন্টের ৮টি প্রধান মডিউল + অতিরিক্ত ২টি
    final List<Map<String, dynamic>> modules = [
      {
        'title': 'Exams',
        'subtitle': 'Live, Archived & Past',
        'icon': Icons.assignment_rounded,
        'color': const Color(0xFFE53935),
        'route': RouteName.liveExamScreen,
      },
      {
        'title': 'Results',
        'subtitle': 'Merit List & Breakdown',
        'icon': Icons.emoji_events_rounded,
        'color': const Color(0xFFFFB300),
        'route': RouteName.resultScreen,
      },
      {
        'title': 'Routine',
        'subtitle': 'Class & Exam Schedule',
        'icon': Icons.calendar_month_rounded,
        'color': const Color(0xFF3F51B5),
        'route': RouteName.routineScreen,
      },
      {
        'title': 'Syllabus',
        'subtitle': 'Package Curriculum',
        'icon': Icons.menu_book_rounded,
        'color': const Color(0xFF00897B),
        'route': RouteName.syllabusScreen,
      },
      {
        'title': 'Notes',
        'subtitle': 'Lecture & Study Notes',
        'icon': Icons.description_rounded,
        'color': const Color(0xFF2E7D32),
        'route': RouteName.notesScreen,
      },
      {
        'title': 'Question Banks',
        'subtitle': 'Past Paper Collections',
        'icon': Icons.quiz_rounded,
        'color': const Color(0xFF8E24AA),
        'route': RouteName.questionBanks,
      },
      {
        'title': 'References',
        'subtitle': 'Standard Book List',
        'icon': Icons.library_books_rounded,
        'color': const Color(0xFFD81B60),
        'route': RouteName.bookReferenceScreen,
      },
      {
        'title': 'Suggestions',
        'subtitle': 'Subject-wise Tips',
        'icon': Icons.tips_and_updates_rounded,
        'color': const Color(0xFFFB8C00),
        'route': RouteName.suggestionScreen,
      },
      {
        'title': 'Announcements',
        'subtitle': 'Latest Notices',
        'icon': Icons.campaign_rounded,
        'color': const Color(0xFF00ACC1),
        'route': RouteName.noticeScreen,
      },
      {
        'title': 'Performance',
        'subtitle': 'Your Progress Analytics',
        'icon': Icons.bar_chart_rounded,
        'color': const Color(0xFF689F38),
        'route': RouteName.dashboardScreen,
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _buildHeader(context, packageName ?? '১৯তম বিজেএস প্রিলি প্রস্তুতি'),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F5F8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: GridView.builder(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                itemCount: modules.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                  childAspectRatio: 1.05,
                ),
                itemBuilder: (context, index) {
                  final module = modules[index];
                  return _buildModuleCard(
                    context,
                    module['title'],
                    module['subtitle'],
                    module['icon'],
                    module['color'],
                    module['route'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name) {
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
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: const Color(0xFF072B3E),
                    size: 16.sp,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5B301),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'ENROLLED',
                      style: TextStyle(
                        color: const Color(0xFF072B3E),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, String title, String subtitle, IconData icon, Color color, String? route) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
          borderRadius: BorderRadius.circular(16.r),
          child: Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(icon, color: color, size: 22.r),
                ),
                const Spacer(),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF072B3E),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: Colors.grey[600],
                    height: 1.2,
                  ),
                  maxLines: 2,
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
