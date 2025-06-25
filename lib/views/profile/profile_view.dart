import 'package:flutter/material.dart';
import 'package:fs_task_assesment/components/image_display_widget.dart';
import 'package:fs_task_assesment/helpers/app_data.dart';
import 'package:fs_task_assesment/helpers/colors.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
  }

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
                  // CircleAvatar(
                  //   radius: MediaQuery.sizeOf(context).width * 0.07,
                  //   backgroundImage: const AssetImage("assets/profile.png"),
                  // ),
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
                  elevation: 8, // Subtle shadow effect
                ),
                onPressed: () {
                  // Handle logout functionality
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
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18, // Adjust font size
              fontWeight: FontWeight.w500, // Slightly bold
              color:
                  Colors.black, // You can adjust the color to match your theme
            ),
          ),
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
