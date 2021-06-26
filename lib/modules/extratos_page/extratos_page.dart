import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow_nlw/shared/themes/app_colors.dart';
import 'package:payflow_nlw/shared/themes/app_text_styles.dart';

import 'package:payflow_nlw/shared/widgets/boleto_list/boleto_list_controller.dart';
import 'package:payflow_nlw/shared/widgets/extratos_list/extratos_page.dart';

class ExtratosPage extends StatefulWidget {
  const ExtratosPage({Key? key}) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<ExtratosPage> {
  final controller = BoletoListController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          AnimatedCard(
            initDelay: Duration(milliseconds: 005),
            direction: AnimatedCardDirection.left,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, left: 24, right: 24),
              child: Row(
                children: [
                  Text(
                    'Meus extratos',
                    style: TextStyles.titleBoldHeading,
                  ),
                ],
              ),
            ),
          ),
          AnimatedCard(
            initDelay: Duration(milliseconds: 005),
            direction: AnimatedCardDirection.left,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 24.0, horizontal: 24.0),
              child: Divider(
                thickness: 1,
                height: 1,
                color: AppColors.stroke,
              ),
            ),
          ),
          AnimatedCard(
            initDelay: Duration(milliseconds: 200),
            direction: AnimatedCardDirection.bottom,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: ExtratosList(
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
