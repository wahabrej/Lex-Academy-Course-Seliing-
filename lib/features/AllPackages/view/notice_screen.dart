import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/package_content_models.dart';
import '../viewModel/package_content_view_model.dart';

class NoticeScreen extends StatefulWidget {
  final String packageId;
  final String? packageName;

  const NoticeScreen({super.key, required this.packageId, this.packageName});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackageContentViewModel>().fetchAnnouncements(
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
          _header(context, widget.packageName ?? 'Announcements'),
          Expanded(
            child:
                viewModel.isLoadingAnnouncements &&
                    viewModel.announcements.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : viewModel.announcementsError != null &&
                      viewModel.announcements.isEmpty
                ? _error(viewModel.announcementsError!, () {
                    viewModel.fetchAnnouncements(widget.packageId);
                  })
                : viewModel.announcements.isEmpty
                ? const Center(
                    child: Text('No announcements for this package.'),
                  )
                : RefreshIndicator(
                    onRefresh: () =>
                        viewModel.fetchAnnouncements(widget.packageId),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      itemCount: viewModel.announcements.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) =>
                          _noticeCard(viewModel.announcements[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _noticeCard(AnnouncementItem item) {
    final priorityColor = item.badge?.toLowerCase() == 'urgent'
        ? Colors.red
        : const Color(0xFF00838F);
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
        side: item.isPinned
            ? const BorderSide(color: Color(0xFFF5B301))
            : BorderSide.none,
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8.w,
              runSpacing: 6.h,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                if (item.isPinned)
                  _tag('PINNED', const Color(0xFFB78100), Icons.push_pin),
                if (item.badge?.isNotEmpty == true)
                  _tag(item.badge!.toUpperCase(), priorityColor),
                if (item.createdAt != null)
                  Text(
                    DateFormat('dd MMM yyyy').format(item.createdAt!.toLocal()),
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                  ),
              ],
            ),
            SizedBox(height: 10.h),
            Text(
              item.title,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF072B3E),
                height: 1.4,
              ),
            ),
            if (item.body?.isNotEmpty == true) ...[
              SizedBox(height: 8.h),
              Text(
                item.body!,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
            if (item.targetAudience?.isNotEmpty == true ||
                item.program?.isNotEmpty == true) ...[
              SizedBox(height: 10.h),
              Wrap(
                spacing: 6.w,
                children: [
                  if (item.targetAudience?.isNotEmpty == true)
                    _tag(item.targetAudience!, Colors.blueGrey),
                  if (item.program?.isNotEmpty == true)
                    _tag(item.program!, Colors.indigo),
                ],
              ),
            ],
            if (item.link?.isNotEmpty == true) ...[
              SizedBox(height: 8.h),
              SelectableText(
                item.link!,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.blue.shade700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _tag(String label, Color color, [IconData? icon]) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(6.r),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 11.r, color: color),
          SizedBox(width: 3.w),
        ],
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 9.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
}
