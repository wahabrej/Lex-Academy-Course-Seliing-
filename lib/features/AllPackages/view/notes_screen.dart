import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../library/viewModel/note_view_model.dart';
import '../../library/model/note_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String? _currentPackageId; // লুপ বন্ধ করার জন্য ট্র্যাক রাখা হচ্ছে
  String? _packageName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // আর্গুমেন্ট থেকে packageId এবং packageName গ্রহণ করা
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args != null && args['packageId'] != null) {
      final String pkgId = args['packageId'];

      // GUARD: যদি packageId নতুন হয় এবং আগে লোড করা না হয়ে থাকে, তবেই এপিআই কল হবে
      if (pkgId != _currentPackageId) {
        _currentPackageId = pkgId;
        _packageName = args['packageName'];

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final noteVm = context.read<NoteViewModel>();
            noteVm.updateFilters(packageId: pkgId);
            noteVm.fetchNotes(isRefresh: true);
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // এখানে watch ব্যবহার করা হয়েছে স্টেট পরিবর্তনের সাথে ইউআই আপডেট করার জন্য
    final noteVm = context.watch<NoteViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, _packageName ?? 'Package Notes'),
          Expanded(
            child: noteVm.isLoading && noteVm.notes.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(color: Color(0xFF072B3E)),
                  )
                : noteVm.errorMessage != null && noteVm.notes.isEmpty
                ? _buildErrorState(noteVm)
                : noteVm.notes.isEmpty
                ? _buildEmptyState()
                : RefreshIndicator(
                    onRefresh: () => noteVm.fetchNotes(isRefresh: true),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.extentAfter < 240 &&
                            noteVm.hasMore &&
                            !noteVm.isLoading) {
                          noteVm.fetchNotes();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.all(16.w),
                        itemCount:
                            noteVm.notes.length + (noteVm.isLoading ? 1 : 0),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          if (index == noteVm.notes.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(12),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return _buildNoteCard(noteVm.notes[index]);
                        },
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
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _showNoteDetails(note),
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
                      color: note.isLocked
                          ? Colors.amber.shade50
                          : const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      note.isLocked
                          ? Icons.lock_outline
                          : Icons.description_outlined,
                      color: note.isLocked
                          ? Colors.amber.shade800
                          : const Color(0xFF2E7D32),
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          note.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF072B3E),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: [
                            _noteTag(note.subject, Colors.blueGrey),
                            _noteTag(
                              note.tier.toUpperCase(),
                              note.tier.toLowerCase() == 'free'
                                  ? Colors.green
                                  : Colors.deepPurple,
                            ),
                            if (note.fileMime.isNotEmpty)
                              _noteTag(
                                note.fileMime.split('/').last.toUpperCase(),
                                Colors.blue,
                              ),
                            if (note.isLocked)
                              _noteTag('LOCKED', Colors.orange),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (note.description.isNotEmpty) ...[
                SizedBox(height: 12.h),
                Text(
                  note.description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    height: 1.4,
                    color: Colors.grey[700],
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(child: _buildPrice(note)),
                  Icon(Icons.download_outlined, size: 15.r, color: Colors.grey),
                  SizedBox(width: 4.w),
                  Text(
                    '${note.downloadCount}',
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
              if (note.packages.isNotEmpty) ...[
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: note.packages
                      .map((package) => _noteTag(package.title, Colors.teal))
                      .toList(),
                ),
              ],
              if (note.createdAt != null) ...[
                SizedBox(height: 10.h),
                Text(
                  'Added ${DateFormat('dd MMM yyyy').format(note.createdAt!.toLocal())}',
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey[500]),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrice(Note note) {
    if (note.price <= 0) {
      return Text(
        'Free',
        style: TextStyle(
          color: Colors.green.shade700,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      );
    }

    final hasDiscount =
        note.discountPrice > 0 && note.discountPrice < note.price;
    return Row(
      children: [
        if (hasDiscount)
          Text(
            '৳${note.price}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11.sp,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        if (hasDiscount) SizedBox(width: 6.w),
        Text(
          '৳${hasDiscount ? note.discountPrice : note.price}',
          style: TextStyle(
            color: const Color(0xFF072B3E),
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          ),
        ),
      ],
    );
  }

  Widget _noteTag(String label, Color color) {
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

  void _showNoteDetails(Note note) {
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
                note.title,
                style: TextStyle(
                  color: const Color(0xFF072B3E),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: [
                  _noteTag(note.subject, Colors.blueGrey),
                  _noteTag(note.tier.toUpperCase(), Colors.deepPurple),
                  _noteTag(
                    note.isLocked ? 'LOCKED' : 'AVAILABLE',
                    note.isLocked ? Colors.orange : Colors.green,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        note.description.isNotEmpty
                            ? note.description
                            : 'No description available.',
                        style: TextStyle(fontSize: 14.sp, height: 1.5),
                      ),
                      SizedBox(height: 14.h),
                      Text(
                        'Price: ${note.price <= 0 ? 'Free' : '৳${note.discountPrice > 0 && note.discountPrice < note.price ? note.discountPrice : note.price}'}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (note.fileMime.isNotEmpty) ...[
                        SizedBox(height: 8.h),
                        Text('File type: ${note.fileMime}'),
                      ],
                      if (note.packages.isNotEmpty) ...[
                        SizedBox(height: 14.h),
                        Text(
                          'Available in packages',
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        ...note.packages.map(
                          (package) => Padding(
                            padding: EdgeInsets.only(bottom: 4.h),
                            child: Text('• ${package.title}'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(NoteViewModel noteVm) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 48.r, color: Colors.red),
            SizedBox(height: 12.h),
            Text(
              noteVm.errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red, fontSize: 13.sp),
            ),
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: () => noteVm.fetchNotes(isRefresh: true),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.note_alt_outlined,
            size: 64.r,
            color: Colors.grey.shade300,
          ),
          SizedBox(height: 16.h),
          Text(
            'এই প্যাকেজে কোনো নোট পাওয়া যায়নি',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
