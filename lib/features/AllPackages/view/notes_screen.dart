import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../library/viewModel/note_view_model.dart';
import '../../library/model/note_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  String? packageId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // আর্গুমেন্ট থেকে packageId গ্রহণ করা
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['packageId'] != null) {
      packageId = args['packageId'];
      // ভিউ-মডেলকে বলা এই প্যাকেজের নোট লোড করতে
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<NoteViewModel>().updateFilters(packageId: packageId);
        context.read<NoteViewModel>().fetchNotes(isRefresh: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final noteVm = context.watch<NoteViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, 'Package Notes'),
          Expanded(
            child: noteVm.isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF072B3E)))
                : noteVm.notes.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        padding: EdgeInsets.all(16.w),
                        itemCount: noteVm.notes.length,
                        separatorBuilder: (context, index) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          final note = noteVm.notes[index];
                          return _buildNoteCard(note);
                        },
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

  Widget _buildNoteCard(Note note) {
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
            decoration: BoxDecoration(
              color: note.isLocked ? Colors.grey.shade100 : const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              note.isLocked ? Icons.lock_outline : Icons.description_outlined,
              color: note.isLocked ? Colors.grey : const Color(0xFF2E7D32),
              size: 24.r,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: note.isLocked ? Colors.grey : const Color(0xFF072B3E),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Subject: ${note.subject}',
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          if (!note.isLocked)
            const Icon(Icons.download_for_offline_outlined, color: Color(0xFF072B3E))
          else
            Icon(Icons.lock, color: Colors.amber.shade700, size: 18.sp),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_alt_outlined, size: 64.r, color: Colors.grey.shade300),
          SizedBox(height: 16.h),
          Text(
            'এই প্যাকেজে কোনো নোট পাওয়া যায়নি',
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
