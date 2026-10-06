import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../viewModel/exam_view_model.dart';

class ResultScreen extends StatefulWidget {
  final String packageId;
  const ResultScreen({super.key, required this.packageId});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int _selectedTab = 0; // 0 = Result, 1 = Merit List, 2 = Details
  String? _selectedExamId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final examVm = Provider.of<ExamViewModel>(context, listen: false);
      examVm.fetchExamAttempts(packageId: widget.packageId);
      examVm.fetchSubjectBreakdown(widget.packageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final examVm = Provider.of<ExamViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার ----------------
          _buildHeader(context, 'Result'),

          // ---------------- বডি ----------------
          Expanded(
            child: examVm.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF072B3E)),
                  )
                : examVm.errorMessage != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          examVm.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        SizedBox(height: 10.h),
                        ElevatedButton(
                          onPressed: () {
                            examVm.fetchExamAttempts(
                              packageId: widget.packageId,
                            );
                            examVm.fetchSubjectBreakdown(widget.packageId);
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---------------- ট্যাব রো ----------------
                        Row(
                          children: [
                            _buildTabChip('Result', 0),
                            SizedBox(width: 8.w),
                            _buildTabChip('Merit List', 1),
                            SizedBox(width: 8.w),
                            _buildTabChip('Details', 2),
                          ],
                        ),
                        SizedBox(height: 20.h),

                        // ---------------- ট্যাব কন্টেন্ট ----------------
                        if (_selectedTab == 0) _buildResultTab(examVm),
                        if (_selectedTab == 1) _buildMeritListTab(examVm),
                        if (_selectedTab == 2) _buildDetailsTab(examVm),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  //                        হেডার
  // ============================================================
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
              SizedBox(height: 8.h),
              Text(
                'বিজেএস পরীক্ষার ফলাফল ও পারফরম্যান্স',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  //                        ট্যাব চিপ
  // ============================================================
  Widget _buildTabChip(String label, int index) {
    final bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
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
      ),
    );
  }

  // ============================================================
  //                    ১. Result ট্যাব
  // ============================================================
  Widget _buildResultTab(ExamViewModel examVm) {
    if (examVm.attempts.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('কোনো পরীক্ষার ফলাফল পাওয়া যায়নি।'),
        ),
      );
    }

    return Column(
      children: [
        ...examVm.attempts.map(
          (attempt) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: _buildResultCard(
              date: attempt.startedAt != null
                  ? "${attempt.startedAt!.day}/${attempt.startedAt!.month}/${attempt.startedAt!.year}"
                  : 'N/A',
              title: 'Exam ID: ${attempt.examId}',
              subject: attempt.status.toUpperCase(),
              score: "${attempt.score ?? 0} / 100",
              rank: 'Completed',
              onTapMerit: () {
                setState(() {
                  _selectedExamId = attempt.examId;
                  _selectedTab = 1;
                });
                examVm.fetchMeritList(attempt.examId);
              },
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  //                  ২. Merit List ট্যাব
  // ============================================================
  Widget _buildMeritListTab(ExamViewModel examVm) {
    final meritItems = examVm.meritList?.items ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_selectedExamId != null) ...[
          Text(
            'Selected Exam ID: $_selectedExamId',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF072B3E),
            ),
          ),
          SizedBox(height: 10.h),
        ],

        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey.shade500, size: 20.sp),
              SizedBox(width: 8.w),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'নাম দিয়ে খুঁজুন...',
                    hintStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade500,
                    ),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        if (meritItems.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'অনুগ্রহ করে Result ট্যাব থেকে যেকোনো পরীক্ষার View Merit List বাটনে ক্লিক করুন।',
              ),
            ),
          )
        else
          ...meritItems.map(
            (student) => _buildMeritListItem(
              name: student.name,
              dept: student.department ?? 'সাধারণ',
              score: student.score,
              rank: student.rank.toString(),
              image: student.image,
            ),
          ),
      ],
    );
  }

  // ============================================================
  //                  ৩. Details ট্যাব
  // ============================================================
  Widget _buildDetailsTab(ExamViewModel examVm) {
    final items = examVm.subjectBreakdown?.items ?? [];

    if (items.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Text('কোনো বিষয়ভিত্তিক ব্রেকডাউন তথ্য পাওয়া যায়নি।'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Subject Breakdown',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF072B3E),
          ),
        ),
        SizedBox(height: 12.h),
        ...items.map(
          (d) => _buildSubjectDetailCard(
            subject: d.subject,
            correct: d.correct.toString(),
            wrong: d.wrong.toString(),
            skipped: d.skipped.toString(),
            score: d.score,
            accuracy: d.accuracy,
          ),
        ),
      ],
    );
  }

  // ============================================================
  //                  রেজাল্ট কার্ড উইজেট
  // ============================================================
  Widget _buildResultCard({
    required String date,
    required String title,
    required String subject,
    required String score,
    required String rank,
    required VoidCallback onTapMerit,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    Text(
                      'Archive',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                    Text(
                      'Exam',
                      style: TextStyle(
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                  ],
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1A1A1A),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '$subject • $date',
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.grey.shade200),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'স্কোর',
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    score,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFE53935),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: onTapMerit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF072B3E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'View Merit List',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeritListItem({
    required String name,
    required String score,
    required String rank,
    required String dept,
    String? image,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(image ?? 'https://i.pravatar.cc/150'),
            radius: 20.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  dept,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Marks: $score',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(
                'Rank: #$rank',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.orange.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectDetailCard({
    required String subject,
    required String correct,
    required String wrong,
    required String skipped,
    required String score,
    required String accuracy,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF072B3E),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Correct: $correct',
                style: TextStyle(fontSize: 12.sp, color: Colors.green),
              ),
              Text(
                'Wrong: $wrong',
                style: TextStyle(fontSize: 12.sp, color: Colors.red),
              ),
              Text(
                'Skipped: $skipped',
                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Score: $score',
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                'Accuracy: $accuracy',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
