import 'package:flutter/material.dart';
import 'package:payflow_nlw/shared/themes/app_colors.dart';

class ScreenIcon extends StatelessWidget {
  final IconData icon;
  const ScreenIcon({Key? key, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Icon(
        icon,
        color: AppColors.background,
      ),
    );
  }
}
