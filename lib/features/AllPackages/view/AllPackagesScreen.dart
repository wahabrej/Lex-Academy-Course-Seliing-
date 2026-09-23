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

class _AllPackagesScreenState extends State<AllPackagesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<PackageViewModel>();
      vm.fetchPackageCatalog();
      vm.fetchAccessCounts();
      vm.fetchEnrolledPackages();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          _buildHeader(context),
          _buildTabBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _CatalogTabView(),
                _MyAccessTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 20.h),
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
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
                      child: Icon(Icons.arrow_back_ios_new, color: const Color(0xFF072B3E), size: 16.sp),
                    ),
                  ),
                  const Text('Packages Hub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(width: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TabBar(
        controller: _tabController,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: const Color(0xFFF5B301),
          borderRadius: BorderRadius.circular(10.r),
        ),
        labelColor: const Color(0xFF072B3E),
        unselectedLabelColor: Colors.grey,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
        tabs: const [
          Tab(text: 'Catalog'),
          Tab(text: 'My Access'),
        ],
      ),
    );
  }
}

// ─── TAB 1: Catalog View ───────────────────────────────────────────────────
class _CatalogTabView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PackageViewModel>();
    final bjs = viewModel.catalog?.programs['bjs'];

    if (viewModel.isLoading) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          if (bjs != null) ...[
            if (bjs.preliminary.isNotEmpty) ...[
              _buildSectionTitle('Preliminary Batches'),
              ...bjs.preliminary.map((item) => _PackageCard(item: item)),
            ],
            SizedBox(height: 20.h),
            if (bjs.written.isNotEmpty) ...[
              _buildSectionTitle('Written Batches'),
              ...bjs.written.map((item) => _PackageCard(item: item)),
            ],
          ],
          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
      ),
    );
  }
}

// ─── TAB 2: My Access View ─────────────────────────────────────────────────
class _MyAccessTabView extends StatefulWidget {
  @override
  State<_MyAccessTabView> createState() => _MyAccessTabViewState();
}

class _MyAccessTabViewState extends State<_MyAccessTabView> {
  String _activeTab = 'active';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PackageViewModel>().fetchAccessList(_activeTab);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PackageViewModel>();
    final counts = viewModel.accessCounts;

    return Column(
      children: [
        // Sub-tabs for Access Types
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFilterChip('Active', 'active', counts?.active ?? 0),
              _buildFilterChip('Requests', 'requests', counts?.requests ?? 0),
              _buildFilterChip('History', 'history', counts?.history ?? 0),
            ],
          ),
        ),
        
        Expanded(
          child: viewModel.isLoading
              ? const Center(child: CircularProgressIndicator())
              : viewModel.accessList.isEmpty
                  ? Center(child: Text("No data found for $_activeTab"))
                  : ListView.separated(
                      padding: EdgeInsets.all(16.w),
                      itemCount: viewModel.accessList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 12.h),
                      itemBuilder: (context, i) {
                        final item = viewModel.accessList[i];
                        return _AccessTile(item: item);
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, String key, int count) {
    final isSelected = _activeTab == key;
    return GestureDetector(
      onTap: () {
        setState(() => _activeTab = key);
        context.read<PackageViewModel>().fetchAccessList(key);
      },
      child: Column(
        children: [
          Text(label, style: TextStyle(color: isSelected ? const Color(0xFF072B3E) : Colors.grey, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(color: isSelected ? const Color(0xFF072B3E) : Colors.grey.shade200, borderRadius: BorderRadius.circular(10.r)),
            child: Text('$count', style: TextStyle(color: isSelected ? Colors.white : Colors.black, fontSize: 10.sp)),
          )
        ],
      ),
    );
  }
}

// ─── UI COMPONENTS ──────────────────────────────────────────────────────────

class _PackageCard extends StatelessWidget {
  final PackageItem item;
  const _PackageCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF072B3E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6.r)),
                child: Text(item.track.toUpperCase(), style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
              ),
              const Icon(Icons.star, color: Color(0xFFF5B301), size: 16),
            ],
          ),
          SizedBox(height: 12.h),
          Text(item.title, style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.h),
          Text("৳ ${item.discountPrice ?? item.price}", style: TextStyle(color: const Color(0xFFF5B301), fontSize: 18.sp, fontWeight: FontWeight.bold)),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, RouteName.packageDetailScreen, arguments: item.id),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF5B301),
              minimumSize: Size(double.infinity, 40.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: const Text('Details', style: TextStyle(color: Color(0xFF072B3E), fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

class _AccessTile extends StatelessWidget {
  final PackageAccessItem item;
  const _AccessTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12.r), border: Border.all(color: Colors.grey.shade200)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.package?.title ?? "Unknown Package", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                SizedBox(height: 4.h),
                Text("Requested: ${item.createdAt?.day}/${item.createdAt?.month}/${item.createdAt?.year}", style: TextStyle(color: Colors.grey, fontSize: 11.sp)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: _getStatusColor(item.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(item.status.toUpperCase(), style: TextStyle(color: _getStatusColor(item.status), fontSize: 10.sp, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active': return Colors.green;
      case 'pending': return Colors.orange;
      case 'rejected': return Colors.red;
      default: return Colors.grey;
    }
  }
}

class _SearchFieldPlaceholder extends StatelessWidget {
  final String hint;
  final bool light;
  const _SearchFieldPlaceholder({required this.hint, required this.light});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12.r)),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          const Icon(Icons.search, color: Colors.white54),
          SizedBox(width: 10.w),
          Text(hint, style: const TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }
}
