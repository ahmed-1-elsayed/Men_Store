import 'package:flutter/material.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/helper/app_style.dart';

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const ProfileItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppColors.black),

            const SizedBox(width: 15),

            Expanded(
              child: Text(
                title,
                style: AppStyles.label.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
