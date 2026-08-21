import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageRoutineScreen extends StatelessWidget {
  const PackageRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            _buildHeader(context),
            SizedBox(height: 12.h),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Column(
                  children: [
                    // Active Section Block
                    _buildSectionBlock(
                      sectionTitle: 'Active',
                      badgeCount: '1',
                      icon: Icons.calendar_month_rounded,
                      child: _buildRoutineCard(
                        statusText: 'Active',
                        statusBgColor: const Color(0xFFE8F5E9),
                        statusTextColor: const Color(0xFF2E7D32),
                        title: '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
                        routineTag: '৪৫তম পরীক্ষার রুটিন',
                        categoryTag: 'প্রিলিমিনারি',
                        examDate: '১৬ আগস্ট ২০২৬',
                        syllabusItems: [
                          'বিসিএস প্রশ্নব্যাংক',
                          '৪০-৫০ তম',
                          'সাধারণ জ্ঞান - আগস্ট সমাচার',
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Archived Section Block
                    _buildSectionBlock(
                      sectionTitle: 'Archived',
                      badgeCount: '৪২',
                      icon: Icons.edit_calendar_rounded,
                      child: Column(
                        children: [
                          _buildRoutineCard(
                            statusText: 'Active',
                            statusBgColor: const Color(0xFFE8F5E9),
                            statusTextColor: const Color(0xFF2E7D32),
                            title: '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
                            routineTag: '৪৫তম পরীক্ষার রুটিন',
                            categoryTag: 'প্রিলিমিনারি',
                            examDate: '১৬ আগস্ট ২০২৬',
                            syllabusItems: [
                              'বিসিএস প্রশ্নব্যাংক',
                              '৪০-৫০ তম',
                              'সাধারণ জ্ঞান - আগস্ট সমাচার',
                            ],
                          ),
                          SizedBox(height: 14.h),
                          _buildRoutineCard(
                            statusText: 'Active',
                            statusBgColor: const Color(0xFFE8F5E9),
                            statusTextColor: const Color(0xFF2E7D32),
                            title: '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি',
                            routineTag: '৪৫তম পরীক্ষার রুটিন',
                            categoryTag: 'প্রিলিমিনারি',
                            examDate: '১৬ আগস্ট ২০২৬',
                            syllabusItems: [
                              'বিসিএস প্রশ্নব্যাংক',
                              '৪০-৫০ তম',
                              'সাধারণ জ্ঞান - আগস্ট সমাচার',
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. Header Widget
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
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'এই প্যাকেজের রুটিন',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F2C43),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '১৯তম বিজেএস প্রিলি পরীক্ষার প্রস্তুতি,ফেব্রুয়ারি',
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
        ],
      ),
    );
  }

  // 2. Outer Section Wrapper Container (Grey Box for Active/Archived Groups)
  Widget _buildSectionBlock({
    required String sectionTitle,
    required String badgeCount,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F5F8),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDCE2E8),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      icon,
                      size: 20.r,
                      color: const Color(0xFF0F2C43),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    sectionTitle,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F2C43),
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC107),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Text(
                  badgeCount,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          child,
        ],
      ),
    );
  }

  // 3. Inner White Routine Card Widget
  Widget _buildRoutineCard({
    required String statusText,
    required Color statusBgColor,
    required Color statusTextColor,
    required String title,
    required String routineTag,
    required String categoryTag,
    required String examDate,
    required List<String> syllabusItems,
  }) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFF0F2C43).withOpacity(0.15), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status Pill Badge
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                color: statusTextColor,
              ),
            ),
          ),
          SizedBox(height: 10.h),

          // Routine Title
          Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F2C43),
              height: 1.3,
            ),
          ),
          SizedBox(height: 12.h),

          // Chips Row (Routine Tag & Category)
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: [
              _buildSmallChip(
                icon: Icons.calendar_month_outlined,
                label: routineTag,
              ),
              _buildSmallChip(
                label: categoryTag,
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Exam Date Row
          Row(
            children: [
              Icon(
                Icons.calendar_today_rounded,
                size: 14.r,
                color: const Color(0xFFFF9800),
              ),
              SizedBox(width: 6.w),
              Text(
                'পরীক্ষা: $examDate',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF0F2C43),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Syllabus / Subject Items
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: syllabusItems
                .map(
                  (item) => Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  item,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ),
            )
                .toList(),
          ),
          SizedBox(height: 14.h),

          // Yellow Details Button
          SizedBox(
            width: double.infinity,
            height: 38.h,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'বিস্তারিত',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.black,
                    size: 16.r,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Small Helper Chip Widget
  Widget _buildSmallChip({IconData? icon, required String label}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEBF1F6),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 12.r,
              color: const Color(0xFF0F2C43),
            ),
            SizedBox(width: 4.w),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0F2C43),
            ),
          ),
        ],
      ),
    );
  }
}