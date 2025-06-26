import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fs_task_assesment/components/custom_button.dart';
import 'package:fs_task_assesment/components/custom_text_field.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/models/user.dart';
import 'package:fs_task_assesment/services/auth_service.dart';
import 'package:fs_task_assesment/services/user_service.dart';
import 'package:fs_task_assesment/views/auth/sign_in_view.dart';
import 'package:fs_task_assesment/views/menu/nav_menu.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _showPassword = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  // Focus nodes
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();

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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.3,
                    child: SvgPicture.asset("assets/images/splash.svg"),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Register to start",
                    style: TextStyle(
                      fontSize: 26,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),

                  CustomTextField(
                    hint: "Name",
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    onFiledSubmissionValue: (newValue) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    onValidator: (value) {
                      if (value!.isEmpty) {
                        return "Name is required";
                      }
                      return null;
                    },
                  ),

                  CustomTextField(
                    hint: "Email Address",
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    onFiledSubmissionValue: (newValue) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
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
                    hint: "New Password",
                    obsecureText: !_showPassword,
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    onFiledSubmissionValue: (newValue) {
                      FocusScope.of(
                        context,
                      ).requestFocus(_confirmPasswordFocusNode);
                    },
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

                  CustomTextField(
                    hint: "Confirm Password",
                    obsecureText: !_showPassword,
                    controller: _confirmPasswordController,
                    focusNode: _confirmPasswordFocusNode,
                    onFiledSubmissionValue: (newValue) {
                      FocusScope.of(context).unfocus();
                    },
                    onValidator: (value) {
                      if (value != _passwordController.text) {
                        return "Password doesn't match";
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
                          title: "Register",
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                _isLoading = true;
                              });

                              UserService userService = UserService();

                              UserModel userModel = UserModel(
                                uid: "",
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );

                              final result = await AuthService().signUpUser(
                                userModel: userModel,
                                userService: userService,
                              );

                              if (result.status != false) {
                                Navigator.push(
                                  AppData.shared.navigatorKey.currentContext ??
                                      context,
                                  MaterialPageRoute(
                                    builder: (context) => NavigationMenu(),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignInView()),
                      );
                    },
                    child: Text(
                      "Login instead",
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
