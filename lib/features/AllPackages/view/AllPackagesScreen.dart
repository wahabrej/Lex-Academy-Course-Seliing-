import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lexverse/core/routes/routesName.dart';

class AllPackagesScreen extends StatelessWidget {
  const AllPackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        children: [
          // ---------------- হেডার (Custom Header with Back Button) ----------------
          _buildHeader(context, 'All Packages'),

          // ---------------- বডি ----------------
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ---------------- প্রিলিমিনারি প্যাকেজ সেকশন ----------------
                  _buildSectionHeader(
                    title: 'প্রিলিমিনারি প্যাকেজ',
                    subtitle: 'MCQ / Preliminary প্রস্তুতি প্যাকেজ',
                    badgeCount: '৩টি',
                  ),
                  SizedBox(height: 12.h),

                  // কার্ড ১
                  _buildPackageCard(
                    context: context,
                    category: 'BJS - Preliminary',
                    title: '১৩তম বিজেএস প্রিলি প্যাকার\nপ্রস্তুতি-ফেব্রুয়ারি',
                    price: '৳ ১০০০',
                    priceSub: '/মাসিক প্যাকেজ',
                    isPremium: true,
                  ),
                  SizedBox(height: 16.h),

                  // কার্ড ২
                  _buildPackageCard(
                    context: context,
                    category: 'BJS - Preliminary',
                    title: '১৩তম বিজেএস প্রিলি প্যাকার\nপ্রস্তুতি-ফেব্রুয়ারি',
                    price: '৳ ১০০০',
                    priceSub: '/মাসিক প্যাকেজ',
                    isPremium: true,
                  ),
                  SizedBox(height: 16.h),

                  // কার্ড ৩
                  _buildPackageCard(
                    context: context,
                    category: 'BJS - Preliminary',
                    title: '১৩তম বিজেএস প্রিলি প্যাকার\nপ্রস্তুতি-ফেব্রুয়ারি',
                    price: '৳ ১০০০',
                    priceSub: '/মাসিক প্যাকেজ',
                    isPremium: true,
                  ),
                  SizedBox(height: 24.h),

                  // ---------------- রিটেন প্যাকেজ সেকশন ----------------
                  _buildSectionHeader(
                    title: 'রিটেন প্যাকেজ',
                    subtitle: 'Written exam প্রস্তুতির প্যাকেজ',
                    badgeCount: '১টি',
                  ),
                  SizedBox(height: 12.h),

                  // কার্ড ৪ (রিটেন)
                  _buildPackageCard(
                    context: context,
                    category: 'BJS - Written',
                    title: '১৩তম বিজেএস প্রিলি প্যাকার\nপ্রস্তুতি-ফেব্রুয়ারি',
                    price: '৳ ২০০০',
                    priceSub: '/মাসিক প্যাকেজ',
                    isPremium: true,
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

  // ---------------- হেডার উইজেট ----------------
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: const Color(0xFF072B3E),
                        size: 16.sp,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                title,
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
  }

  // ---------------- সেকশন হেডার উইজেট ----------------
  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required String badgeCount,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF5B301),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            badgeCount,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF072B3E),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- প্যাকেজ কার্ড উইজেট ----------------
  Widget _buildPackageCard({
    required BuildContext context,
    required String category,
    required String title,
    required String price,
    required String priceSub,
    required bool isPremium,
  }) {
    return Container(
      width: double.infinity,
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
      child: Stack(
        children: [
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                        category,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF072B3E),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: const Color(0xFFF5B301), size: 14.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'Premium',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFFF5B301),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFF5B301),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: Text(
                        priceSub,
                        style: TextStyle(fontSize: 11.sp, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                _buildCardButton(
                  context: context,
                  label: 'বিস্তারিত →',
                  onPressed: () => Navigator.pushNamed(context, RouteName.packageDetailScreen),
                  isOutlined: true,
                ),
                SizedBox(height: 8.h),
                _buildCardButton(
                  context: context,
                  label: 'স্টাডি →',
                  onPressed: () => Navigator.pushNamed(context, RouteName.packageRoutineScreen),
                  isOutlined: true,
                ),
                SizedBox(height: 8.h),
                _buildCardButton(
                  context: context,
                  label: 'প্যাকেজে প্রবেশ করুন →',
                  onPressed: () => Navigator.pushNamed(context, RouteName.packageScreen),
                  isOutlined: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
    required bool isOutlined,
  }) {
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
              child: Text(label, style: TextStyle(fontSize: 13.sp, color: Colors.white)),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF5B301),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
                elevation: 0,
              ),
              child: Text(label, style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: const Color(0xFF072B3E))),
            ),
    );
  }
}
