import 'package:flutter/material.dart';
import '../../models/boleto_model.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../confirmation_button/confirmation_button.dart';
import '../deletar_boleto/deletar_boleto.dart';

class BoletoBottomSheet extends StatelessWidget {
  final void Function() onDeleteTap;
  final void Function() onSimTap;
  const BoletoBottomSheet({
    Key? key,
    required this.data,
    required this.onDeleteTap,
    required this.onSimTap,
  }) : super(key: key);

  final BoletoModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: AppColors.background,
      ),
      height: MediaQuery.of(context).size.height * 0.36,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.15,
            height: 3,
            color: AppColors.stroke,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 78.0),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: 'O boleto ',
                style: TextStyles.titleRegular.copyWith(color: AppColors.body),
                children: [
                  TextSpan(
                      text: data.name,
                      style: TextStyles.titleBoldHeading
                          .copyWith(color: AppColors.body)),
                  TextSpan(
                      text: ' no valor de R\$ ',
                      style: TextStyles.titleRegular
                          .copyWith(color: AppColors.body)),
                  TextSpan(
                    text: data.value!.toStringAsFixed(2),
                    style: TextStyles.titleBoldHeading
                        .copyWith(color: AppColors.body),
                  ),
                  TextSpan(
                      text: ' foi pago?',
                      style: TextStyles.titleRegular
                          .copyWith(color: AppColors.body)),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ConfirmationButton(
                  color: AppColors.shape,
                  label: 'Ainda não',
                  onTap: () {
                    Navigator.pop(context);
                  },
                  labelColor: AppColors.grey),
              ConfirmationButton(
                  color: AppColors.primary,
                  label: 'Sim',
                  onTap: onSimTap,
                  labelColor: AppColors.background),
            ],
          ),
          Divider(
            color: AppColors.stroke,
            thickness: 1,
            height: 1,
          ),
          DeletarBoletoButton(
            onTap: onDeleteTap,
          ),
        ],
      ),
    );
  }
}
