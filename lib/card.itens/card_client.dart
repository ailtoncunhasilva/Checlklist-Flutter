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
  _CardClientState createState() => _CardClientState(_checklist);
}

class _CardClientState extends State<CardClient> {

  final Checklist _checklist;

  _CardClientState(this._checklist);

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
  );

  @override
  void initState() {
    super.initState();
    _dropdownRegister();
    _dropdownTipClient();
  }

  List<DropdownMenuItem<String>> combustivelList = List();

  List<DropdownMenuItem<String>> registerList = List();

  List<DropdownMenuItem<String>> tipClient = List();

  String itemSelected;

  String itemRegisterSelected;

  String itemTipClient;

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
                _checklist.registerList = registerList;
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
                _checklist.tipClient = tipClient;
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
                  _checklist.name = name;
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
                              _checklist.cpf = cpf;
                            },
                            inputType: TextInputType.number,
                            inputBorder: border,
                            validator: itemRegisterSelected == 'Sim' ? null : (text) {
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
                              _checklist.cpf = cpf;
                            },
                            inputType: TextInputType.number,
                            inputBorder: border,
                            validator: itemRegisterSelected == 'Sim' ? null : (text) {
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
                            _checklist.phone = phone;
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
                  _checklist.email = email;
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
                  _checklist.address = address;
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
