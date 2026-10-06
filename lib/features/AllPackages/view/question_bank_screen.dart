import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../library/model/question_bank_model.dart';
import '../../library/viewModel/question_bank_view_model.dart';

class QuestionBankScreen extends StatefulWidget {
  final String packageId;

  const QuestionBankScreen({super.key, required this.packageId});

  @override
  State<QuestionBankScreen> createState() => _QuestionBankScreenState();
}

class _QuestionBankScreenState extends State<QuestionBankScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<QuestionBankViewModel>();
      viewModel.updateFilters(packageId: widget.packageId);
      viewModel.fetchQuestionBanks(isRefresh: true);
      viewModel.fetchFilterData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<QuestionBankViewModel>();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: viewModel.isLoading && viewModel.items.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : viewModel.errorMessage != null && viewModel.items.isEmpty
                ? _buildError(viewModel)
                : viewModel.items.isEmpty
                ? _buildEmpty()
                : RefreshIndicator(
                    onRefresh: () =>
                        viewModel.fetchQuestionBanks(isRefresh: true),
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.all(16.w),
                      itemCount: viewModel.items.length,
                      separatorBuilder: (_, _) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) =>
                          _buildBankCard(viewModel.items[index]),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) => Container(
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
            Text(
              'Question Banks',
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

  Widget _buildBankCard(QuestionBank bank) {
    final color = bank.isUnlocked ? Colors.green : Colors.deepPurple;
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: () => _showDetails(bank),
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
                child: Icon(Icons.quiz_rounded, color: color, size: 24.r),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bank.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF072B3E),
                      ),
                    ),
                    SizedBox(height: 7.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 6.h,
                      children: [
                        if (bank.programType.isNotEmpty)
                          _tag(bank.programType, Colors.indigo),
                        if (bank.examType.isNotEmpty)
                          _tag(bank.examType, Colors.teal),
                        if (bank.subject.isNotEmpty)
                          _tag(bank.subject, Colors.blueGrey),
                        if (bank.year > 0) _tag('${bank.year}', Colors.orange),
                      ],
                    ),
                    if (bank.description.isNotEmpty) ...[
                      SizedBox(height: 8.h),
                      Text(
                        bank.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11.sp,
                          height: 1.35,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                    if (bank.tags.isNotEmpty) ...[
                      SizedBox(height: 7.h),
                      Text(
                        bank.tags.join(' • '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 10.sp, color: Colors.grey),
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        _tag(bank.isUnlocked ? 'Available' : bank.tier, color),
                        const Spacer(),
                        Text(
                          bank.price == '0'
                              ? 'Free'
                              : '৳${bank.discountPrice != '0' ? bank.discountPrice : bank.price}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            color: const Color(0xFF072B3E),
                          ),
                        ),
                      ],
                    ),
                  ],
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

  void _showDetails(QuestionBank bank) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) => SafeArea(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.8,
          ),
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  bank.title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF072B3E),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  bank.description.isEmpty
                      ? 'No description.'
                      : bank.description,
                ),
                SizedBox(height: 12.h),
                Text('Subject: ${bank.subject.isEmpty ? 'N/A' : bank.subject}'),
                Text(
                  'Type: ${bank.contentType.isEmpty ? 'N/A' : bank.contentType}',
                ),
                Text('Downloads allowed: ${bank.allowDownload ? 'Yes' : 'No'}'),
                Text('Download count: ${bank.downloadCount}'),
                if (bank.tags.isNotEmpty) Text('Tags: ${bank.tags.join(', ')}'),
                if (bank.associatedPackages.isNotEmpty) ...[
                  SizedBox(height: 12.h),
                  const Text(
                    'Packages',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  ...bank.associatedPackages.map(
                    (package) => Text('• ${package.title}'),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildError(QuestionBankViewModel viewModel) => Center(
    child: Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(viewModel.errorMessage!, textAlign: TextAlign.center),
          SizedBox(height: 12.h),
          ElevatedButton(
            onPressed: () => viewModel.fetchQuestionBanks(isRefresh: true),
            child: const Text('Retry'),
          ),
        ],
      ),
    ),
  );

  Widget _buildEmpty() => Center(
    child: Text(
      'এই প্যাকেজে কোনো question bank পাওয়া যায়নি',
      style: TextStyle(fontSize: 14.sp, color: Colors.grey[700]),
    ),
  );
}
