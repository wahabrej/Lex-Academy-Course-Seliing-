import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../model/package_content_models.dart';
import '../viewModel/package_content_view_model.dart';

class SuggestionScreen extends StatefulWidget {
  final String packageId;
  final String? packageName;
  final String? programType;
  final String? track;

  const SuggestionScreen({
    super.key,
    required this.packageId,
    this.packageName,
    this.programType,
    this.track,
  });

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackageContentViewModel>().fetchSuggestions(
        widget.packageId,
        programType: widget.programType,
        track: widget.track,
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
          _header(context, widget.packageName ?? 'Suggestions'),
          Expanded(
            child:
                viewModel.isLoadingSuggestions && viewModel.suggestions.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : viewModel.suggestionsError != null &&
                      viewModel.suggestions.isEmpty
                ? _error(viewModel.suggestionsError!, () {
                    viewModel.fetchSuggestions(
                      widget.packageId,
                      programType: widget.programType,
                      track: widget.track,
                    );
                  })
                : viewModel.suggestions.isEmpty
                ? _empty()
                : RefreshIndicator(
                    onRefresh: () => viewModel.fetchSuggestions(
                      widget.packageId,
                      programType: widget.programType,
                      track: widget.track,
                    ),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      itemCount: viewModel.suggestions.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) =>
                          _suggestionCard(viewModel.suggestions[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _suggestionCard(SuggestionItem suggestion) {
    final locked = suggestion.requiresPurchase && !suggestion.isUnlocked;
    final color = locked ? Colors.orange : Colors.deepOrange;
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _showDetails(suggestion),
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
                  locked
                      ? Icons.lock_outline_rounded
                      : Icons.tips_and_updates_rounded,
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
                      suggestion.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF072B3E),
                      ),
                    ),
                    if (suggestion.category?.isNotEmpty == true) ...[
                      SizedBox(height: 5.h),
                      Text(
                        suggestion.category!,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        ...suggestion.tracks.map(
                          (track) => _tag(track, Colors.teal),
                        ),
                        if (suggestion.children.isNotEmpty)
                          _tag(
                            '${suggestion.children.length} topics',
                            Colors.indigo,
                          ),
                        _tag(
                          locked ? 'Locked' : 'Available',
                          locked ? Colors.orange : Colors.green,
                        ),
                      ],
                    ),
                    if (suggestion.children.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      Text(
                        suggestion.children
                            .map((item) => item.title)
                            .join(' • '),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
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

  Future<void> _showDetails(SuggestionItem item) async {
    final viewModel = context.read<PackageContentViewModel>();
    await viewModel.fetchSuggestionDetail(item.id);
    if (!mounted) return;
    final detail = viewModel.selectedSuggestion;
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
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF072B3E),
                ),
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        detail?.content?.isNotEmpty == true
                            ? detail!.content!
                            : item.requiresPurchase && !item.isUnlocked
                            ? 'এই suggestion-এর বিস্তারিত দেখতে package access প্রয়োজন।'
                            : 'No detailed content available.',
                        style: TextStyle(fontSize: 14.sp, height: 1.5),
                      ),
                      if ((detail?.children ?? item.children).isNotEmpty) ...[
                        SizedBox(height: 16.h),
                        Text(
                          'Topics',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        ...(detail?.children ?? item.children).map(
                          (child) => Padding(
                            padding: EdgeInsets.only(bottom: 6.h),
                            child: Text('• ${child.title}'),
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

  Widget _empty() =>
      const Center(child: Text('No suggestions found for this package.'));
}
