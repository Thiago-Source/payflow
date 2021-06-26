import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow_nlw/shared/models/boleto_model.dart';
import 'package:payflow_nlw/shared/themes/app_colors.dart';
import 'package:payflow_nlw/shared/themes/app_text_styles.dart';
import 'package:payflow_nlw/shared/widgets/boleto_info/boleto_info_widget.dart';
import 'package:payflow_nlw/shared/widgets/boleto_list/boleto_list.dart';
import 'package:payflow_nlw/shared/widgets/boleto_list/boleto_list_controller.dart';

class MeusBoletosPage extends StatefulWidget {
  const MeusBoletosPage({Key? key}) : super(key: key);

  @override
  _MeusBoletosPageState createState() => _MeusBoletosPageState();
}

class _MeusBoletosPageState extends State<MeusBoletosPage> {
  final controller = BoletoListController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //BARRA BOLETOS A PAGAR
          Stack(
            children: [
              Container(
                color: AppColors.primary,
                height: 40,
                width: double.maxFinite,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ValueListenableBuilder<List<BoletoModel>>(
                    valueListenable: controller.boletosNotifier,
                    builder: (_, boletos, __) => AnimatedCard(
                        initDelay: Duration(milliseconds: 200),
                        direction: AnimatedCardDirection.top,
                        child: BoletoInfoWidget(
                            size:
                                boletos.where((e) => e.pagou == false).length)),
                  )),
            ],
          ),
          //CABEÇALHO MEUS BOLETOS
          Column(
            children: [
              AnimatedCard(
                initDelay: Duration(milliseconds: 005),
                direction: AnimatedCardDirection.left,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 24.0, left: 24, right: 24),
                  child: Row(
                    children: [
                      Text(
                        'Meus boletos',
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 24.0, horizontal: 24.0),
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: AppColors.stroke,
                  ),
                ),
              ),
            ],
          ),
          //LISTA DE BOLETOS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: AnimatedCard(
              initDelay: Duration(milliseconds: 200),
              direction: AnimatedCardDirection.bottom,
              child: BoletoList(
                controller: controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
