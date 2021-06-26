import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';

class ConfirmationButton extends StatelessWidget {
  final Color color;
  final String label;
  final void Function() onTap;
  final Color labelColor;
  const ConfirmationButton(
      {Key? key,
      required this.color,
      required this.label,
      required this.onTap,
      required this.labelColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.41,
        height: 55,
        decoration: BoxDecoration(
          border: Border.fromBorderSide(
            BorderSide(color: AppColors.stroke),
          ),
          borderRadius: BorderRadius.circular(5),
          color: color,
        ),
        child: Center(
            child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyles.buttonGray.copyWith(color: labelColor),
        )),
      ),
    );
  }
}
