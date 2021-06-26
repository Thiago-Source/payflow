import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow_nlw/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/themes/app_colors.dart';
import '../../shared/themes/app_text_styles.dart';
import '../../shared/widgets/input_text/input_text.dart';
import '../../shared/widgets/set_label_buttons/set_label_buttons.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

import 'insert_boleto_controller.dart';

class InsertBoletoPage extends StatefulWidget {
  final String? barcode;

  const InsertBoletoPage({Key? key, this.barcode}) : super(key: key);

  @override
  _InsertBoletoPageState createState() => _InsertBoletoPageState();
}

class _InsertBoletoPageState extends State<InsertBoletoPage> {
  final controller = InsertBoletoController();

  final MoneyMaskedTextController moneyInputTextController =
      MoneyMaskedTextController(leftSymbol: 'R\$ ', decimalSeparator: ',');

  final MaskedTextController dueDateInputTextController =
      MaskedTextController(mask: '00/00/0000');
  final TextEditingController barcodeInputTextController =
      TextEditingController();

  @override
  void initState() {
    if (widget.barcode != null) {
      barcodeInputTextController.text = widget.barcode!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: BackButton(
          color: AppColors.input,
        ),
        elevation: 0,
        backgroundColor: AppColors.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 93.0, vertical: 40),
                child: Text(
                  'Preencha os dados do boleto',
                  style: TextStyles.titleBoldHeading,
                  textAlign: TextAlign.center,
                ),
              ),
              Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      InputText(
                        label: 'Nome do boleto',
                        validator: controller.validateName,
                        icon: Icons.description_outlined,
                        onChanged: (value) {
                          controller.onChanged(name: value);
                        },
                      ),
                      InputText(
                        controller: dueDateInputTextController,
                        label: 'Vencimento',
                        validator: controller.validateVencimento,
                        icon: FontAwesomeIcons.timesCircle,
                        onChanged: (value) {
                          controller.onChanged(dueDate: value);
                        },
                      ),
                      InputText(
                        controller: moneyInputTextController,
                        label: 'Valor',
                        icon: FontAwesomeIcons.wallet,
                        validator: (_) => controller.validateValor(
                            moneyInputTextController.numberValue),
                        onChanged: (value) {
                          controller.onChanged(
                              value: moneyInputTextController.numberValue);
                        },
                      ),
                      InputText(
                        controller: barcodeInputTextController,
                        label: 'Código',
                        validator: controller.validateCodigo,
                        icon: FontAwesomeIcons.barcode,
                        onChanged: (value) {
                          controller.onChanged(barcode: value);
                        },
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      bottomNavigationBar: SetLabelButtons(
        enableSecondaryColor: true,
        widgetColor: AppColors.background,
        primaryLabel: 'Cancelar',
        primaryOnPressed: () {
          Navigator.pop(context);
        },
        secondaryLabel: 'Cadastrar',
        secondaryOnPressed: () async {
          final instance = await SharedPreferences.getInstance();
          final json = instance.get('user') as String;
          await controller.cadastrarBoleto();
          Navigator.pushReplacementNamed(context, '/home',
              arguments: UserModel.fromJson(json));
        },
      ),
    );
  }
}
