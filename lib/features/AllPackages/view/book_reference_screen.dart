import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/package_content_models.dart';
import '../viewModel/package_content_view_model.dart';

class BookReferenceScreen extends StatefulWidget {
  final String packageId;
  final String? packageName;

  const BookReferenceScreen({
    super.key,
    required this.packageId,
    this.packageName,
  });

  @override
  State<BookReferenceScreen> createState() => _BookReferenceScreenState();
}

class _BookReferenceScreenState extends State<BookReferenceScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackageContentViewModel>().fetchBookReferences(
        widget.packageId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PackageContentViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _header(context, widget.packageName ?? 'Book References'),
          Expanded(
            child:
                viewModel.isLoadingBookReferences &&
                    viewModel.bookReferences.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : viewModel.bookReferencesError != null &&
                      viewModel.bookReferences.isEmpty
                ? _error(viewModel.bookReferencesError!, () {
                    viewModel.fetchBookReferences(widget.packageId);
                  })
                : viewModel.bookReferences.isEmpty
                ? _empty('No book references found for this package.')
                : RefreshIndicator(
                    onRefresh: () =>
                        viewModel.fetchBookReferences(widget.packageId),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      itemCount: viewModel.bookReferences.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) =>
                          _bookCard(viewModel.bookReferences[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _bookCard(BookReferenceItem item) {
    final color = item.isLocked ? Colors.orange : Colors.purple;
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _openDetails(item),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  item.isLocked
                      ? Icons.lock_outline_rounded
                      : Icons.menu_book_rounded,
                  color: color,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
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
                        ...item.categories.map(
                          (category) => _tag(category, Colors.teal),
                        ),
                        ...item.tracks.map(
                          (track) => _tag(track, Colors.indigo),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _tag(item.isLocked ? 'Locked' : 'Available', color),
                        if (item.createdAt != null) ...[
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              DateFormat(
                                'dd MMM yyyy',
                              ).format(item.createdAt!.toLocal()),
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.grey[500]),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openDetails(BookReferenceItem item) async {
    final detail = await context
        .read<PackageContentViewModel>()
        .fetchBookReferenceDetail(item.id);
    if (!mounted) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.8,
          ),
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detail?.title ?? item.title,
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
                    detail?.content?.isNotEmpty == true
                        ? detail!.content!
                        : item.isLocked
                        ? 'এই book reference দেখতে package access প্রয়োজন।'
                        : 'বিস্তারিত তথ্য পাওয়া যায়নি।',
                    style: TextStyle(fontSize: 14.sp, height: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String text, Color color) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 9.sp,
        fontWeight: FontWeight.w600,
      ),
    ),
  );

  Widget _header(BuildContext context, String title) => Container(
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
                title,
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

  Widget _empty(String message) => Center(child: Text(message));
}
