import 'package:flutter/material.dart';
import 'package:fs_task_assesment/helpers/colors.dart';
import 'package:fs_task_assesment/views/cart/cart_view.dart';
import 'package:fs_task_assesment/views/home/home_view.dart';
import 'package:fs_task_assesment/views/profile/profile_view.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int _currentIndex = 0;

  List<Widget> screens = [
    const HomeView(),
    const CartView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Floating and more beautiful bottom navigation bar
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: PhysicalModel(
          color: Colors.transparent,
          elevation: 16,
          borderRadius: BorderRadius.circular(32),
          shadowColor: AppColors.primaryColor.withOpacity(0.3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                selectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                selectedIconTheme: const IconThemeData(
                  color: AppColors.primaryColor,
                  size: 30,
                ),
                unselectedIconTheme: const IconThemeData(
                  color: Colors.grey, // Unselected icon color
                  size: 26,
                ),
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_rounded),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined),
                    label: 'Cart',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle_rounded),
                    label: 'Profile',
                  ),
                ],
                showUnselectedLabels: false,
                showSelectedLabels: true,
              ),
            ),
          ),
        ),
      ),
      body: screens.elementAt(_currentIndex),
    );
  }
}
