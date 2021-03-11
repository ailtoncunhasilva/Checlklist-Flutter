import 'dart:async';

import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/item_checklist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MeusChecklistScreen extends StatefulWidget {
  @override
  _MeusChecklistScreenState createState() => _MeusChecklistScreenState();
}

class _MeusChecklistScreenState extends State<MeusChecklistScreen> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  String _idUserLogged;

  _dataUserLogged() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseUser userLogged = await auth.currentUser();
    _idUserLogged = userLogged.uid;
  }

  Future<Stream<QuerySnapshot>> _addListenerChecklist() async {
    await _dataUserLogged();

    Firestore db = Firestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection('meus_checklists')
        .document(_idUserLogged)
        .collection('checklists')
        .snapshots();

    stream.listen((data) {
      _controller.add(data);
    });
  }

  _removeChecklist(String idChecklist) {
    Firestore.instance
        .collection('meus_checklists')
        .document(_idUserLogged)
        .collection('checklists')
        .document(idChecklist)
        .delete();
  }

  @override
  void initState() {
    super.initState();
    _addListenerChecklist();
  }

  @override
  Widget build(BuildContext context) {
    var carregandoDados = Center(
      child: Column(
        children: [
          Text('Carregando Checklists'),
          CircularProgressIndicator(),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Checklists'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return carregandoDados;
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Erro ao carregar dados!');
              QuerySnapshot querySnapshot = snapshot.data;
              return ListView.builder(
                itemCount: querySnapshot.documents.length,
                itemBuilder: (_, index) {
                  List<DocumentSnapshot> checklists =
                      querySnapshot.documents.toList();
                  DocumentSnapshot documentSnapshot = checklists[index];
                  Checklist checklist =
                      Checklist.fromDocumentSnapshot(documentSnapshot);
                  return ItemChecklist(
                    checklist: checklist,
                    onPressedRemove: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirmar'),
                              content:
                                  Text('Deseja realmente excluir o checklist?'),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Cancelar',
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                FlatButton(
                                  color: Colors.red,
                                  onPressed: () {
                                    _removeChecklist(checklist.id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Remover',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          });
                    },
                  );
                },
              );
          }
          return Container();
        },
      ),
    );
  }
}
