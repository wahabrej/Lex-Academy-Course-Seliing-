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

class _AllPackagesScreenState extends State<AllPackagesScreen>
    with SingleTickerProviderStateMixin {
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
              children: const [
                _CatalogTabView(),
                _MyAccessTabView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────── HEADER ───────────────────────────────
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
          child: Row(
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
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: const Color(0xFF072B3E),
                    size: 16.sp,
                  ),
                ),
              ),
              Text(
                'Packages Hub',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
              const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────── TAB BAR ───────────────────────────────
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

// ─────────────────────────────────────────────────────────────────────────
// TAB 1: Catalog View
// ─────────────────────────────────────────────────────────────────────────
class _CatalogTabView extends StatelessWidget {
  const _CatalogTabView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PackageViewModel>();
    final catalogData = viewModel.catalog;

    if (viewModel.isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF072B3E)),
      );
    }

    return RefreshIndicator(
      onRefresh: () => viewModel.fetchPackageCatalog(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (catalogData != null) ...[
              ...catalogData.programs.entries.map((entry) {
                final programName = entry.key.toUpperCase();
                final program = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (program.preliminary.isNotEmpty) ...[
                      _buildSectionTitle('$programName Preliminary'),
                      ...program.preliminary.map(
                            (item) => _PackageCard(item: item),
                      ),
                    ],
                    if (program.written.isNotEmpty) ...[
                      _buildSectionTitle('$programName Written'),
                      ...program.written.map(
                            (item) => _PackageCard(item: item),
                      ),
                    ],
                    if (program.general.isNotEmpty) ...[
                      _buildSectionTitle('$programName General'),
                      ...program.general.map(
                            (item) => _PackageCard(item: item),
                      ),
                    ],
                  ],
                );
              }),
            ],
            if (catalogData == null && !viewModel.isLoading)
              const Center(child: Text("No packages available in catalog.")),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF072B3E),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// TAB 2: My Access View
// ─────────────────────────────────────────────────────────────────────────
class _MyAccessTabView extends StatefulWidget {
  const _MyAccessTabView();

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
        // ── Count Chips ──
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFilterChip('Active', 'active', counts?.active ?? 0),
              _buildFilterChip('Requests', 'requests', counts?.requests ?? 0),
              _buildFilterChip('History', 'history', counts?.history ?? 0),
            ],
          ),
        ),

        // ── List ──
        Expanded(
          child: viewModel.isLoading
              ? const Center(
            child: CircularProgressIndicator(color: Color(0xFF072B3E)),
          )
              : viewModel.accessList.isEmpty
              ? _buildEmptyState()
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 60.sp, color: Colors.grey.shade400),
          SizedBox(height: 12.h),
          Text(
            "No data found for $_activeTab",
            style: TextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
          ),
        ],
      ),
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
          Text(
            label,
            style: TextStyle(
              color: isSelected ? const Color(0xFF072B3E) : Colors.grey,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF072B3E) : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              '$count',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// UI COMPONENT: Package Card (Catalog Tab)
// ─────────────────────────────────────────────────────────────────────────
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
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF072B3E).withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Top Row: Track Badge + Star ──
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  item.track.toUpperCase(),
                  style: TextStyle(
                    fontSize: 9.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF072B3E),
                  ),
                ),
              ),
              const Icon(Icons.star, color: Color(0xFFF5B301), size: 16),
            ],
          ),
          SizedBox(height: 12.h),

          // ── Title ──
          Text(
            item.title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8.h),

          // ── Price ──
          Text(
            "৳ ${item.discountPrice ?? item.price}",
            style: TextStyle(
              color: const Color(0xFFF5B301),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),

          // ── Details Button ──
          ElevatedButton(
            onPressed: () {
              debugPrint(
                  "🔍 [Catalog] View Details - ID: ${item.id}, Title: ${item.title}");
              Navigator.pushNamed(
                context,
                RouteName.packageDetailScreen,
                arguments: item.id,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF5B301),
              minimumSize: Size(double.infinity, 40.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Details',
              style: TextStyle(
                color: Color(0xFF072B3E),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────
// UI COMPONENT: Access Tile (My Access Tab)
// ─────────────────────────────────────────────────────────────────────────
class _AccessTile extends StatelessWidget {
  final PackageAccessItem item;
  const _AccessTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(item.status ?? 'active');
    final statusText = (item.status ?? 'active').toUpperCase();

    return InkWell(
      onTap: () {
        if (item.status?.toLowerCase() == 'active') {
          Navigator.pushNamed(
            context,
            RouteName.enrolledPackageDashboard,
            arguments: {
              'packageId': item.id,
              'packageName': item.title,
            },
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'আপনার অ্যাক্সেস রিকোয়েস্টটি ${item.status?.toUpperCase() ?? "PENDING"} আছে।',
              ),
            ),
          );
        }
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Row: Track Badge + Status Badge ──
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Track Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFF072B3E).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    item.track.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF072B3E),
                    ),
                  ),
                ),

                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: statusColor.withOpacity(0.4)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        statusText,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // ── Title ──
            Text(
              item.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                color: const Color(0xFF072B3E),
                height: 1.4,
              ),
            ),

            SizedBox(height: 10.h),

            // ── Divider ──
            Divider(height: 1, color: Colors.grey.shade200),
            SizedBox(height: 10.h),

            // ── Bottom Info Row ──
            Row(
              children: [
                // Requested Date
                if (item.createdAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.calendar_today_outlined,
                      label: 'Requested',
                      value: _formatDate(item.createdAt),
                    ),
                  ),

                // Batch Started
                if (item.batchStartedAt != null)
                  Expanded(
                    child: _buildInfoItem(
                      icon: Icons.play_circle_outline,
                      label: 'Started',
                      value: _formatDate(item.batchStartedAt),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Info Item Widget ──
  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: Colors.grey.shade500),
        SizedBox(width: 6.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 9.sp,
                color: Colors.grey.shade500,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 11.sp,
                color: const Color(0xFF072B3E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ── Date Formatter ──
  String _formatDate(DateTime? date) {
    if (date == null) return "N/A";
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  // ── Status Color ──
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return const Color(0xFF2E7D32); // Green
      case 'pending':
        return const Color(0xFFF5B301); // Yellow
      case 'rejected':
        return const Color(0xFFE53935); // Red
      case 'history':
        return Colors.grey.shade600;
      default:
        return const Color(0xFF2E7D32);
    }
  }
}