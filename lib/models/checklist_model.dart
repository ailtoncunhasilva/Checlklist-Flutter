import 'package:auto_checklist/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ChecklistModel extends Model {
  UserModel user;

  //List<ChecklistData> itens = [];

  ChecklistModel(this.user);

  String value = '';

  Map<String, dynamic> checklistData = Map();

  bool isLoading = false;

  FirebaseUser firebaseUser;

  static ChecklistModel of(BuildContext context) =>
      ScopedModel.of<ChecklistModel>(context);

  /*void addChecklistItem(ChecklistData checklistData) {
    itens.add(checklistData);

    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('oschecklist')
        .add(checklistData.toMap())
        .then((doc) {
      checklistData.cid = doc.documentID;
    });

    notifyListeners();
  }

  void removeChecklistItem(ChecklistData checklistData) {
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('oscheklist')
        .document(checklistData.cid)
        .delete();

    itens.remove(checklistData);
    notifyListeners();
  }*/

  void includChecklist(Map<String, dynamic> checklistData) {
    isLoading = true;
    notifyListeners();

    isLoading = false;
    notifyListeners();
  }

  void saveChecklist({Map<String, dynamic> checklistData}) {
    this.checklistData = checklistData;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('OS')
        .document()
        .setData(checklistData);
  }

  void removedChecklist(Map<String, dynamic> checklistData) {
    this.checklistData = checklistData;
    Firestore.instance
        .collection('users')
        .document(user.firebaseUser.uid)
        .collection('OS')
        .document()
        .delete();

    notifyListeners();
  }

  /*Future<String> finishChecklist()async{
    if(checklistData.length == 0) return null;

    isLoading = true;
    notifyListeners();

    DocumentReference refChecklist = await Firestore.instance.collection('os').add({
      'clientId': user.firebaseUser.uid,
      'checklistData': checklistData,
    });
  }*/
  Widget clientForm1(
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
                            _cpfController, 'CPF', TextInputType.number,
                            (text) {
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
                          if (text.isEmpty ||
                              text.length > 8 ||
                              text.length < 8) return 'Dado inválido!';
                        }),
                      ),
                      SizedBox(width: 4),
                      Expanded(
                        child: textFormFieldWithKeyType(
                            _phoneController,
                            'Fone WhatsApp c/DDD',
                            TextInputType.number, (text) {
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

  Widget dropDowm() {
    return Row(
      children: [
        Text('item'),
        DropdownButton<String>(
          items: [
            DropdownMenuItem<String>(
              value: '1',
              child: Center(child: Text('Danificado')),
            ),
            DropdownMenuItem<String>(
              value: '2',
              child: Center(child: Text('Ok')),
            ),
            DropdownMenuItem<String>(
              value: '3',
              child: Center(child: Text('Inexistente')),
            ),
          ],
          onChanged: (_value) => {
            print(_value.toString()),
            value = _value,
          },
          hint: Text('Pára brisa'),
        ),
      ],
    );
  }
}
