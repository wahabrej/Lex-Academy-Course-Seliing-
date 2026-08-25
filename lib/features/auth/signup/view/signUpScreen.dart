import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/routesName.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedCountryCode = '+880';
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/login_logo.png',
                    width: 180.w,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.balance_rounded,
                          color: const Color(0xFFFFC107),
                          size: 32.r,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Lex Academy',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F2C43),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B253A),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title & Subtitle
                    Center(
                      child: Text(
                        'Create an account',
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Center(
                      child: Text(
                        'Create your account and start mastering\nnew skills today.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          color: Colors.white70,
                          height: 1.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Full Name Field
                    _buildLabel('Full Name'),
                    SizedBox(height: 6.h),
                    _buildTextField(
                      controller: _fullNameController,
                      hintText: 'Enter your full name',
                    ),
                    SizedBox(height: 14.h),

                    // Email Field
                    _buildLabel('Email'),
                    SizedBox(height: 6.h),
                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Enter your email address',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 14.h),

                    // Password Field
                    _buildLabel('Password'),
                    SizedBox(height: 6.h),
                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Enter your password',
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.grey[600],
                          size: 18.r,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // =========================================================
                    // 3. Phone Number Field with Country Code Picker (Dropdown)
                    // =========================================================
                    _buildLabel('Phone Number'),
                    SizedBox(height: 6.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        children: [
                          // --- Country Code Picker Widget ---
                          CountryCodePicker(
                            onChanged: (CountryCode countryCode) {
                              setState(() {
                                _selectedCountryCode = countryCode.dialCode!;
                                // এখানে আপনি চাইলে selected country code ও manipulate করতে পারেন
                                // print("New Country selected: ${countryCode.dialCode}");
                              });
                            },
                            // প্রাথমিক সিলেকশন (Bangladesh)
                            initialSelection: 'BD',
                            // ফেভারিট লিস্টে বাংলাদেশ ও ভারত রাখা (চাইলে পরিবর্তন করতে পারেন)
                            favorite: const ['+880', 'BD', '+91', 'IN'],
                            // শুধুমাত্র ডায়াল কোড দেখাবে যখন ক্লোজ থাকবে
                            showOnlyCountryWhenClosed: false,
                            // ফ্ল্যাগ এবং টেক্সট লেফটে অ্যালাইন করা
                            alignLeft: false,
                            padding: EdgeInsets.zero,
                            // ডায়াল কোড এবং ফ্ল্যাগ এর স্টাইল
                            textStyle: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                            // সার্চ ডায়ালগের কাস্টমাইজেশন
                            searchDecoration: InputDecoration(
                              hintText: 'Search country...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            // ফ্ল্যাগ এর প্রস্থ
                            flagWidth: 24.w,
                          ),

                          // ভাটিক্যাল ডিভাইডার (ঐচ্ছিক, স্ক্রিনশটের সাথে মিলিয়ে)
                          Container(
                            height: 24.h,
                            width: 1.w,
                            color: Colors.grey[300],
                          ),
                          SizedBox(width: 8.w),

                          // --- Phone Number Input Field ---
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Enter phone number',
                                hintStyle: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[400],
                                ),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 14.h,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),

                    // Remember Me & Forgot Password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 18.r,
                              height: 18.r,
                              child: Checkbox(
                                value: _rememberMe,
                                activeColor: const Color(0xFFFFC107),
                                checkColor: Colors.black,
                                side: BorderSide(
                                  color: Colors.white70,
                                  width: 1.5.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Remember me',
                              style: TextStyle(
                                fontSize: 11.5.sp,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              color: const Color(0xFFFFC107),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: ElevatedButton(
                        onPressed: () {
                Navigator.pushNamed(context, RouteName.readyToGoScreen);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Step Indicator (1/2)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 24.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFC107),
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '1 / 2',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Or Sign in with
                    Center(
                      child: Text(
                        'Or Sign in with',
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: Colors.white60,
                        ),
                      ),
                    ),
                    SizedBox(height: 14.h),

                    // Social Buttons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(
                          iconPath: "assets/icons/fb.png",
                          fallbackIcon: Icons.facebook,
                          iconColor: const Color(0xFF1877F2),
                          onTap: () {},
                        ),
                        SizedBox(width: 16.w),
                        _buildSocialButton(
                          iconPath: "assets/icons/google.png",
                          fallbackIcon: Icons.g_mobiledata_rounded,
                          iconColor: Colors.redAccent,
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Sign In / Sign Up Nav
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: TextStyle(
                            fontSize: 11.5.sp,
                            color: Colors.white70,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteName.loginScreen,
                            );
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFFC107),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  // Label Helper
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  }

  // Input Field Helper
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(fontSize: 13.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }

  // Social Button Helper Component
  Widget _buildSocialButton({
    required String iconPath,
    required IconData fallbackIcon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22.r),
      child: Container(
        width: 44.r,
        height: 44.r,
        padding: EdgeInsets.all(9.r),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          iconPath,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) =>
              Icon(fallbackIcon, color: iconColor, size: 24.r),
        ),
      ),
    );
  }
}
