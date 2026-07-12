import 'package:flutter/material.dart';

import '../../core/helper/app_colors.dart';
import 'Screens/cart/view.dart';
import 'Screens/home/homeScreen.dart';
import 'Screens/profile/view.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(
              color: AppColors.border,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: "Account",
            ),
          ],
        ),
      ),
    );
  }
}