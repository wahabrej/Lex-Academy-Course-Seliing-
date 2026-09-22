import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/routesName.dart';
import '../viewModel/package_view_model.dart';
import '../model/package_model.dart';

class AllPackagesScreen extends StatefulWidget {
  const AllPackagesScreen({super.key});

  @override
  State<AllPackagesScreen> createState() => _AllPackagesScreenState();
}

class _AllPackagesScreenState extends State<AllPackagesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackageViewModel>().fetchPackageCatalog();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PackageViewModel>();
    final bjs = viewModel.catalog?.programs['bjs'];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context, 'All Packages'),
          Expanded(
            child: viewModel.isLoading
                ? const Center(child: CircularProgressIndicator(color: Color(0xFF072B3E)))
                : viewModel.errorMessage != null
                    ? Center(child: Text(viewModel.errorMessage!))
                    : SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ---------------- প্রিলিমিনারি প্যাকেজ সেকশন ----------------
                            if (bjs != null && bjs.preliminary.isNotEmpty) ...[
                              _buildSectionHeader(
                                title: 'প্রিলিমিনারি প্যাকেজ',
                                subtitle: 'MCQ / Preliminary প্রস্তুতি প্যাকেজ',
                                badgeCount: '${bjs.preliminary.length}টি',
                              ),
                              SizedBox(height: 12.h),
                              ...bjs.preliminary.map((item) => Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: _buildPackageCard(context, item),
                                  )),
                            ],

                            SizedBox(height: 24.h),

                            // ---------------- রিটেন প্যাকেজ সেকশন ----------------
                            if (bjs != null && bjs.written.isNotEmpty) ...[
                              _buildSectionHeader(
                                title: 'রিটেন প্যাকেজ',
                                subtitle: 'Written exam প্রস্তুতির প্যাকেজ',
                                badgeCount: '${bjs.written.length}টি',
                              ),
                              SizedBox(height: 12.h),
                              ...bjs.written.map((item) => Padding(
                                    padding: EdgeInsets.only(bottom: 16.h),
                                    child: _buildPackageCard(context, item),
                                  )),
                            ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  GestureDetector(
                    onTap: () => context.read<PackageViewModel>().fetchPackageCatalog(),
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                      child: Icon(Icons.refresh, color: Colors.white, size: 20.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader({required String title, required String subtitle, required String badgeCount}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700, color: const Color(0xFF1A1A1A))),
            SizedBox(height: 4.h),
            Text(subtitle, style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(color: const Color(0xFFF5B301), borderRadius: BorderRadius.circular(12.r)),
          child: Text(badgeCount, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
        ),
      ],
    );
  }

  Widget _buildPackageCard(BuildContext context, PackageItem item) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF072B3E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
                  child: Text("${item.program.toUpperCase()} - ${item.track.toUpperCase()}",
                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: const Color(0xFFF5B301), size: 14.sp),
                    SizedBox(width: 4.w),
                    Text('Premium', style: TextStyle(fontSize: 10.sp, color: const Color(0xFFF5B301), fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(item.title, style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: Colors.white, height: 1.4)),
            SizedBox(height: 12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("৳ ${item.discountPrice ?? item.price}",
                    style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: const Color(0xFFF5B301))),
                SizedBox(width: 4.w),
                if (item.discountPrice != null && item.discountPrice != item.price)
                  Text("৳ ${item.price}",
                      style: TextStyle(fontSize: 14.sp, color: Colors.white60, decoration: TextDecoration.lineThrough)),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.h, left: 4.w),
                  child: Text("/${item.duration ?? 'প্যাকেজ'}", style: TextStyle(fontSize: 11.sp, color: Colors.white70)),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            _buildCardButton(
              context: context,
              label: 'বিস্তারিত →',
              onPressed: () => Navigator.pushNamed(context, RouteName.packageDetailScreen, arguments: item.id),
              isOutlined: true,
            ),
            SizedBox(height: 8.h),
            _buildCardButton(
              context: context,
              label: 'প্যাকেজে প্রবেশ করুন →',
              onPressed: () => Navigator.pushNamed(context, RouteName.packageScreen, arguments: item.id),
              isOutlined: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardButton({required BuildContext context, required String label, required VoidCallback onPressed, required bool isOutlined}) {
    return SizedBox(
      width: double.infinity,
      height: 42.h,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white70),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
              ),
              child: Text(label, style: const TextStyle(color: Colors.white)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5B301),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                elevation: 0,
              ),
              child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF072B3E))),
            ),
    );
  }
}
