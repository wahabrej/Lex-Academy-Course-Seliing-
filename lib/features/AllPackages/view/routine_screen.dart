import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/routine_model.dart';
import '../viewModel/routine_view_model.dart';

class RoutineScreen extends StatefulWidget {
  final String packageId;
  final String programType;

  const RoutineScreen({
    super.key,
    required this.packageId,
    this.programType = "bjs",
  });

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final routineVm = Provider.of<RoutineViewModel>(context, listen: false);
      routineVm.fetchRoutineStats(
        packageId: widget.packageId,
        programType: widget.programType,
      );
      routineVm.fetchRoutines(
        packageId: widget.packageId,
        programType: widget.programType,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final routineVm = Provider.of<RoutineViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, 'Class & Exam Routine'),
          Expanded(
            child: routineVm.isLoading && routineVm.routines.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF072B3E)),
                  )
                : routineVm.errorMessage != null && routineVm.routines.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          routineVm.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            routineVm.fetchRoutineStats(
                              packageId: widget.packageId,
                              programType: widget.programType,
                            );
                            routineVm.fetchRoutines(
                              packageId: widget.packageId,
                              programType: widget.programType,
                            );
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      await routineVm.fetchRoutineStats(
                        packageId: widget.packageId,
                        programType: widget.programType,
                      );
                      await routineVm.fetchRoutines(
                        packageId: widget.packageId,
                        programType: widget.programType,
                      );
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // স্ট্যাটাস কার্ড
                          _buildStatusOverview(routineVm),
                          SizedBox(height: 24.h),

                          if (routineVm.stats?.nextExamDate != null) ...[
                            _buildNextExamCard(routineVm.stats!.nextExamDate!),
                            SizedBox(height: 24.h),
                          ],

                          Text(
                            'Schedule List',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF072B3E),
                            ),
                          ),
                          SizedBox(height: 12.h),

                          if (routineVm.routines.isEmpty)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('No routines found.'),
                              ),
                            )
                          else
                            ...routineVm.routines.map(
                              (routine) => Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: _buildRoutineCard(routine),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

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
                title,
                style: TextStyle(
                  fontSize: 18.sp,
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

  Widget _buildStatusOverview(RoutineViewModel vm) {
    final stats = vm.stats;
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: const Color(0xFF072B3E),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statusItem(stats?.totalRoutine.toString() ?? '0', 'Total'),
          _statusItem(stats?.done.toString() ?? '0', 'Done'),
          _statusItem(stats?.remaining.toString() ?? '0', 'Remaining'),
        ],
      ),
    );
  }

  Widget _statusItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: const Color(0xFFF5B301),
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white60, fontSize: 11.sp),
        ),
      ],
    );
  }

  Widget _buildNextExamCard(String rawDate) {
    final date = DateTime.tryParse(rawDate);
    if (date == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Icon(Icons.event_available, color: Colors.green.shade700),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Next exam',
                  style: TextStyle(
                    color: Colors.green.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  _formatDateTime(date),
                  style: TextStyle(fontSize: 12.sp, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoutineCard(RoutineItem routine) {
    final examDate = DateTime.tryParse(routine.examDate ?? '');
    final type = routine.routineType ?? 'Routine';

    return Container(
      padding: EdgeInsets.all(16.w),
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
      child: Row(
        children: [
          Icon(
            type.toLowerCase() == 'exam'
                ? Icons.assignment_outlined
                : Icons.event_note_outlined,
            color: const Color(0xFF072B3E),
            size: 28.r,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  routine.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF072B3E),
                  ),
                ),
                if (routine.description?.isNotEmpty == true) ...[
                  SizedBox(height: 4.h),
                  Text(
                    routine.description!,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                SizedBox(height: 8.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 6.h,
                  children: [
                    _routineTag(type, Colors.orange),
                    if (routine.routineNumber?.isNotEmpty == true)
                      _routineTag(routine.routineNumber!, Colors.indigo),
                    if (routine.track?.isNotEmpty == true)
                      _routineTag(routine.track!, Colors.teal),
                    if (routine.sessionLabel?.isNotEmpty == true)
                      _routineTag(routine.sessionLabel!, Colors.blueGrey),
                    if (routine.academicYear != null)
                      _routineTag(
                        routine.academicYear.toString(),
                        Colors.blueGrey,
                      ),
                    if (routine.fileUrl?.isNotEmpty == true ||
                        routine.filePath?.isNotEmpty == true)
                      _routineTag('File attached', Colors.deepPurple),
                    if (routine.isPublished)
                      _routineTag('Published', Colors.green),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.calendar_month, size: 14.sp, color: Colors.grey),
                    SizedBox(width: 5.w),
                    Expanded(
                      child: Text(
                        examDate == null
                            ? 'Date not set'
                            : _formatDateTime(examDate),
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ],
                ),
                if (routine.package?.title.isNotEmpty == true) ...[
                  SizedBox(height: 5.h),
                  Text(
                    routine.package!.title,
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _routineTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDateTime(DateTime date) {
    final localDate = date.toLocal();
    final dateLabel = DateFormat('dd MMM yyyy').format(localDate);
    final timeLabel = DateFormat('hh:mm a').format(localDate);
    return '$dateLabel • $timeLabel';
  }
}
