// ويدجت صغيرة عشان متكرريش الكود لكل سطر (اسم/إيميل)
import 'package:flutter/material.dart';
import 'package:simple_face/constants.dart';

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final void Function()? onTap;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: kPrimaryColorA),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
