import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../model/performance_model.dart';
import '../viewModel/package_view_model.dart';

class DashboardScreen extends StatefulWidget {
  final String packageId;
  final String? packageName;

  const DashboardScreen({super.key, required this.packageId, this.packageName});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackageViewModel>().fetchPackagePerformance(
        widget.packageId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PackageViewModel>();
    final performance = viewModel.performanceData;
    final loading = viewModel.isLoading && performance == null;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _header(context),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : viewModel.errorMessage != null && performance == null
                ? _error(viewModel.errorMessage!, () {
                    viewModel.fetchPackagePerformance(widget.packageId);
                  })
                : performance == null
                ? const Center(child: Text('No performance data available.'))
                : RefreshIndicator(
                    onRefresh: () =>
                        viewModel.fetchPackagePerformance(widget.packageId),
                    child: _performanceContent(performance),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _performanceContent(UserPerformanceAnalytics performance) => ListView(
    physics: const AlwaysScrollableScrollPhysics(),
    padding: EdgeInsets.all(16.w),
    children: [
      Row(
        children: [
          Expanded(
            child: _statCard(
              '${performance.overview.questionsAnswered}',
              'Questions Answered',
              Icons.help_outline,
              const Color(0xFF1E88E5),
              const Color(0xFFE3F2FD),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: _statCard(
              '${_percentage(performance.overview.correctAverage).toStringAsFixed(1)}%',
              'Average Correct',
              Icons.check_circle_outline,
              const Color(0xFF43A047),
              const Color(0xFFE8F5E9),
            ),
          ),
        ],
      ),
      SizedBox(height: 20.h),
      _sectionTitle('Subject Accuracy'),
      if (performance.subjectWiseAccuracy.isEmpty)
        _emptySection('No subject accuracy data yet.')
      else
        ...performance.subjectWiseAccuracy.map(_subjectCard),
      SizedBox(height: 20.h),
      _sectionTitle('Recent Performance'),
      if (performance.overview.topPerformanceGraph.isEmpty)
        _emptySection('No score history available yet.')
      else
        ...performance.overview.topPerformanceGraph.reversed
            .take(10)
            .map(_scoreCard),
      if (performance.overview.weakAreas.isNotEmpty) ...[
        SizedBox(height: 20.h),
        _sectionTitle('Areas to Improve'),
        ...performance.overview.weakAreas.map(_subjectCard),
      ],
      if (performance.overview.topicPerformance.isNotEmpty) ...[
        SizedBox(height: 20.h),
        _sectionTitle('Topic Performance'),
        ...performance.overview.topicPerformance.map(_topicCard),
      ],
      if (performance.programWiseAttempts != null) ...[
        SizedBox(height: 20.h),
        _sectionTitle('Program Comparison'),
        _comparisonCard(performance.programWiseAttempts!),
      ],
    ],
  );

  Widget _statCard(
    String value,
    String label,
    IconData icon,
    Color iconColor,
    Color backgroundColor,
  ) => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 22.r),
        SizedBox(height: 12.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 11.sp, color: Colors.grey[700]),
        ),
      ],
    ),
  );

  Widget _subjectCard(SubjectAccuracy subject) {
    final accuracy = _percentage(subject.accuracy);
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8.h),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    subject.subjectName,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${accuracy.toStringAsFixed(1)}%',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF00897B),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            LinearProgressIndicator(
              value: (accuracy / 100).clamp(0, 1),
              minHeight: 6.h,
              borderRadius: BorderRadius.circular(8.r),
              backgroundColor: Colors.grey.shade200,
              color: const Color(0xFF00897B),
            ),
            SizedBox(height: 8.h),
            Text(
              'Right ${subject.right}  ·  Wrong ${subject.wrong}  ·  Unanswered ${subject.unanswered}',
              style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _scoreCard(ScoreHistoryPoint point) {
    final date = point.date;
    final dateLabel = date == null
        ? 'Performance'
        : '${date.day}/${date.month}/${date.year}';
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8.h),
      child: ListTile(
        dense: true,
        leading: const Icon(Icons.show_chart, color: Color(0xFF3949AB)),
        title: Text(dateLabel),
        subtitle: Text(
          'Score: ${point.score.toStringAsFixed(1)}'
          '  ·  Accuracy: ${_percentage(point.accuracy).toStringAsFixed(1)}%',
        ),
      ),
    );
  }

  Widget _topicCard(TopicPerformance topic) => Card(
    color: Colors.white,
    margin: EdgeInsets.only(top: 8.h),
    child: ListTile(
      dense: true,
      leading: const Icon(Icons.topic_outlined, color: Color(0xFFFB8C00)),
      title: Text(topic.topic.isEmpty ? 'Topic' : topic.topic),
      subtitle: Text(
        '${topic.wrongCount} wrong / ${topic.totalQuestions} questions',
      ),
    ),
  );

  Widget _comparisonCard(ProgramWiseAttempts comparison) => Card(
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _comparisonRow('Your average', comparison.userOverallAverage),
          Divider(height: 20.h),
          _comparisonRow('Platform average', comparison.platformOverallAverage),
          if (comparison.examComparisonTable.isNotEmpty) ...[
            Divider(height: 20.h),
            ...comparison.examComparisonTable.map(
              (exam) => ListTile(
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(exam.examTitle),
                subtitle: Text(
                  'Your score ${exam.userScore.toStringAsFixed(1)}'
                  '  ·  Platform ${exam.platformAverage.toStringAsFixed(1)}',
                ),
              ),
            ),
          ],
        ],
      ),
    ),
  );

  Widget _comparisonRow(String label, double value) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: TextStyle(fontSize: 12.sp)),
      Text(
        value.toStringAsFixed(1),
        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
      ),
    ],
  );

  Widget _sectionTitle(String title) => Padding(
    padding: EdgeInsets.only(bottom: 4.h),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF072B3E),
      ),
    ),
  );

  Widget _emptySection(String message) => Padding(
    padding: EdgeInsets.symmetric(vertical: 12.h),
    child: Text(message, style: TextStyle(color: Colors.grey[600])),
  );

  Widget _header(BuildContext context) => Container(
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
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                widget.packageName == null
                    ? 'Performance'
                    : '${widget.packageName} Performance',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _error(String message, VoidCallback retry) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Text(message, textAlign: TextAlign.center),
        ),
        SizedBox(height: 12.h),
        ElevatedButton(onPressed: retry, child: const Text('Retry')),
      ],
    ),
  );

  double _percentage(double value) => value <= 1 ? value * 100 : value;
}
