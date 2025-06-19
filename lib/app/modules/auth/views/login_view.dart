import 'package:firebase_demo_app/app/core/utils/app_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../commons/ui_widgets/ui_loader_view.dart';
import '../../../commons/ui_widgets/ui_primary_btn.dart';
import '../../../commons/ui_widgets/ui_text.dart';
import '../../../commons/ui_widgets/ui_text_field.dart';
import '../../../core/utils/app_textstyles.dart';
import '../controllers/auth_controller.dart';
import 'signup_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Get the AuthController instance (it's already in memory from main.dart)
  final AuthController authController = Get.find<AuthController>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Login'),
      //   automaticallyImplyLeading: false, // Hide back button on login screen
      // ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.heightBox,
              Icon(
                Icons.lock,
                size: 150,
                // color: AppColors.blue,
              ),
              20.heightBox,
              UIText('Login', style: AppTextStyles.heading1),
              20.heightBox,
              UITextField(
                _emailController,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.sp),
                  child: Icon(Icons.email_outlined, size: 20.sp),
                ),
                labelText: 'Email',
                hintText: 'Enter your email',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    // Use GetX's utility for email validation
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              20.heightBox,
              UITextField(
                _passwordController,
                hidePassword: true,
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 12.sp),
                  child: Icon(Icons.lock_outline, size: 20.sp),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              30.heightBox,
              // Obx listens to authController.isLoading.value
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  child: UIPrimaryButton(
                    onPressed:
                        authController.isLoading
                            ? () {}
                            : () {
                              if (_emailController.text.isEmpty ||
                                  !GetUtils.isEmail(_emailController.text)) {
                                Get.snackbar(
                                  'Error',
                                  'Please enter a valid email address',
                                );
                                return;
                              }

                              if (_passwordController.text.length < 6) {
                                Get.snackbar(
                                  'Error',
                                  'Password must be at least 6 characters long',
                                );
                                return;
                              }
                              authController.login(
                                _emailController.text.trim(),
                                _passwordController.text.trim(),
                              );
                            },
                    label: 'Login',
                    child: authController.isLoading ? UILoaderView() : null,
                  ),
                ),
              ),
              20.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      // Use GetX's routing
                      Get.to(() => const SIgnUpView());
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
              30.heightBox,

              // Google Sign In Button
            ],
          ),
        ),
      ),
    );
  }
}
