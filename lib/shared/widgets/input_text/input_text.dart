import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import '../../themes/app_text_styles.dart';
import '../../themes/app_colors.dart';

class InputText extends StatelessWidget {
  final String label;
  final IconData icon;
  final String? initialValue;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String value) onChanged;

  const InputText({
    Key? key,
    required this.label,
    required this.icon,
    this.initialValue,
    this.validator,
    this.controller,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            TextFormField(
              onChanged: onChanged,
              controller: controller,
              initialValue: initialValue,
              validator: validator,
              style: TextStyles.input
                  .copyWith(color: AppColors.body, fontSize: 15.0),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                labelText: label,
                labelStyle: TextStyles.input,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 48,
                      color: AppColors.stroke,
                    ),
                  ],
                ),
                border: InputBorder.none,
              ),
            ),
            Divider(
              thickness: 1,
              height: 1,
              color: AppColors.stroke,
            ),
          ],
        ),
      ),
    );
  }
}
