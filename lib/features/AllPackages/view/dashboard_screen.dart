import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার (Updated with rounded corners and back button) ----------------
          _buildHeader(context),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- ট্যাব রো ----------------
                  Row(
                    children: [
                      _buildTabChip('Overview', true),
                      SizedBox(width: 8.w),
                      _buildTabChip('Subject', false),
                      SizedBox(width: 8.w),
                      _buildTabChip('Program', false),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // ---------------- স্ট্যাটস গ্রিড ----------------
                  _buildStatsGrid(),
                  SizedBox(height: 20.h),

                  // ---------------- টপিক পারফরম্যান্স ----------------
                  _buildTopicPerformance(),
                  SizedBox(height: 16.h),

                  // ---------------- উইকনেস্ট এরিয়া ----------------
                  _buildWeakestArea(context),
                  SizedBox(height: 16.h),

                  // ---------------- স্কোর ট্রেন্ড ----------------
                  _buildScoreTrend(),
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
              SizedBox(width: 16.w),
              Text(
                'Dashboard',
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

  // ---------------- ট্যাব চিপ ----------------
  Widget _buildTabChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF072B3E) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? const Color(0xFF072B3E) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  // ---------------- স্ট্যাটস গ্রিড ----------------
  Widget _buildStatsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                value: '20',
                label: 'Questions Answered',
                color: const Color(0xFFE3F2FD),
                iconColor: const Color(0xFF1E88E5),
                icon: Icons.help_outline,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                value: '2',
                label: 'Correct',
                color: const Color(0xFFE8F5E9),
                iconColor: const Color(0xFF43A047),
                icon: Icons.check_circle_outline,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                value: '18',
                label: 'Wrong',
                color: const Color(0xFFFFEBEE),
                iconColor: const Color(0xFFE53935),
                icon: Icons.close,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                value: '9%',
                label: 'Avg Accuracy',
                color: const Color(0xFFFFF8E1),
                iconColor: const Color(0xFFF5B301),
                icon: Icons.signal_cellular_alt,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
    required Color iconColor,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20.sp),
          SizedBox(height: 12.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- টপিক পারফরম্যান্স ----------------
  Widget _buildTopicPerformance() {
    final topics = [
      {'name': '১৭তম বিজেএস/ব্যাংক / প্রিলিমিনারি', 'value': 10, 'color': const Color(0xFF1E88E5)},
      {'name': 'সাধারণ জ্ঞান ও বাংলা', 'value': 25, 'color': const Color(0xFF1E88E5)},
      {'name': 'সমকালীন বিষয়াবলী', 'value': 40, 'color': const Color(0xFF1E88E5)},
      {'name': 'বাংলা ভাষা ও সাহিত্য', 'value': 55, 'color': const Color(0xFF1E88E5)},
      {'name': 'সাধারণ বিজ্ঞান', 'value': 60, 'color': const Color(0xFF1E88E5)},
      {'name': 'ভূগোল ও পরিবেশ', 'value': 70, 'color': const Color(0xFF1E88E5)},
      {'name': 'সাধারণ গণিত', 'value': 65, 'color': const Color(0xFF1E88E5)},
      {'name': 'নৈতিকতা ও সুশাসন', 'value': 50, 'color': const Color(0xFF1E88E5)},
      {'name': 'ইংরেজি সাহিত্য', 'value': 30, 'color': const Color(0xFF1E88E5)},
      {'name': '১৭তম বিজেএস/ব্যাংক', 'value': 20, 'color': const Color(0xFF1E88E5)},
      {'name': '১৮তম বিজেএস/ব্যাংক', 'value': 15, 'color': const Color(0xFF1E88E5)},
    ];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Topic Performance',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 16.h),
          ...topics.map((topic) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Text(
                    topic['name'] as String,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xFF1A1A1A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 5,
                  child: Stack(
                    children: [
                      Container(
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: (topic['value'] as int) / 100,
                        child: Container(
                          height: 12.h,
                          decoration: BoxDecoration(
                            color: topic['color'] as Color,
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  '${topic['value']}%',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          )),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0%', style: TextStyle(fontSize: 9.sp, color: Colors.grey)),
              Text('25%', style: TextStyle(fontSize: 9.sp, color: Colors.grey)),
              Text('50%', style: TextStyle(fontSize: 9.sp, color: Colors.grey)),
              Text('75%', style: TextStyle(fontSize: 9.sp, color: Colors.grey)),
              Text('100%', style: TextStyle(fontSize: 9.sp, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------- উইকনেস্ট এরিয়া ----------------
  Widget _buildWeakestArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: const Color(0xFFE53935),
                size: 20.sp,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weakest Area: ১৭তম বিজেএস/ব্যাংক / BJS (BAR) / BJS (লিখিত) প্রিলিমিনারি',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        height: 1.5,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Accuracy: 0% (0 correct out of 10 attempted)',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: double.infinity,
            height: 44.h,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.refresh, color: Colors.white, size: 16.sp),
              label: Text(
                'Review Now',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF072B3E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.r),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- স্কোর ট্রেন্ড ----------------
  Widget _buildScoreTrend() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Score Trend',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 16.h),
          SizedBox(
            height: 180.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  horizontalInterval: 25,
                  verticalInterval: 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        final dates = [
                          '20 Feb',
                          '27 Feb',
                          '13 Mar',
                          '10 Apr',
                          '18 Apr',
                          '24 Apr',
                          '31 Apr',
                        ];
                        if (value.toInt() < dates.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              dates[value.toInt()],
                              style: TextStyle(
                                fontSize: 8.sp,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 25,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: TextStyle(
                            fontSize: 9.sp,
                            color: Colors.grey.shade600,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 100,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 10),
                      FlSpot(1, 25),
                      FlSpot(2, 15),
                      FlSpot(3, 40),
                      FlSpot(4, 30),
                      FlSpot(5, 20),
                      FlSpot(6, 28),
                    ],
                    isCurved: true,
                    color: const Color(0xFF072B3E),
                    barWidth: 2,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 3,
                          color: const Color(0xFF072B3E),
                          strokeWidth: 1.5,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: const Color(0xFF072B3E).withOpacity(0.05),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.arrow_forward, size: 12.sp, color: Colors.grey),
              SizedBox(width: 4.w),
              Text(
                'Score %',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
