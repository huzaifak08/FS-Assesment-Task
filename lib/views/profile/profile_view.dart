import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fs_task_assesment/components/image_display_widget.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/helpers/app_provider_container.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/providers/theme_provider.dart';
import 'package:fs_task_assesment/services/auth_service.dart';
import 'package:fs_task_assesment/views/cart/cart_view_model.dart';
import 'package:fs_task_assesment/views/splash/splash_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.backgroundColor,  // Use a background color or gradient
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.sizeOf(context).height * 0.02,
            horizontal: MediaQuery.sizeOf(context).width * 0.05,
          ),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "PROFILE",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
              // Profile Avatar with Smooth Shadow
              Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  width: MediaQuery.sizeOf(context).height * 0.16,
                  height: MediaQuery.sizeOf(context).height * 0.16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 5,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      MediaQuery.sizeOf(context).height * 0.1,
                    ),
                    child: ImageDisplayWidget(
                      mediaId: 'profile_1',
                      imageUrl:
                          "https://t4.ftcdn.net/jpg/04/31/64/75/360_F_431647519_usrbQ8Z983hTYe8zgA7t1XVc5fEtqcpa.jpg",
                      imageFor: "profile",
                      showProgress: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),

              // Profile Details with Icons and Padding
              _buildProfileTile(
                Icons.person,
                'Full Name',
                AppData.shared.user?.name ?? "",
              ),
              _buildProfileTile(
                Icons.email,
                'Email Address',
                AppData.shared.user?.email ?? "",
              ),
              _buildProfileTile(
                Icons.phone,
                'Password',
                AppData.shared.user?.password ?? "",
              ),

              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

              // Dark Mode Toggle Switch
              Consumer(
                builder: (context, ref, child) {
                  final currentTheme = ref.watch(themeProvider);

                  return ListTile(
                    leading: const Icon(
                      Icons.brightness_6,
                      color: AppColors.primaryColor,
                    ),
                    title: Text(
                      "Dark Mode",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: Switch(
                      activeColor: AppColors.primaryColor,
                      value: currentTheme == ThemeMode.dark,
                      onChanged: (bool value) {
                        ref.read(themeProvider.notifier).state = value
                            ? ThemeMode.dark
                            : ThemeMode.light;
                      },
                    ),
                  );
                },
              ),

              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),

              // Elevated and Styled Logout Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: MediaQuery.sizeOf(context).width * 0.3,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 8,
                ),
                onPressed: () async {
                  final result = await AuthService().signOutUser();

                  AppProviderContainer.instance
                      .read(cartProvider.notifier)
                      .removeAllItemsFromCart();

                  if (result) {
                    Navigator.pushReplacement(
                      AppData.shared.navigatorKey.currentContext ?? context,
                      MaterialPageRoute(builder: (context) => SplashView()),
                    );
                  }
                },
                child: Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 20, // Set your preferred font size
                    fontWeight: FontWeight.bold, // Bold weight for emphasis
                    color: Colors.white, // White text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Profile Tile with Icon and Info
  Widget _buildProfileTile(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 5,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListTile(
          leading: Icon(icon, color: AppColors.primaryColor, size: 28),
          title: Text(title),
          subtitle: Text(
            value,
            style: TextStyle(
              fontSize: 14, // Slightly smaller font size
              fontWeight: FontWeight.w400, // Regular weight
              color: AppColors.secondaryTextColor, // Custom color for subtitle
            ),
          ),
        ),
      ),
    );
  }
}
