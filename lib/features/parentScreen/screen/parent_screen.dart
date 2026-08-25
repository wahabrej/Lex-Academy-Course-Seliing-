import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../home/view/homeScreen.dart';
import '../../library/view/librarScreen.dart';
import '../viewModel/parentScreenProvider.dart';

class ParentScreen extends StatelessWidget {
  const ParentScreen({super.key});

  static const List<Widget> _pages = [
    HomeScreen(),
    LibraryScreen(),
    LiveScreen(),
    PackagesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ParentScreenProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: IndexedStack(index: provider.currentIndex, children: _pages),

          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Container(
            height: 62.r,
            width: 62.r,
            padding: EdgeInsets.all(3.r),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: FloatingActionButton(
              onPressed: () => provider.setIndex(2),
              backgroundColor: const Color(0xFF0F2C43), // ডার্ক নেভি ব্লু কালার
              elevation: 4,
              shape: const CircleBorder(),
              child: Image.asset(
                'assets/icons/live.png',
                width: 28.w,
                height: 28.h,
                errorBuilder: (context, error, stackTrace) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.sensors,
                      color: const Color(0xFFFFC107),
                      size: 18.r,
                    ),
                    Text(
                      'LIVE',
                      style: TextStyle(
                        color: const Color(0xFFFFC107),
                        fontSize: 9.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // কাস্টম Bottom App Bar (Notched Navigation)
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.r,
            color: Colors.white,
            elevation: 10,
            padding: EdgeInsets.zero,
            child: SizedBox(
              height: 65.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // বামপাশের আইটেম (Home & Library)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(
                          context: context,
                          provider: provider,
                          index: 0,
                          iconPath: 'assets/icons/home.png',
                          fallbackIcon: Icons.home_rounded,
                          label: 'Home',
                        ),
                        _buildNavItem(
                          context: context,
                          provider: provider,
                          index: 1,
                          iconPath: 'assets/icons/library.png',
                          fallbackIcon: Icons.menu_book_rounded,
                          label: 'Library',
                        ),
                      ],
                    ),
                  ),

                  // মাঝখানের খালি জায়গা (Floating Button-এর জন্য)
                  SizedBox(width: 65.w),

                  // ডানপাশের আইটেম (Packages & Profile)
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(
                          context: context,
                          provider: provider,
                          index: 3,
                          iconPath: 'assets/icons/package.png',
                          fallbackIcon: Icons.business_center_outlined,
                          label: 'Packages',
                        ),
                        _buildNavItem(
                          context: context,
                          provider: provider,
                          index: 4,
                          iconPath: 'assets/icons/profile.png',
                          fallbackIcon: Icons.person_outline,
                          label: 'Profile',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // কাস্টম নেভিগেশন আইটেম উইজেট
  Widget _buildNavItem({
    required BuildContext context,
    required ParentScreenProvider provider,
    required int index,
    required String iconPath,
    required IconData fallbackIcon,
    required String label,
  }) {
    final bool isSelected = provider.currentIndex == index;
    final Color activeColor = const Color(0xFF0F2C43);
    final Color inactiveColor = const Color(0xFF9E9E9E);

    return InkWell(
      onTap: () => provider.setIndex(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 22.w,
            height: 22.h,
            color: isSelected ? activeColor : inactiveColor,
            errorBuilder: (context, error, stackTrace) => Icon(
              fallbackIcon,
              size: 22.r,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Live Screen"));
  }
}

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Packages Screen"));
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile Screen"));
  }
}
