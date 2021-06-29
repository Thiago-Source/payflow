import 'package:flutter/cupertino.dart';

import '../../models/boleto_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoletoListController {
  final boletosNotifier = ValueNotifier<List<BoletoModel>>(<BoletoModel>[]);
  BoletoModel boletoModel = BoletoModel();

  List<BoletoModel> get boletos => boletosNotifier.value;

  set boletos(List<BoletoModel> value) => boletosNotifier.value = value;

  BoletoListController() {
    getBoletos();
  }

  Future<void> getBoletos() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final response = instance.getStringList('boletos') ?? <String>[];
      boletos = response.map((e) => BoletoModel.fromJson(e)).toList();
    } catch (e) {
      boletos = <BoletoModel>[];
    }
  }

  Future<void> deleteBoletos(int currentIndex) async {
    final instance = await SharedPreferences.getInstance();
    final boletos = instance.getStringList('boletos');
    boletos!.removeAt(currentIndex);
    await instance.setStringList('boletos', boletos);
  }
}
