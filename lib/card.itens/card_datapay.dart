import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/input_customized.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validadores/Validador.dart';

class DataPay extends StatefulWidget {
  final Checklist _checklist;

  DataPay(this._checklist);

  @override
  _DataPayState createState() => _DataPayState(_checklist);
}

class _DataPayState extends State<DataPay> {
  final Checklist _checklist;

  _DataPayState(this._checklist);

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
  );

  List<DropdownMenuItem<String>> paymentFormList = List();

  String itemPaymentSelected;

  @override
  void initState() {
    super.initState();

    _dropdownPaymentForm();
  }

  _dropdownPaymentForm() {
    paymentFormList
        .add(DropdownMenuItem(child: Text('Dinheiro'), value: 'Dinheiro'));
    paymentFormList.add(DropdownMenuItem(
        child: Text('Cartão Crédito'), value: 'Cartão Crédito'));
    paymentFormList.add(
        DropdownMenuItem(child: Text('Cartão Débito'), value: 'Cartão Débito'));
    paymentFormList
        .add(DropdownMenuItem(child: Text('Boleto'), value: 'Boleto'));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Forma de pagamento',
              ),
              value: itemPaymentSelected,
              items: paymentFormList,
              onSaved: (paymentForm) {
                _checklist.paymentForm = paymentForm;
              },
              onChanged: (valor) {
                setState(() {
                  itemPaymentSelected = valor;
                });
              },
              validator: (text) {
                return Validador()
                    .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                    .valido(text);
              },
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: MediaQuery.of(context).size.width * 0.47,
                  child: InputCustomized(
                    inputBorder: border,
                    hint: 'Data de entrada',
                    label: 'Data de entrada',
                    inputType: TextInputType.datetime,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    onSaved: (dateIn) {
                      _checklist.dateIn = dateIn;
                    },
                    validator: (text) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                          .valido(text);
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 4, top: 4),
                    child: InputCustomized(
                      inputBorder: border,
                      hint: 'Data de saída',
                      label: 'Data de saída',
                      inputType: TextInputType.datetime,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        DataInputFormatter(),
                      ],
                      onSaved: (dateOut) {
                        _checklist.dateOut = dateOut;
                      },
                      validator: (text) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                            .valido(text);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: InputCustomized(
                inputBorder: border,
                hint: 'Previsão de liberação',
                label: 'Previsão de liberação',
                inputType: TextInputType.datetime,
                inputFormatter: [
                  FilteringTextInputFormatter.digitsOnly,
                  DataInputFormatter(),
                ],
                onSaved: (release) {
                  _checklist.release = release;
                },
                validator: (text) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                      .valido(text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
