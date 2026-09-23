import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/routes/routesName.dart';
import '../viewModel/signupViewModel.dart';

class SignUpStepTwoScreen extends StatefulWidget {
  const SignUpStepTwoScreen({super.key});

  @override
  State<SignUpStepTwoScreen> createState() => _SignUpStepTwoScreenState();
}

class _SignUpStepTwoScreenState extends State<SignUpStepTwoScreen> {
  final TextEditingController _universityController = TextEditingController();
  String? _selectedProfession;
  String? _selectedGender;

  final List<String> _professions = ['Student', 'Professional', 'Other'];
  final List<String> _genders = ['Male', 'Female', 'Other'];

  @override
  void dispose() {
    _universityController.dispose();
    super.dispose();
  }

  void _handleRegister() async {
    final university = _universityController.text.trim();

    if (university.isEmpty || _selectedProfession == null || _selectedGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    final signupViewModel = context.read<SignupViewModel>();
    final success = await signupViewModel.register(
      university: university,
      profession: _selectedProfession!,
      gender: _selectedGender!,
    );

    if (success) {
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          RouteName.readyToGoScreen,
          (route) => false,
        );
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(signupViewModel.errorMessage ?? 'Registration failed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupViewModel = context.watch<SignupViewModel>();

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
                    Center(
                      child: Text(
                        'Complete Profile',
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
                        'Almost there! Tell us a bit more about yourself.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          color: Colors.white70,
                          height: 1.3,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    _buildLabel('University'),
                    SizedBox(height: 6.h),
                    _buildTextField(
                      controller: _universityController,
                      hintText: 'Enter your university name',
                    ),
                    SizedBox(height: 14.h),
                    _buildLabel('Profession'),
                    SizedBox(height: 6.h),
                    _buildDropdown(
                      hint: 'Select Profession',
                      items: _professions,
                      value: _selectedProfession,
                      onChanged: (val) => setState(() => _selectedProfession = val),
                    ),
                    SizedBox(height: 14.h),
                    _buildLabel('Gender'),
                    SizedBox(height: 6.h),
                    _buildDropdown(
                      hint: 'Select Gender',
                      items: _genders,
                      value: _selectedGender,
                      onChanged: (val) => setState(() => _selectedGender = val),
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: double.infinity,
                      height: 46.h,
                      child: ElevatedButton(
                        onPressed: signupViewModel.isLoading ? null : _handleRegister,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFC107),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: signupViewModel.isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.h,
                                child: const CircularProgressIndicator(
                                  color: Colors.black,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Complete Registration',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 16.h),
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
                          '2 / 2',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white70,
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(fontSize: 13.sp, color: Colors.black87),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hint,
    required List<String> items,
    required String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[400],
            ),
          ),
          items: items
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black87,
                      ),
                    ),
                  ))
              .toList(),
          value: value,
          onChanged: onChanged,
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
