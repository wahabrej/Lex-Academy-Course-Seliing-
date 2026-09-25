import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:lexverse/core/routes/routesName.dart';
import '../../AllPackages/viewModel/package_view_model.dart';
import '../../AllPackages/model/package_model.dart';

class AllPackageScreen extends StatefulWidget {
  const AllPackageScreen({super.key});

  @override
  State<AllPackageScreen> createState() => _AllPackageScreenState();
}

class _AllPackageScreenState extends State<AllPackageScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<PackageViewModel>();
      vm.fetchPackageCatalog();
      vm.fetchEnrolledPackages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final packageVm = context.watch<PackageViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF072B3E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Packages Hub',
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFFFFC107),
          labelColor: const Color(0xFFFFC107),
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Catalog'),
            Tab(text: 'My Access'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCatalogTab(packageVm),
          _buildMyAccessTab(packageVm),
        ],
      ),
    );
  }

  Widget _buildCatalogTab(PackageViewModel vm) {
    final catalogPackages = vm.catalog?.getAllPreliminary() ?? [];

    if (vm.isLoading && catalogPackages.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF072B3E)));
    }
    
    return RefreshIndicator(
      onRefresh: () => vm.fetchPackageCatalog(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Available Batches'),
            SizedBox(height: 12.h),
            if (catalogPackages.isEmpty && !vm.isLoading)
              const Center(child: Text('No packages available in catalog.'))
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: catalogPackages.length,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return _buildCatalogPackageCard(context, catalogPackages[index]);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyAccessTab(PackageViewModel vm) {
    if (vm.isLoading && vm.enrolledPackages.isEmpty) {
      return const Center(child: CircularProgressIndicator(color: Color(0xFF072B3E)));
    }
    
    if (vm.enrolledPackages.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 64.r, color: Colors.grey[300]),
            SizedBox(height: 16.h),
            Text('আপনার কোনো কেনা প্যাকেজ নেই', style: TextStyle(color: Colors.grey[600], fontSize: 14.sp)),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => vm.fetchEnrolledPackages(),
      child: ListView.separated(
        padding: EdgeInsets.all(16.r),
        itemCount: vm.enrolledPackages.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          return _buildEnrolledPackageCard(context, vm.enrolledPackages[index]);
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E)));
  }

  Widget _buildCatalogPackageCard(BuildContext context, PackageItem package) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: const Color(0xFF0B253A), borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
                child: Text(package.program.toUpperCase(), style: TextStyle(color: const Color(0xFF0B253A), fontSize: 10.sp, fontWeight: FontWeight.bold)),
              ),
              const Icon(Icons.star, color: Color(0xFFFFC107), size: 16),
            ],
          ),
          SizedBox(height: 12.h),
          Text(package.title, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold, height: 1.3)),
          SizedBox(height: 14.h),
          Text('৳ ${package.discountPrice ?? package.price}', style: TextStyle(color: const Color(0xFFFFC107), fontSize: 18.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          _buildActionButton(
            title: 'বিস্তারিত',
            bgColor: const Color(0xFFFFC107),
            textColor: Colors.black,
            onTap: () {
              Navigator.pushNamed(context, RouteName.packageDetailScreen, arguments: package.id);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEnrolledPackageCard(BuildContext context, EnrolledPackageItem package) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(color: const Color(0xFF072B3E), borderRadius: BorderRadius.circular(16.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(4.r)),
                child: Text('ENROLLED', style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(package.title, style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold, height: 1.4)),
          SizedBox(height: 16.h),
          _buildActionButton(
            title: 'প্যাকেজে প্রবেশ করুন',
            bgColor: const Color(0xFFFFC107),
            textColor: Colors.black,
            onTap: () {
              Navigator.pushNamed(
                context, 
                RouteName.enrolledPackageDashboard,
                arguments: {'packageId': package.id, 'packageName': package.title}
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required String title, required Color bgColor, required Color textColor, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 40.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(backgroundColor: bgColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)), elevation: 0),
        child: Text(title, style: TextStyle(color: textColor, fontSize: 12.sp, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
