import 'package:flutter/material.dart';
import 'package:payflow_nlw/shared/models/user_model.dart';
import 'package:payflow_nlw/shared/widgets/boleto_bottom_sheet/boleto_bottom_sheet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/boleto_model.dart';
import '../../widgets/boleto_list/boleto_list_controller.dart';
import '../../widgets/boleto_tile/boleto_tile.dart';

class ExtratosList extends StatefulWidget {
  final BoletoListController controller;
  ExtratosList({Key? key, required this.controller}) : super(key: key);

  @override
  _ExtratosListState createState() => _ExtratosListState();
}

class _ExtratosListState extends State<ExtratosList> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<BoletoModel>>(
      valueListenable: widget.controller.boletosNotifier,
      builder: (_, boletos, __) => Column(
        children: boletos
            .where((e) => e.pagou == true)
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
                              onSimTap: (){},
                              onDeleteTap: () async {
                                final instance =
                                    await SharedPreferences.getInstance();
                                final json = instance.get('user') as String;
                                await widget.controller.deleteBoletos(i);
                                Navigator.popAndPushNamed(context, '/home',
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
