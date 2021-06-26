import 'package:flutter/material.dart';
import 'package:payflow_nlw/modules/insert_boleto/insert_boleto_controller.dart';
import 'package:payflow_nlw/shared/models/user_model.dart';
import 'package:payflow_nlw/shared/widgets/boleto_bottom_sheet/boleto_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/boleto_model.dart';
import '../../widgets/boleto_list/boleto_list_controller.dart';
import '../../widgets/boleto_tile/boleto_tile.dart';

class BoletoList extends StatefulWidget {
  final BoletoListController controller;
  BoletoList({Key? key, required this.controller}) : super(key: key);

  @override
  _BoletoListState createState() => _BoletoListState();
}

class _BoletoListState extends State<BoletoList> {
  InsertBoletoController boletoController = InsertBoletoController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (_, boletos, __) => Column(
        children: boletos
            .where((e) => e.pagou == false)
            .toList()
            .asMap()
            .map((i, e) => MapEntry(
                i,
                InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                          ),
                          context: context,
                          builder: (context) {
                            return BoletoBottomSheet(
                              data: e,
                              onSimTap: () async {
                                final instance =
                                    await SharedPreferences.getInstance();
                                final json = instance.get('user') as String;
                                await boletoController.pagarBoleto(i);
                                setState(() {});
                                Navigator.pushReplacementNamed(context, '/home',
                                    arguments: UserModel.fromJson(json));
                              },
                              onDeleteTap: () async {
                                final instance =
                                    await SharedPreferences.getInstance();
                                final json = instance.get('user') as String;
                                await widget.controller.deleteBoletos(i);
                                Navigator.pushReplacementNamed(context, '/home',
                                    arguments: UserModel.fromJson(json));
                              },
                            );
                          });
                    },
                    child: BoletoTile(data: e))))
            .values
            .toList(),
      ),
    );
  }
}

//boletos.map((e) => BoletoTile(data: e)).toList(),
