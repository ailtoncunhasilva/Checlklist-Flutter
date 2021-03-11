import 'package:flutter/material.dart';

class VehicleForm extends StatelessWidget {
  final _marcaController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearModelController = TextEditingController();
  final _colorController = TextEditingController();
  final _chassisController = TextEditingController();
  final _codMotorController = TextEditingController();
  final _valvulasController = TextEditingController();
  final _cilinderController = TextEditingController();
  final _cilindradasController = TextEditingController();
  final _ansuranceController = TextEditingController();
  final _lightAnomaleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          maintainState: true,
          tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          title: Text('Dados do veículo'),
          leading: Icon(Icons.directions_car),
          children: [
            Container(
              padding: EdgeInsets.all(6),
              child: Column(
                children: [
                  textVehicleForm(_marcaController, 'Marca', (text) {
                    if (text.isEmpty) return 'Dado inválido!';
                  }),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child:
                            textVehicleForm(_modelController, 'Modelo', (text) {
                          if (text.isEmpty) return 'Dado inválido!';
                        }),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: textVehicleFormWithTextType(_yearModelController,
                            'Ano/MOdelo', TextInputType.number, (text) {
                          if (text.isEmpty ||
                              text.length > 4 ||
                              text.length < 4) return 'Ano/Modelo inválido!';
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: textVehicleForm(_colorController, 'Cor', (text) {
                          if (text.isEmpty) return 'Dado inválido!';
                        }),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: textVehicleForm(_chassisController, 'Chassis',
                            (text) {
                          if (text.isEmpty ||
                              text.length > 17 ||
                              text.length < 17)
                            return 'Dado inválido/minímo de 17 caracteres';
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: textVehicleForm(_codMotorController, 'Cód.Motor',
                            (text) {
                          if (text.isEmpty ||
                              text.length > 10 ||
                              text.length < 10) return 'Dado inválido!';
                        }),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: textVehicleFormWithTextType(_valvulasController,
                            'Válvulas', TextInputType.number, (text) {
                          if (text.isEmpty) return 'Dado inválido!';
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: textVehicleFormWithTextType(_cilinderController,
                            'Cilindros', TextInputType.number, (text) {
                          if (text.isEmpty) return 'Dado inválido!';
                        }),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: textVehicleForm(
                            _cilindradasController, 'Cilindradas', (text) {
                          if (text.isEmpty) return 'Dado inválido!';
                        }),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: textVehicleForm(_ansuranceController, 'Seguro',
                            (text) {
                          if (text.isEmpty) return 'Dado inválido!';
                        }),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: textVehicleForm(
                            _lightAnomaleController, 'Luz de anomalia', (text) {
                          if (text.isEmpty) return 'Dado inválido!';
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        Divider(color: Theme.of(context).primaryColor),
      ],
    );
  }
}

Widget textVehicleForm(controller, labelText, validate) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      isDense: true,
      labelText: labelText,
    ),
    validator: validate,
  );
}

Widget textVehicleFormWithTextType(controller, labelText, textType, validate) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      isDense: true,
      labelText: labelText,
    ),
    keyboardType: textType,
    validator: validate,
  );
}
