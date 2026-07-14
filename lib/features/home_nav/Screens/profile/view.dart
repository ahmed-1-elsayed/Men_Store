import 'package:easy_localization/easy_localization.dart';
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
          "account".tr(),
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
              title: "myOrders".tr(),
              onTap: () {},
            ),

            const Divider(),

            ProfileItem(
              icon: Icons.person_outline,
              title: "myDetails".tr(),
              onTap: () {},
            ),

            const Divider(),

            ProfileItem(
              icon: Icons.home_outlined,
              title: "addressBook".tr(),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LocationScreen()),
                );
              },
            ),

            const Divider(),

            ProfileItem(
              icon: Icons.help_outline,
              title: "faqs".tr(),
              onTap: () {},
            ),
            const Divider(),

            ProfileItem(
              icon: Icons.language,
              title: "changeLanguage".tr(),
              onTap: () async {
                final nextLocale = context.locale.languageCode == "en"
                    ? const Locale("ar")
                    : const Locale("en");
                await context.setLocale(nextLocale);
              },
            ),

            const Divider(),

            ProfileItem(
              icon: Icons.headset_mic_outlined,
              title: "helpCenter".tr(),
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

                            Text(
                              "logoutQuestion".tr(),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              "logoutConfirm".tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
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
                                child: Text(
                                  "yesLogout".tr(),
                                  style: const TextStyle(
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
                                child: Text(
                                  "noCancel".tr(),
                                  style: const TextStyle(
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
                    "logout".tr(),
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
