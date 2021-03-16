import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/input_customized.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validadores/validadores.dart';

class CardClient extends StatefulWidget {
  final Checklist _checklist;

  CardClient(this._checklist);

  @override
  _CardClientState createState() => _CardClientState();
}

class _CardClientState extends State<CardClient> {
  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
  );

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _dropdownRegister();
    _dropdownTipClient();
  }

  List<DropdownMenuItem<String>> combustivelList = List();

  List<DropdownMenuItem<String>> registerList = List();

  List<DropdownMenuItem<String>> tipClient = List();

  String itemSelected;

  String itemRegisterSelected;

  String itemTipClient;

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

  _dropdownRegister() {
    registerList.add(DropdownMenuItem(child: Text('Sim'), value: 'Sim'));
    registerList.add(DropdownMenuItem(child: Text('Não'), value: 'Não'));
  }

  _dropdownTipClient() {
    tipClient.add(
        DropdownMenuItem(child: Text('Pessoa Física'), value: 'Pessoa Física'));
    tipClient.add(DropdownMenuItem(
        child: Text('Pessoa Jurídica'), value: 'Pessoa Jurídica'));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Possui cadastro conosco?',
              ),
              value: itemRegisterSelected,
              onSaved: (registerList) {
                widget._checklist.registerList = registerList;
              },
              items: registerList,
              validator: (text) {
                return Validador()
                    .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                    .valido(text);
              },
              onChanged: (valor) {
                setState(() {
                  itemRegisterSelected = valor;
                });
              },
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                labelText: 'Tipo de cliente:',
              ),
              value: itemTipClient,
              onSaved: (tipClient) {
                widget._checklist.tipClient = tipClient;
              },
              items: tipClient,
              validator: (text) {
                return Validador()
                    .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                    .valido(text);
              },
              onChanged: (valor) {
                setState(() {
                  itemTipClient = valor;
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: InputCustomized(
                label: 'Nome do condutor',
                hint: 'Nome do condutor',
                onSaved: (name) {
                  widget._checklist.name = name;
                },
                inputType: TextInputType.name,
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.50,
                    child: itemTipClient == 'Pessoa Física'
                        ? InputCustomized(
                          label: 'CPF',
                            hint: 'CPF',
                            onSaved: (cpf) {
                              widget._checklist.cpf = cpf;
                            },
                            inputType: TextInputType.number,
                            inputBorder: border,
                            validator: (text) {
                              return Validador()
                                  .add(Validar.CPF, msg: 'CPF inválido')
                                  .add(Validar.OBRIGATORIO,
                                      msg: 'Campo Obrigatório')
                                  .valido(text);
                            },
                          )
                        : InputCustomized(
                          label: 'CNPJ',
                            hint: 'CNPJ',
                            onSaved: (cpf) {
                              widget._checklist.cpf = cpf;
                            },
                            inputType: TextInputType.number,
                            inputBorder: border,
                            validator: (text) {
                              return Validador()
                                  .add(Validar.CNPJ, msg: 'CNPJ inválido')
                                  .add(Validar.OBRIGATORIO,
                                      msg: 'Campo Obrigatório')
                                  .valido(text);
                            },
                          ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: InputCustomized(
                        label: 'Fone WhatsApp',
                          inputType: TextInputType.number,
                          hint: 'Fone WhatsApp',
                          onSaved: (phone) {
                            widget._checklist.phone = phone;
                          },
                          inputFormatter: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            TelefoneInputFormatter(),
                          ],
                          inputBorder: border,
                          validator: (text) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: 'Campo obrigatório')
                                .valido(text);
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 4),
              child: InputCustomized(
                label: 'E-mail',
                hint: 'E-mail',
                onSaved: (email) {
                  widget._checklist.email = email;
                },
                inputBorder: border,
                validator: (text) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                      .add(Validar.EMAIL, msg: 'E-mail inválido')
                      .valido(text);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: InputCustomized(
                label: 'Ednereço com CEP',
                hint: 'Endereço com CEP',
                inputBorder: border,
                onSaved: (address){
                  widget._checklist.address = address;
                },
                validator: (text) {
                  return Validador()
                      .add(Validar.OBRIGATORIO, msg: 'Campo obrigatório')
                      .valido(text);
                },
                maxLines: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
