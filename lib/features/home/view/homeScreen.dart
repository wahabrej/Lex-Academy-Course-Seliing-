import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lexverse/core/routes/routesName.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ========== 1. TOP BAR / HEADER ==========
              _buildHeader(),
              SizedBox(height: 20.h),

              // ========== 2. HERO CARD (BJS Program) ==========
              _buildBJSProgramCard(context),
              SizedBox(height: 16.h),

              // ========== 3. TWO COLUMN CARDS (BAR Programs) ==========
              Row(
                children: [
                  Expanded(
                    child: _buildBarProgramCard(
                      title: 'BAR Program',
                      subtitle: 'Pass the Bar Council enrolment exam',
                      examCount: '40 exams now',
                      dateText: '24/08/2026',
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _buildBarProgramCard(
                      title: 'BAR Program',
                      subtitle: 'BAR Program Pass the Bar Council enrolment exam',
                      examCount: '40 exams now',
                      dateText: 'Not scheduled',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 28.h),

              // ========== 4. EXPLORE EVERYTHING SECTION ==========
              Text(
                'Explore everything',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2C43),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Access all study resources, practice hubs and learning tools',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.h),

              // Horizontal Scroll Cards
              SizedBox(
                height: 160.h,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildExploreCard(
                      title: 'World History',
                      subtitle: 'BJS & BAR Pdf',
                      isDark: true,
                    ),
                    SizedBox(width: 12.w),
                    _buildExploreCard(
                      title: 'Question Bank',
                      subtitle: 'BJS, BAR & BCS Exam Questions',
                      isDark: false,
                    ),
                    SizedBox(width: 12.w),
                    _buildExploreCard(
                      title: 'All Notes',
                      subtitle: 'All BJS PDF Notes',
                      isDark: false,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),

              // ========== 5. MORE TOOLS & RESOURCES SECTION ==========
              _buildMoreToolsSection(),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Header Widget
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(
              'assets/icons/logo.png',
              width: 32.w,
              height: 32.h,
              errorBuilder: (context, error, stackTrace) => Icon(
                Icons.balance,
                color: const Color(0xFFFFC107),
                size: 30.r,
              ),
            ),
            SizedBox(width: 8.w),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
                children: const [
                  TextSpan(
                    text: 'Lex ',
                    style: TextStyle(color: Color(0xFF0F2C43)),
                  ),
                  TextSpan(
                    text: 'Academy',
                    style: TextStyle(
                      color: Color(0xFF0F2C43),
                      fontFamily: 'Serif',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Stack(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.black,
                size: 22.r,
              ),
            ),
            Positioned(
              right: 10.w,
              top: 10.h,
              child: Container(
                width: 7.r,
                height: 7.r,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 2. Hero Card Widget (BJS Program)
  Widget _buildBJSProgramCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0B253A),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'BJS Program',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(Icons.shield, color: const Color(0xFFFFC107), size: 16.r),
                  SizedBox(width: 4.w),
                  Text(
                    'Premium',
                    style: TextStyle(
                      color: const Color(0xFFFFC107),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Icon(Icons.access_time, color: Colors.white70, size: 14.r),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  'Crack the Bangladesh Judicial Service exam',
                  style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.sensors, color: Colors.redAccent, size: 18.r),
                      SizedBox(width: 8.w),
                      Text(
                        '40 exams now',
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.white70, size: 16.r),
                      SizedBox(width: 8.w),
                      Text(
                        'Not scheduled',
                        style: TextStyle(color: Colors.white70, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteName.allPackageScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter program',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(Icons.arrow_forward, color: Colors.black, size: 16.r),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. BAR Program Card Widget
  Widget _buildBarProgramCard({
    required String title,
    required String subtitle,
    required String examCount,
    required String dateText,
  }) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: const Color(0xFF0B253A),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(Icons.shield, color: const Color(0xFFFFC107), size: 16.r),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: TextStyle(color: Colors.white70, fontSize: 10.sp),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.sensors, color: Colors.redAccent, size: 14.r),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        examCount,
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white70, size: 13.r),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        dateText,
                        style: TextStyle(color: Colors.white70, fontSize: 10.sp),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: const BoxDecoration(
              color: Color(0xFFFFC107),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.arrow_forward, size: 16.r, color: Colors.black),
          ),
        ],
      ),
    );
  }

  // 4. Explore Card Widget
  Widget _buildExploreCard({
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0B253A) : const Color(0xFFF4F5F7),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF0F2C43),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.grey[600],
                  fontSize: 10.sp,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'View Notes',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF0F2C43),
                  fontSize: 11.sp,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.r),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFFFFC107) : Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.north_east,
                  size: 14.r,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 5. More Tools & Resources Section Widget
  Widget _buildMoreToolsSection() {
    final List<Map<String, dynamic>> toolsList = [
      {
        'title': 'Case References',
        'subtitle': 'DLR,BLD,MLR, SCOB etc.',
        'icon': Icons.menu_book_rounded,
        'iconBgColor': const Color(0xFFE8F5E9),
        'iconColor': const Color(0xFF2E7D32),
      },
      {
        'title': 'Legal Research',
        'subtitle': 'In-depth legal analysis & research',
        'icon': Icons.search_rounded,
        'iconBgColor': const Color(0xFFE0F7FA),
        'iconColor': const Color(0xFF00838F),
      },
      {
        'title': 'Flashcards',
        'subtitle': 'Memory tools for quick revision',
        'icon': Icons.style_rounded,
        'iconBgColor': const Color(0xFFFFF3E0),
        'iconColor': const Color(0xFFE65100),
      },
      {
        'title': 'Legal Dictionary',
        'subtitle': 'Legal maxims & key definitions',
        'icon': Icons.import_contacts_rounded,
        'iconBgColor': const Color(0xFFF3E5F5),
        'iconColor': const Color(0xFF6A1B9A),
      },
      {
        'title': 'Books',
        'subtitle': 'Recommended legal textbooks',
        'icon': Icons.article_rounded,
        'iconBgColor': const Color(0xFFE8F5E9),
        'iconColor': const Color(0xFF2E7D32),
      },
      {
        'title': 'Articles',
        'subtitle': 'Expert legal blogs & insights',
        'icon': Icons.assignment_rounded,
        'iconBgColor': const Color(0xFFFBE9E7),
        'iconColor': const Color(0xFFD84315),
      },
      {
        'title': 'Courses',
        'subtitle': 'Structured video & lecture series',
        'icon': Icons.school_rounded,
        'iconBgColor': const Color(0xFFFFEBEE),
        'iconColor': const Color(0xFFC62828),
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'More Tools & Resources',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F2C43),
          ),
        ),
        SizedBox(height: 16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: toolsList.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final tool = toolsList[index];
            return _buildToolTile(
              title: tool['title'],
              subtitle: tool['subtitle'],
              icon: tool['icon'],
              iconBgColor: tool['iconBgColor'],
              iconColor: tool['iconColor'],
              onTap: () {},
            );
          },
        ),
      ],
    );
  }

  // Tool Tile Item
  Widget _buildToolTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22.r,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2C43),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey[600],
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFC107),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14.r,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}