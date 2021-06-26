import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow_nlw/shared/themes/app_colors.dart';
import 'package:payflow_nlw/shared/themes/app_text_styles.dart';

class DeletarBoletoButton extends StatelessWidget {
  final void Function() onTap;
  const DeletarBoletoButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.trashAlt,
            color: AppColors.delete,
          ),
          SizedBox(
            width: 17.5,
          ),
          Text(
            'Deletar boleto',
            style: TextStyles.buttonHeading.copyWith(color: AppColors.delete),
          ),
        ],
      ),
    );
  }
}
