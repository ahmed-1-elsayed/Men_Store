import 'package:flutter/material.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/helper/app_style.dart';
import '../../../location/view.dart';
import '../../../sign_in/view.dart';
import '../../../widgets/profile_item.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Account",
          style: AppStyles.label.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Divider(),

            ProfileItem(
              icon: Icons.inventory_2_outlined,
              title: "My Orders",
              onTap: () {},
            ),

            const Divider(),

            ProfileItem(
              icon: Icons.person_outline,
              title: "My Details",
              onTap: () {},
            ),

            const Divider(),

            ProfileItem(
              icon: Icons.home_outlined,
              title: "Address Book",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LocationScreen()),
                );
              },
            ),

            const Divider(),

            ProfileItem(icon: Icons.help_outline, title: "FAQs", onTap: () {}),

            const Divider(),

            ProfileItem(
              icon: Icons.headset_mic_outlined,
              title: "Help Center",
              onTap: () {},
            ),

            const Spacer(),

            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: AppColors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.99,
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircleAvatar(
                              radius: 35,
                              backgroundColor: AppColors.white,
                              child: Icon(
                                Icons.error_outline_outlined,
                                color: Colors.red,
                                size: 40,
                              ),
                            ),

                            const SizedBox(height: 20),

                            const Text(
                              "Logout?",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            const Text(
                              "Are you sure you want to logout?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff808080),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            const SizedBox(height: 25),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginView(),
                                    ),
                                    (route) => false,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "Yes, Logout",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            SizedBox(
                              width: double.infinity,
                              height: 52,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  "No, Cancel",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Colors.red),
                  const SizedBox(width: 10),
                  Text(
                    "Logout",
                    style: AppStyles.label.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
