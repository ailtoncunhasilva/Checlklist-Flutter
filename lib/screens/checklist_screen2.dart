import 'dart:io';

import 'package:auto_checklist/card.itens/card_client.dart';
import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/models/user_model.dart';
import 'package:auto_checklist/screens/meuschecklist_screen.dart';
import 'package:auto_checklist/widget/input_customized.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:validadores/Validador.dart';

class ChecklistScreen2 extends StatefulWidget {
  @override
  _ChecklistScreen2State createState() => _ChecklistScreen2State();
}

class _ChecklistScreen2State extends State<ChecklistScreen2> {
  List<File> _imageList = List();
  final _formKey = GlobalKey<FormState>();

  CardClient cardClient;

  final OutlineInputBorder borderForm =
      OutlineInputBorder(borderRadius: BorderRadius.circular(4));

  List<DropdownMenuItem<String>> combustivelList = List();
  List<DropdownMenuItem<String>> registerList = List();
  List<DropdownMenuItem<String>> tipClient = List();

  Checklist _checklist;
  BuildContext _dialogContext;

  String itemSelected;
  String itemRegisterSelected;
  String itemTipClient;

  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _dropdownRegister();
    _dropdownTipClient();

    _checklist = Checklist.gerarID();
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

  _dropdownRegister() {
    registerList.add(DropdownMenuItem(child: Text('Sim'), value: 'Sim'));
    registerList.add(DropdownMenuItem(child: Text('Não'), value: 'Não'));
  }

  _dropdownTipClient(){
    tipClient.add(DropdownMenuItem(child: Text('Pessoa Física'), value: 'Pessoa Física'));
    tipClient.add(DropdownMenuItem(child: Text('Pessoa Jurídica'), value: 'Pessoa Jurídica'));
  }

  _selectImage() async {
    File imageSelected =
        await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageSelected != null) {
      setState(() {
        _imageList.add(imageSelected);
      });
    }
  }

  _opneDialog(context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text(
                  'Salvando Checklist...',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          );
        });
  }

  _saveChecklist() async {
    _opneDialog(_dialogContext);

    await _uploadImages();

    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();
    String idUserLogged = userLogged.uid;
    Firestore.instance
        .collection('meus_checklists')
        .document(idUserLogged)
        .collection('checklists')
        .document(_checklist.id)
        .setData(_checklist.toMap())
        .then((_) {
      Navigator.pop(_dialogContext);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MeusChecklistScreen()));
    });
  }

  Future _uploadImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    StorageReference pastaRaiz = storage.ref();
    for (var image in _imageList) {
      String nameImage = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference arquivo = pastaRaiz
          .child('Meus_checklists')
          .child(_checklist.id)
          .child(nameImage);

      StorageUploadTask uploadTask = arquivo.putFile(image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      _checklist.photos.add(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('CHECKLIST'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ListView(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        child: Center(
                            child: Text(
                          'Dados do cliente',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                      ),
                      Column(
                        children: [
                          CardClient(_checklist),
                          /*Card(
                            elevation: 8,
                            margin: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
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
                                          .add(Validar.OBRIGATORIO,
                                              msg: 'Campo obrigatório')
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
                                          .add(Validar.OBRIGATORIO,
                                              msg: 'Campo obrigatório')
                                          .valido(text);
                                    },
                                    onChanged: (valor) {
                                      setState(() {
                                        itemTipClient = valor;
                                      });
                                    },
                                  ),
                                  InputCustomized(
                                    hint: 'Nome do condutor',
                                    onSaved: (name) {
                                      _checklist.name = name;
                                    },
                                    inputType: TextInputType.name,
                                    inputBorder: borderForm,
                                    validator: (text) {
                                      return Validador()
                                          .add(Validar.OBRIGATORIO,
                                              msg: 'Campo obrigatório')
                                          .valido(text);
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.50,
                                          child: itemTipClient == 'Pessoa Física' ? InputCustomized(
                                            hint: 'CPF',
                                            onSaved: (cpf) {
                                              _checklist.cpf = cpf;
                                            },
                                            inputType: TextInputType.number,
                                            inputBorder: borderForm,
                                            validator: (text) {
                                              return Validador()
                                                  .add(Validar.CPF,
                                                      msg: 'CPF inválido')
                                                  .add(Validar.OBRIGATORIO,
                                                      msg: 'Campo Obrigatório')
                                                  .valido(text);
                                            },
                                          ) : InputCustomized(
                                            hint: 'CNPJ',
                                            onSaved: (cpf) {
                                              _checklist.cpf = cpf;
                                            },
                                            inputType: TextInputType.number,
                                            inputBorder: borderForm,
                                            validator: (text) {
                                              return Validador()
                                                  .add(Validar.CNPJ,
                                                      msg: 'CNPJ inválido')
                                                  .add(Validar.OBRIGATORIO,
                                                      msg: 'Campo Obrigatório')
                                                  .valido(text);
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(left: 4),
                                            child: InputCustomized(
                                                inputType: TextInputType.number,
                                                hint: 'Fone WhatsApp',
                                                onSaved: (phone) {
                                                  _checklist.phone = phone;
                                                },
                                                inputFormatter: [
                                                  WhitelistingTextInputFormatter
                                                      .digitsOnly,
                                                  TelefoneInputFormatter(),
                                                ],
                                                inputBorder: borderForm,
                                                validator: (text) {
                                                  return Validador()
                                                      .add(Validar.OBRIGATORIO,
                                                          msg:
                                                              'Campo obrigatório')
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
                                      hint: 'E-mail',
                                      onSaved: (email) {
                                        _checklist.email = email;
                                      },
                                      inputBorder: borderForm,
                                      validator: (text) {
                                        return Validador()
                                            .add(Validar.OBRIGATORIO,
                                                msg: 'Campo obrigatório')
                                            .add(Validar.EMAIL,
                                                msg: 'E-mail inválido')
                                            .valido(text);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                          Container(
                            height: 30,
                            child: Center(
                                child: Text(
                              'Dados do veículo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                          ),
                          Card(
                            elevation: 8,
                            margin: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  InputCustomized(
                                    label: 'Marca/Modelo',
                                    hint: 'Marca/Modelo',
                                    onSaved: (marca) {
                                      _checklist.marca = marca;
                                    },
                                    inputBorder: borderForm,
                                    validator: (text) {
                                      return Validador()
                                          .add(Validar.OBRIGATORIO,
                                              msg: 'Campo obrigatório')
                                          .valido(text);
                                    },
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
                                            inputBorder: borderForm,
                                            validator: (text) {
                                              return Validador()
                                                  .add(Validar.OBRIGATORIO,
                                                      msg: 'Campo obrigatório')
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
                                            inputBorder: borderForm,
                                            validator: (text) {
                                              return Validador()
                                                  .add(Validar.OBRIGATORIO,
                                                      msg: 'Campo obrigatório')
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
                                      inputBorder: borderForm,
                                      validator: (text) {
                                        return Validador()
                                            .add(Validar.OBRIGATORIO,
                                                msg: 'Campo obrigatório')
                                            .maxLength(17)
                                            .minLength(17)
                                            .valido(text);
                                      },
                                    ),
                                  ),
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                        labelText: 'Tipo de combustível'),
                                    value: itemSelected,
                                    //hint: Text('Tipo de combustível'),
                                    onSaved: (combustivel) {
                                      _checklist.combustivel = combustivel;
                                    },
                                    items: combustivelList,
                                    validator: (text) {
                                      return Validador()
                                          .add(Validar.OBRIGATORIO,
                                              msg: 'Campo obrigatório')
                                          .valido(text);
                                    },
                                    onChanged: (valor) {
                                      setState(() {
                                        itemSelected = valor;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            child: Center(
                              child: Text(
                                'Fotos checklist',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            elevation: 8,
                            margin: EdgeInsets.symmetric(
                                horizontal: 6, vertical: 3),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  FormField<List>(
                                    initialValue: _imageList,
                                    validator: (image) {
                                      if (image.length == 0 ||
                                          image.length < 8) {
                                        return 'Necessário 8 imagens no mínimo';
                                      }
                                      return null;
                                    },
                                    builder: (state) {
                                      return Column(
                                        children: [
                                          Container(
                                            height: 110,
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _imageList.length + 1,
                                              itemBuilder: (context, index) {
                                                if (index ==
                                                    _imageList.length) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        _selectImage();
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[400],
                                                        radius: 50,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.add_a_photo,
                                                              size: 40,
                                                              color: Colors
                                                                  .grey[100],
                                                            ),
                                                            Text(
                                                              'Adicionar',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      100]),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                if (_imageList.length > 0) {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              Dialog(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Image.file(
                                                                    _imageList[
                                                                        index]),
                                                                FlatButton(
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      _imageList
                                                                          .removeAt(
                                                                              index);
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                    });
                                                                  },
                                                                  child: Text(
                                                                      'Excluir'),
                                                                  textColor:
                                                                      Colors
                                                                          .red,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            FileImage(
                                                                _imageList[
                                                                    index]),
                                                        radius: 50,
                                                        child: Container(
                                                          color: Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.4),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.red),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                return Container();
                                              },
                                            ),
                                          ),
                                          if (state.hasError)
                                            Container(
                                              child: Text(
                                                '[${state.errorText}]',
                                                style: TextStyle(
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                        ],
                                      );
                                    },
                                  ),
                                  Divider(color: Colors.grey[500]),
                                  InputCustomized(
                                    label: 'Observações do Checklist',
                                    hint: 'Observações do checklist',
                                    onSaved: (observation) {
                                      _checklist.observation = observation;
                                    },
                                    maxLines: null,
                                    inputBorder: borderForm,
                                    validator: (text) {
                                      return Validador()
                                          .add(Validar.OBRIGATORIO,
                                              msg: 'Campo obrigatório')
                                          .valido(text);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text('FINALIZAR CHECKLIST'),
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                _dialogContext = context;
                                _saveChecklist();
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
