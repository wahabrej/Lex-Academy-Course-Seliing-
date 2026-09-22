import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../viewModel/package_view_model.dart';
import '../model/package_model.dart';

class PackageDetailScreen extends StatefulWidget {
  const PackageDetailScreen({super.key});

  @override
  State<PackageDetailScreen> createState() => _PackageDetailScreenState();
}

class _PackageDetailScreenState extends State<PackageDetailScreen> {
  PackageItem? _package;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final packageId = ModalRoute.of(context)?.settings.arguments as String?;
    if (packageId != null) {
      _loadDetails(packageId);
    }
  }

  Future<void> _loadDetails(String id) async {
    final data = await context.read<PackageViewModel>().fetchPackageDetails(id);
    if (mounted) {
      setState(() {
        _package = data;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: _isLoading 
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF072B3E)))
          : _package == null 
              ? const Center(child: Text("Package details not found"))
              : Column(
        children: [
          _buildHeader(context, 'বিস্তারিত বিবরণ'),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _package!.title,
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5B301),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Text(
                          '৳ ${_package!.discountPrice ?? _package!.price}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF072B3E),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      if (_package!.duration != null)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Text(
                          'ডিউরেশন: ${_package!.duration}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  _buildSectionTitle('Course Overview'),
                  SizedBox(height: 8.h),
                  Text(
                    _package!.subtitle ?? "No overview available",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  if (_package!.detailsHtml != null) ...[
                    _buildSectionTitle('প্যাকেজের বিবরণ:'),
                    SizedBox(height: 10.h),
                    // Using simple text as placeholder for HTML content
                    Text(
                      _package!.detailsHtml!.replaceAll(RegExp(r'<[^>]*>'), ''),
                      style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade800, height: 1.6),
                    ),
                    SizedBox(height: 20.h),
                  ],

                  _buildSectionTitle('প্যাকেজ মূল্য:'),
                  SizedBox(height: 10.h),
                  _buildBulletPoint('রেগুলার প্রাইস: ৳ ${_package!.price}'),
                  _buildBulletPoint('বর্তমান অফার: ৳ ${_package!.discountPrice ?? _package!.price}'),
                  
                  SizedBox(height: 32.h),

                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {
                         // Payment logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFF5B301),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                        elevation: 0,
                      ),
                      child: Text(
                        'প্যাকেজ কিনুন',
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E)),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              SizedBox(height: 20.h),
              Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1A1A1A)));
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 8.w),
            child: Container(width: 5.w, height: 5.w, decoration: const BoxDecoration(color: Color(0xFF1A1A1A), shape: BoxShape.circle)),
          ),
          Expanded(child: Text(text, style: TextStyle(fontSize: 13.sp, color: const Color(0xFF1A1A1A), height: 1.5))),
        ],
      ),
    );
  }
}
