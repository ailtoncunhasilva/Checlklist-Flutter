import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/input_customized.dart';
import 'package:flutter/material.dart';
import 'package:validadores/validadores.dart';

class CardVehicle extends StatefulWidget {
  final Checklist _checklist;

  CardVehicle(this._checklist);

  @override
  _CardVehicleState createState() => _CardVehicleState(_checklist);
}

class _CardVehicleState extends State<CardVehicle> {
  final Checklist _checklist;

  _CardVehicleState(this._checklist);

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
  );

  List<DropdownMenuItem<String>> typeVehicleList = List();
  List<DropdownMenuItem<String>> combustivelList = List();

  String itemTypeVehicle;
  String itemSelected;

  @override
  void initState() {
    super.initState();

    _dropdownTypeVehicle();
    _carregarItensDropdown();
  }

  _dropdownTypeVehicle() {
    typeVehicleList.add(DropdownMenuItem(child: Text('Moto'), value: 'Moto'));
    typeVehicleList
        .add(DropdownMenuItem(child: Text('Caminhão'), value: 'Caminhão'));
    typeVehicleList
        .add(DropdownMenuItem(child: Text('Ônibus'), value: 'Ônibus'));
    typeVehicleList.add(DropdownMenuItem(child: Text('Carro'), value: 'Carro'));
    typeVehicleList.add(DropdownMenuItem(child: Text('Van'), value: 'Van'));
  }

  _carregarItensDropdown() {
    combustivelList
        .add(DropdownMenuItem(child: Text('Gasolina'), value: 'Gasolina'));
    combustivelList.add(DropdownMenuItem(
      child: Text('Etanol'),
      value: 'Etanol',
    ));
    combustivelList.add(DropdownMenuItem(child: Text('Flex'), value: 'Flex'));
    combustivelList
        .add(DropdownMenuItem(child: Text('Diesel'), value: 'Diesel'));
    combustivelList
        .add(DropdownMenuItem(child: Text('Elétrico'), value: 'Elétrico'));
    combustivelList.add(DropdownMenuItem(child: Text('Gás'), value: 'Gás'));
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
                labelText: 'Tipo de veículo',
              ),
              items: typeVehicleList,
              value: itemTypeVehicle,
              onSaved: (typeVehicle) {
                _checklist.typeVehicle = typeVehicle;
              },
              onChanged: (valor) {
                setState(() {
                  itemTypeVehicle = valor;
                });
              },
              validator: (text) {
                return Validador()
                    .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                    .valido(text);
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: InputCustomized(
                label: 'Marca/Modelo',
                hint: 'Marca/Modelo',
                onSaved: (marca) {
                  _checklist.marca = marca;
                },
                inputBorder: border,
                validator: (text) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                      .valido(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Expanded(
                    child: InputCustomized(
                      label: 'Ano',
                      hint: 'Ano',
                      onSaved: (yearModel) {
                        _checklist.yearModel = yearModel;
                      },
                      inputType: TextInputType.number,
                      inputBorder: border,
                      validator: (text) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                            .maxLength(4)
                            .minLength(4)
                            .valido(text);
                      },
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: InputCustomized(
                      label: 'Placa',
                      hint: 'placa',
                      onSaved: (placa) {
                        _checklist.placa = placa;
                      },
                      inputBorder: border,
                      validator: (text) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                            .maxLength(7)
                            .minLength(7)
                            .valido(text);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: InputCustomized(
                label: 'Chassis',
                hint: 'Chassis',
                onSaved: (chassis) {
                  _checklist.chassis = chassis;
                },
                inputBorder: border,
                validator: (text) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                      .maxLength(17)
                      .minLength(17)
                      .valido(text);
                },
              ),
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(labelText: 'Tipo de combustível'),
              value: itemSelected,
              onSaved: (combustivel) {
                _checklist.combustivel = combustivel;
              },
              items: combustivelList,
              validator: (text) {
                return Validador()
                    .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                    .valido(text);
              },
              onChanged: (valor) {
                setState(() {
                  itemSelected = valor;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: InputCustomized(
                      label: 'Km',
                      hint: 'Km',
                      inputBorder: border,
                      inputType: TextInputType.number,
                      validator: (text) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                            .valido(text);
                      },
                      onSaved: (km) {
                        _checklist.km = km;
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: InputCustomized(
                        label: 'Frota',
                        hint: 'Frota',
                        inputBorder: border,
                        validator: (text) {
                          return Validador()
                              .add(Validar.OBRIGATORIO,
                                  msg: 'Campo obrigatório')
                              .valido(text);
                        },
                        onSaved: (frota) {
                          _checklist.frota = frota;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: InputCustomized(
                      label: 'Cor',
                      hint: 'Cor',
                      inputBorder: border,
                      validator: (text) {
                        return Validador()
                            .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                            .valido(text);
                      },
                      onSaved: (km) {
                        _checklist.km = km;
                      },
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: InputCustomized(
                        label: 'Renavam',
                        hint: 'Renavam',
                        inputBorder: border,
                        inputType: TextInputType.number,
                        validator: (text) {
                          return Validador()
                              .add(Validar.OBRIGATORIO,
                                  msg: 'Campo obrigatório')
                              .valido(text);
                        },
                        onSaved: (frota) {
                          _checklist.frota = frota;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
