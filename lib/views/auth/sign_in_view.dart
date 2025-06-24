import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fs_task_assesment/components/custom_button.dart';
import 'package:fs_task_assesment/components/custom_text_field.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/services/auth_service.dart';
import 'package:fs_task_assesment/views/auth/sign_up_view.dart';
import 'package:fs_task_assesment/views/home/home_view.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _isLoading = false;
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 23),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SvgPicture.asset(
                    "assets/images/splash.svg",
                    height: MediaQuery.sizeOf(context).height * 0.5,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Login to start",
                    style: TextStyle(
                      fontSize: 26,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  CustomTextField(
                    hint: "Email Address",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      } else if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value)) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                  ),

                  CustomTextField(
                    controller: _passwordController,
                    hint: "Password",
                    obsecureText: !_showPassword,
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      } else if (value.length < 8) {
                        return "Password must be at least 8 characters";
                      } else if (!RegExp(
                        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$",
                      ).hasMatch(value)) {
                        return "Password must have upper, lower, and number";
                      }
                      return null;
                    },
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _showPassword = !_showPassword;
                        });
                      },
                      icon: _showPassword
                          ? Icon(
                              Icons.visibility,
                              color: AppColors.primaryColor,
                            )
                          : Icon(Icons.visibility_off),
                    ),
                  ),

                  SizedBox(height: 12),

                  _isLoading
                      ? Center(
                          child: SizedBox(
                            height: 50,
                            child: CupertinoActivityIndicator(),
                          ),
                        )
                      : CustomButton(
                          title: "Login",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              final result = await AuthService().signInUser(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );

                              if (result.status != false) {
                                Navigator.push(
                                  AppData.shared.navigatorKey.currentContext ??
                                      context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeView(),
                                  ),
                                );
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });

                                ScaffoldMessenger.of(
                                  AppData.shared.navigatorKey.currentContext ??
                                      context,
                                ).showSnackBar(
                                  SnackBar(content: Text(result.message)),
                                );
                              }
                            }
                          },
                          width: MediaQuery.sizeOf(context).width * 0.9,
                        ),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpView()),
                      );
                    },
                    child: Text(
                      "Create new account",
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
