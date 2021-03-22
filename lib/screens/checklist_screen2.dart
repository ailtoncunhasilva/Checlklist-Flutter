import 'dart:io';

import 'package:auto_checklist/card.itens/card_client.dart';
import 'package:auto_checklist/card.itens/card_datapay.dart';
import 'package:auto_checklist/card.itens/card_service_aproved.dart';
import 'package:auto_checklist/card.itens/card_vehicle.dart';
import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/models/user_model.dart';
import 'package:auto_checklist/screens/meuschecklist_screen.dart';
import 'package:auto_checklist/widget/input_customized.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

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

  Checklist _checklist;
  BuildContext _dialogContext;

  @override
  void initState() {
    super.initState();

    _checklist = Checklist.gerarID();
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
        title: Text('CHECKLIST DIGITAL'),
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
                      containerText('Dados do cliente'),
                      Column(
                        children: [
                          CardClient(_checklist),
                          containerText('Outros dados'),
                          DataPay(_checklist),
                          containerText('Dados do veículo'),
                          CardVehicle(_checklist),
                          containerText('Fotos do checklist'),
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
                                          image.length < 10) {
                                        return 'Necessário 10 fotos';
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
                                    label: 'Descrição de problemas e observações',
                                    hint: 'Descrição de problemas e observações',
                                    onSaved: (observation) {
                                      _checklist.observation = observation;
                                    },
                                    maxLines: null,
                                    inputBorder: borderForm,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          containerText('Apos aprovação do serviço'),
                          CardAfterServiceproved(_checklist),
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

Widget containerText(text) {
  return Container(
    height: 30,
    child: Center(
        child: Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    )),
  );
}
