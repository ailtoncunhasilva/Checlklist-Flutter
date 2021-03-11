import 'dart:io';

import 'package:auto_checklist/data/client_data.dart';
import 'package:auto_checklist/data/vehicle_data.dart';
import 'package:auto_checklist/models/checklist_model.dart';
import 'package:auto_checklist/models/user_model.dart';
import 'package:auto_checklist/screens/meuschecklist_screen.dart';
import 'package:auto_checklist/widget/budget_form.dart';
import 'package:auto_checklist/widget/servicerequest_form.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:signature/signature.dart';

class ChecklistScreen extends StatefulWidget {
  final ClientData clientData;
  final VehicleData vehicleData;

  ChecklistScreen({this.clientData, this.vehicleData});

  @override
  _ChecklistScreenState createState() =>
      _ChecklistScreenState(clientData, vehicleData);
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final ClientData clientData;
  final VehicleData vehicleData;

  final _formKey = GlobalKey<FormState>();

  _ChecklistScreenState(this.clientData, this.vehicleData);

  final _nameController = TextEditingController();
  final _cpfController = TextEditingController();
  final _rgController = TextEditingController();
  final _addressController = TextEditingController();
  final _neighborhoodController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _zipCodeController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
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
  final _tyreController = TextEditingController();
  final _stepController = TextEditingController();
  final _rodasController = TextEditingController();
  final _marcaTyreController = TextEditingController();
  final _combustivelController = TextEditingController();
  final _somController = TextEditingController();
  final _extintorController = TextEditingController();
  final _trianguloController = TextEditingController();
  final _chaverodaController = TextEditingController();
  final _macacoController = TextEditingController();
  final _antenaController = TextEditingController();
  final _farolController = TextEditingController();
  final _lanternatraseiraController = TextEditingController();
  final _crlvController = TextEditingController();
  final _typecombustivelController = TextEditingController();
  final _observationController = TextEditingController();
  final _vidroEletricoController = TextEditingController();
  final _controllerSignature1 = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );
  final _controllerSignature2 = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CHECKLIST CAR',
        ),
        centerTitle: true,
        actions: [
          FlatButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MeusChecklistScreen()));
            },
            child: Text(
              'Meus\nChecklists',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ListView(
            children: [
              Container(
                height: 50,
                color: Colors.blueGrey[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${!model.isLoggedIn() ? '' : model.userData['name']}',
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    clientForm(
                      context,
                      _nameController,
                      _cpfController,
                      _rgController,
                      _addressController,
                      _neighborhoodController,
                      _cityController,
                      _stateController,
                      _zipCodeController,
                      _phoneController,
                      _emailController,
                    ),
                    vehicleForm(
                      context,
                      _marcaController,
                      _modelController,
                      _yearModelController,
                      _colorController,
                      _chassisController,
                      _codMotorController,
                      _valvulasController,
                      _cilinderController,
                      _cilindradasController,
                      _ansuranceController,
                      _lightAnomaleController,
                    ),
                    checklistForm(
                      context,
                      _tyreController,
                      _stepController,
                      _rodasController,
                      _marcaTyreController,
                      _combustivelController,
                      _typecombustivelController,
                      _somController,
                      _extintorController,
                      _trianguloController,
                      _chaverodaController,
                      _macacoController,
                      _antenaController,
                      _vidroEletricoController,
                      _farolController,
                      _lanternatraseiraController,
                      _crlvController,
                      _observationController,
                    ),
                    Photo(),
                    //addPhoto(context),
                    //PhotoForm(),
                    //VehicleForm(),
                    //ChecklistForm(),
                    ServiceRequestForm(),
                    BudgetForm(),
                    //SubscriptionForm(),
                    signatureController(
                        context, _controllerSignature1, _controllerSignature2),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(8),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Map<String, dynamic> checklistData = {
                        'name': _nameController.text,
                        'cpf': _cpfController.text,
                        'rg': _rgController.text,
                        'address': _addressController.text,
                        'neighborhood': _neighborhoodController.text,
                        'city': _cityController.text,
                        'state': _stateController.text,
                        'zipCode': _zipCodeController.text,
                        'phone': _phoneController.text,
                        'email': _emailController.text,
                        'marca': _marcaController.text,
                        'modelo': _modelController.text,
                        'ano': _yearModelController.text,
                        'cor': _colorController.text,
                        'chassis': _chassisController.text,
                        'cod.Motor': _codMotorController.text,
                        'valvulas': _valvulasController.text,
                        'cilindro': _cilinderController.text,
                        'cilindradas': _cilindradasController.text,
                        'seguro': _ansuranceController.text,
                        'luz de anomalia': _lightAnomaleController.text,
                        'pneus': _tyreController.text,
                        'step': _stepController.text,
                        'rodas': _rodasController.text,
                        'marca dos pneus': _marcaTyreController.text,
                        'tanque de combustível': _combustivelController.text,
                        'tipo de combustível': _typecombustivelController.text,
                        'som': _somController.text,
                        'extintor': _extintorController.text,
                        'triangulo': _trianguloController.text,
                        'chave de roda': _chaverodaController.text,
                        'macaco': _macacoController.text,
                        'antena': _antenaController.text,
                        'vidroEléttrico': _vidroEletricoController.text,
                        'farol': _farolController.text,
                        'lanternas traseiras': _lanternatraseiraController.text,
                        'documento do veículo': _crlvController.text,
                        'Observações do checklist': _observationController.text,
                        'Assinatura 1': _controllerSignature1.toString(),
                        'Assinatura 2': _controllerSignature2.toString(),
                      };

                      ChecklistModel.of(context).saveChecklist(
                        checklistData: checklistData,
                      );
                    }
                    /*ChecklistData checklistData = ChecklistData();
                checklistData.clientData = clientData;
                checklistData.vehicleData = vehicleData;

                ChecklistModel.of(context).addChecklistItem(checklistData);*/
                  },
                  child: Text(
                    'Salvar Checklist',
                  ),
                  textColor: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<String> combustivel = [
  'Reserva',
  '1/4',
  'Meio tanque',
  '3/4',
  'Tanque cheio',
];

List<String> items = [
  'Danificado',
  'Ok',
  'Inexistente',
];

List<String> itensPneus = [
  'Novos',
  'Meia vida',
  'Fim de vida',
  'Danificado',
];
String selectedText = '';

List<String> marcaPneus = [
  'Pirelli',
  'Continental',
  'Michelin',
  'Birdgestone',
  'Dunlop',
  'Goodyear',
  'Firestone',
  'Maxxis',
  'Marshal',
  'Gtradial',
  'Roadstone',
  'Outros',
];

List<String> antena = [
  'Antena interna',
  'Antena externa',
  'Inexistente',
];

List<String> simpleItem = [
  'OK',
  'Inexistente',
];

List<String> tipoCombustivel = [
  'Gasolina',
  'Etanol',
  'Flex',
  'Diesel',
  'GNV',
  'Elétrico',
];

List<String> proprietario = [
  'Prorietário',
  'Guincheiro',
  'Parente',
  'Motorista',
  'Outros',
];

class Photo extends StatefulWidget {
  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  List<File> _listImages = List();
  final _formKey = GlobalKey<FormState>();

  _selectionImage() async {
    File imageSelectcion =
        await ImagePicker.pickImage(source: ImageSource.camera);
    if (imageSelectcion != null) {
      setState(() {
        _listImages.add(imageSelectcion);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          maintainState: true,
          tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          title: Text('Adicionar fotos'),
          leading: Icon(Icons.subscriptions),
          children: [
            Column(
              children: [
                FormField<List>(
                  initialValue: _listImages,
                  validator: (images) {
                    if (images.length == 0) {
                      return 'Necessário adicionar imagens';
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
                            itemCount: _listImages.length + 1,
                            itemBuilder: (context, indice) {
                              if (indice == _listImages.length) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: GestureDetector(
                                    onTap: () {
                                      _selectionImage();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.add_a_photo,
                                            size: 40,
                                            color: Colors.grey[100],
                                          ),
                                          Text(
                                            'Adicionar',
                                            style: TextStyle(
                                              color: Colors.grey[100],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }

                              if (_listImages.length > 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Image.file(_listImages[indice]),
                                                FlatButton(
                                                  child: Text('Excluir'),
                                                  textColor: Colors.red,
                                                  onPressed: () {
                                                    setState(() {
                                                      _listImages
                                                          .removeAt(indice);
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                ),
                                              ]),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 50,
                                      backgroundImage:
                                          FileImage(_listImages[indice]),
                                      child: Container(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.4),
                                        alignment: Alignment.center,
                                        child: Icon(Icons.delete,
                                            color: Colors.red),
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
                              '${state.errorText}',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        Divider(color: Theme.of(context).primaryColor),
      ],
    );
  }
}

/*_selectImages() async {
  File imageSelected = await ImagePicker.pickImage(source: ImageSource.camera);
  if (imageSelected != null) {
    _listImages.add(imageSelected);
  }
}

_deleteImage() {}

Widget addPhoto(context) {
  return Column(
    children: [
      ExpansionTile(
        maintainState: true,
        tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        title: Text('Adicionar fotos'),
        leading: Icon(Icons.subscriptions),
        children: [
          Column(
            children: [
              FormField<List>(
                initialValue: _listImages,
                validator: (images) {
                  if (images.length == 0) {
                    return 'Mecessário adicionar imagens';
                  }
                  return null;
                },
                builder: (state) {
                  return Column(
                    children: [
                      Container(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listImages.length + 1,
                          itemBuilder: (context, indice) {
                            if (indice == _listImages.length) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    _selectImages();
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey[400],
                                    radius: 50,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                          color: Colors.grey[100],
                                        ),
                                        Text(
                                          'Adicionar',
                                          style: TextStyle(
                                            color: Colors.grey[100],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }

                            if (_listImages.length > 0) {
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: GestureDetector(
                                  onTap: () {
                                    _deleteImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        FileImage(_listImages[indice]),
                                    child: Container(
                                      color: Color.fromRGBO(255, 255, 255, 0.4),
                                      alignment: Alignment.center,
                                      child:
                                          Icon(Icons.delete, color: Colors.red),
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
                            '${state.errorText}',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
      Divider(color: Theme.of(context).primaryColor),
    ],
  );
}*/

Widget signatureController(
    context, _controllerSignature1, _controllerSignature2) {
  return Column(
    children: [
      ExpansionTile(
        maintainState: true,
        tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        title: Text('Assinaturas'),
        leading: Icon(Icons.subscriptions),
        children: [
          Text(
            'Assinatura do responsável pelo preenchimento',
          ),
          Signature(
            controller: _controllerSignature1,
            height: 250,
            backgroundColor: Colors.grey[300],
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black54),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _controllerSignature1.clear();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (_controllerSignature1.isNotEmpty) {
                      var data = await _controllerSignature1.toPngBytes();
                      return Scaffold(
                        body: Center(
                          child:
                              Container(height: 300, child: Image.memory(data)),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          Text(
            'Assinatura do proprietário ou responsável pelo veículo',
          ),
          Signature(
            controller: _controllerSignature2,
            height: 250,
            backgroundColor: Colors.grey[300],
          ),
          Container(
            decoration: const BoxDecoration(color: Colors.black54),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: const Icon(Icons.clear),
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    _controllerSignature2.clear();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.check),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    if (_controllerSignature2.isNotEmpty) {
                      var data = await _controllerSignature2.toPngBytes();
                      return Scaffold(
                        body: Center(
                          child:
                              Container(height: 300, child: Image.memory(data)),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

Widget checklistForm(
    context,
    _tyreController,
    _stepController,
    _rodasController,
    _marcaTyreController,
    _combustivelController,
    _typecombustivelController,
    _somController,
    _extintorController,
    _trianguloController,
    _chaverodaController,
    _macacoController,
    _antenaController,
    _vidroEletricoController,
    _farolController,
    _lanternatraseiraController,
    _crlvController,
    _observationController) {
  return Container(
    padding: EdgeInsets.all(6),
    child: Column(
      children: [
        ExpansionTile(
          maintainState: true,
          tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          title: Text('Checklist'),
          leading: Icon(Icons.list),
          children: [
            dropdowmField(context, _tyreController, 'Pneus', itensPneus),
            dropdowmField(context, _stepController, 'Step', itensPneus),
            dropdowmField(context, _rodasController, 'Rodas', items),
            dropdowmField(
                context, _marcaTyreController, 'Marca do pneu', marcaPneus),
            dropdowmField(context, _combustivelController, 'Tanque de gasolina',
                combustivel),
            dropdowmField(context, _typecombustivelController,
                'Tipo de combustível', tipoCombustivel),
            dropdowmField(context, _somController, 'Som', items),
            dropdowmField(context, _extintorController, 'Extintor', items),
            dropdowmField(context, _trianguloController, 'Triângulo', items),
            dropdowmField(
                context, _chaverodaController, 'Chave de roda', items),
            dropdowmField(context, _macacoController, 'Macaco', items),
            dropdowmField(context, _antenaController, 'Antena', antena),
            dropdowmField(context, _vidroEletricoController, 'Vidro Elétrico',
                simpleItem),
            dropdowmField(
                context, _farolController, 'Faróis dianteiros', items),
            dropdowmField(context, _lanternatraseiraController,
                'Lanternas traseiras', items),
            dropdowmField(
                context, _crlvController, 'Documento do veículo', simpleItem),
            Container(
              padding: EdgeInsets.all(6),
              child: TextFormField(
                controller: _observationController,
                decoration: InputDecoration(
                  labelText: 'Observações do checklist',
                  hintText: 'Digite aqui algumas observações do checklist',
                ),
                maxLines: null,
                // ignore: missing_return
                validator: (text) {
                  if (text.isEmpty) return 'Observação não pode ser vazia!';
                },
              ),
            ),
          ],
        ),
        Divider(color: Theme.of(context).primaryColor),
      ],
    ),
  );
}

Widget dropdowmField(context, controller, labelText, items) {
  return DropDownField(
    controller: controller,
    labelText: labelText,
    labelStyle: TextStyle(color: Theme.of(context).primaryColor),
    //hintText: 'Eccolha um ítem',
    enabled: true,
    items: items,
    onValueChanged: (value) {
      selectedText = value;
    },
  );
}

Widget clientForm(
  context,
  _nameController,
  _cpfController,
  _rgController,
  _addressController,
  _neighborhoodController,
  _cityController,
  _stateController,
  _zipCodeController,
  _phoneController,
  _emailController,
) {
  return Column(
    children: [
      ExpansionTile(
        maintainState: true,
        tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        title: Text('Dados do cliente'),
        leading: Icon(Icons.person),
        children: [
          Container(
            padding: EdgeInsets.all(6),
            child: Column(
              children: [
                textFormField(_nameController, 'Nome do cliente', (text) {
                  if (text.isEmpty) return 'Dado inválidos';
                }),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: textFormFieldWithKeyType(
                          _cpfController, 'CPF', TextInputType.number, (text) {
                        if (text.isEmpty ||
                            text.length < 11 ||
                            text.length > 11) return 'CPF inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: textFormFieldWithKeyType(
                          _rgController, 'RG', TextInputType.number, (text) {
                        if (text.isEmpty) return 'Dado inválido!';
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                textFormField(_addressController, 'Endereço', (text) {
                  if (text.isEmpty) return 'Dado inválidos';
                }),
                SizedBox(height: 4),
                textFormField(_neighborhoodController, 'Bairro', (text) {
                  if (text.isEmpty) return 'Dado inválido!';
                }),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: textFormField(_cityController, 'Cidade', (text) {
                        if (text.isEmpty) return 'Dado inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: textFormField(_stateController, 'UF', (text) {
                        if (text.isEmpty) return 'Dado inválido!';
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: textFormFieldWithKeyType(
                          _zipCodeController, 'CEP', TextInputType.number,
                          (text) {
                        if (text.isEmpty || text.length > 8 || text.length < 8)
                          return 'Dado inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: textFormFieldWithKeyType(_phoneController,
                          'Fone WhatsApp c/DDD', TextInputType.number, (text) {
                        if (text.isEmpty ||
                            text.length > 11 ||
                            text.length < 11)
                          return 'Dado inválido/ mínimo de 11 números';
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                textFormFieldWithKeyType(
                    _emailController, 'E-mail', TextInputType.emailAddress,
                    (text) {
                  if (text.isEmpty || !text.contains('@'))
                    return 'E-mail inválido!';
                }),
              ],
            ),
          ),
        ],
      ),
      Divider(color: Theme.of(context).primaryColor),
    ],
  );
}

Widget vehicleForm(
  context,
  _marcaController,
  _modelController,
  _yearModelController,
  _colorController,
  _chassisController,
  _codMotorController,
  _valvulasController,
  _cilinderController,
  _cilindradasController,
  _ansuranceController,
  _lightAnomaleController,
) {
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
                textFormField(_marcaController, 'Marca', (text) {
                  if (text.isEmpty) return 'Dado inválido!';
                }),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: textFormField(_modelController, 'Modelo', (text) {
                        if (text.isEmpty) return 'Dado inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: textFormFieldWithKeyType(_yearModelController,
                          'Ano/MOdelo', TextInputType.number, (text) {
                        if (text.isEmpty || text.length > 4 || text.length < 4)
                          return 'Ano/Modelo inválido!';
                      }),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: textFormField(_colorController, 'Cor', (text) {
                        if (text.isEmpty) return 'Dado inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child:
                          textFormField(_chassisController, 'Chassis', (text) {
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
                      child: textFormField(_codMotorController, 'Cód.Motor',
                          (text) {
                        if (text.isEmpty ||
                            text.length > 10 ||
                            text.length < 10) return 'Dado inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: textFormFieldWithKeyType(
                          _valvulasController, 'Válvulas', TextInputType.number,
                          (text) {
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
                      child: textFormFieldWithKeyType(_cilinderController,
                          'Cilindros', TextInputType.number, (text) {
                        if (text.isEmpty) return 'Dado inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: textFormField(
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
                      child:
                          textFormField(_ansuranceController, 'Seguro', (text) {
                        if (text.isEmpty) return 'Dado inválido!';
                      }),
                    ),
                    SizedBox(width: 4),
                    Expanded(
                      child: textFormField(
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

Widget textFormField(controller, labelText, validate) {
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

Widget textFormFieldWithKeyType(controller, labelText, textType, validate) {
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
