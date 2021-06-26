import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/models/boleto_model.dart';

class InsertBoletoController {
  final formKey = GlobalKey<FormState>();
  BoletoModel boletoModel = BoletoModel();

  String? validateName(String? value) =>
      value?.isEmpty ?? true ? "O nome não pode ser vazio" : null;
  String? validateVencimento(String? value) =>
      value?.isEmpty ?? true ? "A data de vencimento não pode ser vazio" : null;
  String? validateValor(double value) =>
      value == 0 ? "Insira um valor maior que R\$ 0,00" : null;
  String? validateCodigo(String? value) =>
      value?.isEmpty ?? true ? "O código do boleto não pode ser vazio" : null;

  void onChanged(
      {String? name, String? dueDate, double? value, String? barcode}) {
    boletoModel = boletoModel.copyWith(
        name: name, dueDate: dueDate, value: value, barcode: barcode);
  }

  Future<void> saveBoleto() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final boletos = instance.getStringList('boletos') ?? <String>[];
      boletos.add(boletoModel.toJson());
      await instance.setStringList('boletos', boletos);
    } catch (e) {}
  }

  Future<void> cadastrarBoleto() async {
    final form = formKey.currentState;
    if (form!.validate()) {
      return await saveBoleto();
    }
  }

  Future<void> pagarBoleto(int currentIndex) async {
    final instance = await SharedPreferences.getInstance();
    final response = instance.getStringList("boletos");
    var boletos = response!.map((e) => BoletoModel.fromJson(e)).toList();
    instance.remove("boletos");
    response.clear();
    BoletoModel boleto = boletos[currentIndex];
    boletoModel = boletoModel.copyWith(
      barcode: boleto.barcode,
      dueDate: boleto.dueDate,
      pagou: true,
      name: boleto.name,
      value: boleto.value,
    );
    boletos.removeAt(currentIndex);
    boletos.add(boletoModel);
    boletos.map((e) => response.add(e.toJson())).toList();
    await instance.setStringList("boletos", response);
  }
}
