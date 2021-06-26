import 'package:flutter/material.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../../widgets/divider/divider_vertical.dart';
import '../../widgets/label_button/label_button.dart';

class SetLabelButtons extends StatelessWidget {
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;
  final bool enableSecondaryColor;
  final Color? widgetColor;

  const SetLabelButtons({
    Key? key,
    required this.primaryLabel,
    required this.primaryOnPressed,
    required this.secondaryLabel,
    required this.secondaryOnPressed,
    this.enablePrimaryColor = false,
    this.enableSecondaryColor = false,
    this.widgetColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widgetColor ?? AppColors.shape,
      height: 57,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            thickness: 1,
            height: 1,
            color: AppColors.stroke,
          ),
          Container(
            height: 56,
            child: Row(
              children: [
                Expanded(
                  child: LabelButton(
                    label: primaryLabel,
                    onPressed: primaryOnPressed,
                    style: enablePrimaryColor ? TextStyles.buttonPrimary : null,
                  ),
                ),
                DividerVertical(),
                Expanded(
                  child: LabelButton(
                    label: secondaryLabel,
                    style:
                        enableSecondaryColor ? TextStyles.buttonPrimary : null,
                    onPressed: secondaryOnPressed,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
