import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../viewModel/syllabus_view_model.dart';

class SyllabusScreen extends StatefulWidget {
  final String packageId;
  const SyllabusScreen({super.key, this.packageId = "204259de-0306-4e04-98d6-8e15ab9ad783"});

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
    Provider.of<SyllabusViewModel>(context, listen: false)
        .fetchSyllabuses(packageId: widget.packageId);
  }

  @override
  Widget build(BuildContext context) {
    final syllabusVm = Provider.of<SyllabusViewModel>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, 'Package Syllabus'),
          Expanded(
            child: syllabusVm.isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF072B3E)))
                : syllabusVm.errorMessage != null
                    ? _buildErrorWidget(syllabusVm)
                    : RefreshIndicator(
                        onRefresh: () async => _fetchSyllabuses(),
                        child: syllabusVm.syllabuses.isEmpty
                            ? _buildEmptyWidget()
                            : ListView.separated(
                                padding: EdgeInsets.all(16.w),
                                itemCount: syllabusVm.syllabuses.length,
                                separatorBuilder: (context, index) => SizedBox(height: 12.h),
                                itemBuilder: (context, index) {
                                  final syllabus = syllabusVm.syllabuses[index];
                                  return _buildSyllabusCard(
                                    title: syllabus.title,
                                    description: syllabus.content ?? 'বিস্তারিত তথ্য দেখার জন্য ক্লিক করুন।',
                                  );
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
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
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
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                  child: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF072B3E), size: 16.sp),
                ),
              ),
              SizedBox(width: 16.w),
              Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSyllabusCard({required String title, required String description}) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(12.r)),
            child: Icon(Icons.menu_book_rounded, color: Colors.teal, size: 24.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
                SizedBox(height: 4.h),
                Text(description, style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Icons.remove_red_eye_outlined, color: Colors.teal),
        ],
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
            child: Text(vm.errorMessage!, style: TextStyle(color: Colors.red, fontSize: 14.sp), textAlign: TextAlign.center),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _fetchSyllabuses,
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF072B3E)),
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
          Text('No syllabuses found.', style: TextStyle(color: Colors.grey, fontSize: 14.sp)),
        ],
      ),
    );
  }
}
