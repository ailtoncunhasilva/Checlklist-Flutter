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
  List<DropdownMenuItem<String>> fuelLevel = List();
  List<DropdownMenuItem<String>> serviceType = List();
  List<DropdownMenuItem<String>> typeMaintenance = List();

  String itemPaymentSelected;
  String itemFuelLevel;
  String itemServiceType;
  String itemTypeMaintenance;

  @override
  void initState() {
    super.initState();

    _dropdownPaymentForm();
    _dropdownFuelLevel();
    _dropdownTypeService();
    _dropdownTypeMaintenance();
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

  _dropdownFuelLevel() {
    fuelLevel.add(DropdownMenuItem(child: Text('1/4'), value: '1/4'));
    fuelLevel.add(
        DropdownMenuItem(child: Text('Meio tanque'), value: 'Meio tanque'));
    fuelLevel.add(DropdownMenuItem(child: Text('3/4'), value: '3/4'));
    fuelLevel.add(
        DropdownMenuItem(child: Text('Tanque cheio'), value: 'Tanque cheio'));
  }

  _dropdownTypeService() {
    serviceType.add(DropdownMenuItem(
      child: Text('Orçamento'),
      value: 'Orçamento',
    ));
    serviceType.add(DropdownMenuItem(
      child: Text('Execução'),
      value: 'Execução',
    ));
  }

  _dropdownTypeMaintenance(){
    typeMaintenance.add(DropdownMenuItem(child: Text('Manutenção corretiva'), value: 'Manuntenção corretiva'));
    typeMaintenance.add(DropdownMenuItem(child: Text('Manutenção preventiva'), value: 'Manuntenção preventiva'));
    typeMaintenance.add(DropdownMenuItem(child: Text('Manutenção preditiva'), value: 'Manuntenção preditiva'));
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
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Nivel do combustível',
              ),
              items: fuelLevel,
              value: itemFuelLevel,
              onSaved: (fuelLevel){
                _checklist.fuelLevel = fuelLevel;
              },
              onChanged: (valor) {
                setState(() {
                  itemFuelLevel = valor;
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
                  width: MediaQuery.of(context).size.width * 0.35,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Tipo de serviço',
                    ),
                    items: serviceType,
                    value: itemServiceType,
                    onSaved: (typeService){
                      _checklist.typeService = typeService;
                    },
                    onChanged: (valor) {
                      setState(() {
                        itemServiceType = valor;
                      });
                    },
                    validator: (text) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                          .valido(text);
                    },
                  ),
                ),
                Expanded(
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      labelText: 'Tipo de manutenção',
                    ),
                    items: typeMaintenance,
                    value: itemTypeMaintenance,
                    onSaved: (typeMaintenance){
                      _checklist.typeMaintenance = typeMaintenance;
                    },
                    onChanged: (valor) {
                      setState(() {
                        itemTypeMaintenance = valor;
                      });
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
          ],
        ),
      ),
    );
  }
}
