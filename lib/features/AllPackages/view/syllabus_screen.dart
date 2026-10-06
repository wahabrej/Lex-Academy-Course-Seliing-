import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../model/syllabus_model.dart';
import '../viewModel/syllabus_view_model.dart';

class SyllabusScreen extends StatefulWidget {
  final String packageId;
  final String? packageName;

  const SyllabusScreen({super.key, required this.packageId, this.packageName});

  @override
  State<SyllabusScreen> createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSyllabuses();
    });
  }

  void _fetchSyllabuses() {
    Provider.of<SyllabusViewModel>(
      context,
      listen: false,
    ).fetchSyllabuses(packageId: widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    final syllabusVm = Provider.of<SyllabusViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, widget.packageName ?? 'Package Syllabus'),
          Expanded(
            child: syllabusVm.isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF072B3E)),
                  )
                : syllabusVm.errorMessage != null
                ? _buildErrorWidget(syllabusVm)
                : RefreshIndicator(
                    onRefresh: () async => _fetchSyllabuses(),
                    child: syllabusVm.syllabuses.isEmpty
                        ? _buildEmptyWidget()
                        : ListView.separated(
                            padding: EdgeInsets.all(16.w),
                            itemCount: syllabusVm.syllabuses.length,
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final syllabus = syllabusVm.syllabuses[index];
                              return _buildSyllabusCard(syllabus);
                            },
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

  Widget _buildSyllabusCard(SyllabusItem syllabus) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _showSyllabusDetails(syllabus),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F2F1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: Colors.teal,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          syllabus.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF072B3E),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: [
                            if (syllabus.track?.isNotEmpty == true)
                              _syllabusTag(syllabus.track!, Colors.teal),
                            _syllabusTag(
                              syllabus.isPublished
                                  ? 'Published'
                                  : 'Unpublished',
                              syllabus.isPublished ? Colors.green : Colors.grey,
                            ),
                            if (syllabus.fileUrl?.isNotEmpty == true ||
                                syllabus.filePath?.isNotEmpty == true)
                              _syllabusTag(
                                syllabus.fileMimeType ?? 'File attached',
                                Colors.deepPurple,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.open_in_new_rounded,
                    color: Colors.teal,
                    size: 18.r,
                  ),
                ],
              ),
              if (syllabus.content?.isNotEmpty == true) ...[
                SizedBox(height: 12.h),
                Text(
                  syllabus.content!,
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 1.45,
                    color: Colors.grey[700],
                  ),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              if (syllabus.packages.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: syllabus.packages
                      .map(
                        (package) => _syllabusTag(
                          package.title,
                          const Color(0xFF607D8B),
                        ),
                      )
                      .toList(),
                ),
              ],
              if (syllabus.updatedAt != null) ...[
                SizedBox(height: 10.h),
                Text(
                  'Updated ${_formatDate(syllabus.updatedAt!)}',
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _syllabusTag(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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

  String _formatDate(String value) {
    final date = DateTime.tryParse(value);
    return date == null
        ? value
        : DateFormat('dd MMM yyyy').format(date.toLocal());
  }

  void _showSyllabusDetails(SyllabusItem syllabus) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
          ),
          padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                syllabus.title,
                style: TextStyle(
                  color: const Color(0xFF072B3E),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    syllabus.content?.isNotEmpty == true
                        ? syllabus.content!
                        : 'No syllabus details available.',
                    style: TextStyle(fontSize: 14.sp, height: 1.55),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(SyllabusViewModel vm) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Text(
              vm.errorMessage!,
              style: TextStyle(color: Colors.red, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _fetchSyllabuses,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF072B3E),
            ),
            child: const Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined, color: Colors.grey, size: 48.sp),
          SizedBox(height: 16.h),
          Text(
            'No syllabuses found.',
            style: TextStyle(color: Colors.grey, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
