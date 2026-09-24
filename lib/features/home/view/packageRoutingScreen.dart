import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PackageRoutingScreen extends StatefulWidget {
  final String packageId;
  final String packageName;

  const PackageRoutingScreen({
    super.key,
    required this.packageId,
    required this.packageName,
  });

  @override
  State<PackageRoutingScreen> createState() => _PackageRoutingScreenState();
}

class _PackageRoutingScreenState extends State<PackageRoutingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F2C43),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.packageName,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          // Package Summary Header
          _buildSummaryHeader(),
          
          // Modules Grid
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(16.r),
              crossAxisCount: 3,
              mainAxisSpacing: 16.r,
              crossAxisSpacing: 16.r,
              children: [
                _buildModuleCard(context, 'Exams', Icons.assignment_rounded, Colors.blue),
                _buildModuleCard(context, 'Routine', Icons.calendar_month_rounded, Colors.orange),
                _buildModuleCard(context, 'Syllabus', Icons.menu_book_rounded, Colors.green),
                _buildModuleCard(context, 'Notes', Icons.description_rounded, Colors.purple),
                _buildModuleCard(context, 'Q-Bank', Icons.quiz_rounded, Colors.teal),
                _buildModuleCard(context, 'References', Icons.library_books_rounded, Colors.brown),
                _buildModuleCard(context, 'Suggestions', Icons.tips_and_updates_rounded, Colors.amber),
                _buildModuleCard(context, 'Notices', Icons.campaign_rounded, Colors.red),
                _buildModuleCard(context, 'Analytics', Icons.bar_chart_rounded, Colors.indigo),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: const BoxDecoration(
        color: Color(0xFF0F2C43),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Total Exams', '90'),
              _buildStatItem('Completed', '12'),
              _buildStatItem('Rank', '156th'),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                const Icon(Icons.notifications_active_outlined, color: Colors.amber, size: 20),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text(
                    'Next Exam: Criminal Procedure Code (Live)',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildModuleCard(BuildContext context, String title, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        // Routing to specific module screens
        _navigateToModule(context, title);
      },
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24.r),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F2C43),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToModule(BuildContext context, String moduleName) {
    // This will be replaced with actual navigation when module screens are ready
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening $moduleName module...')),
    );
  }
}
