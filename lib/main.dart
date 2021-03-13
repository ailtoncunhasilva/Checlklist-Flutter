import 'package:auto_checklist/models/user_model.dart';
import 'package:auto_checklist/screens/checklist_screen2.dart';
import 'package:auto_checklist/screens/login_screen.dart';
import 'package:auto_checklist/screens/meuschecklist_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.lightBlue[700],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return Container(
            padding: EdgeInsets.only(top: 18, right: 18, left: 18),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Olá, ${!model.isLoggedIn() ? '' : model.userData['name']}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 18,
                      ),
                    ),
                    Image.asset('images/logopng.png'),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onPressed: () {
                          if (model.isLoggedIn()) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ChecklistScreen2(),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Checklist',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: RaisedButton(
                        color: Colors.grey[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        onPressed: () {
                          if (model.isLoggedIn()) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MeusChecklistScreen(),
                              ),
                            );
                          } else {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          }
                        },
                        child: Text(
                          'Meus Checklists',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    FlatButton(
                      onPressed: () {
                        model.signOut();
                        if (!model.isLoggedIn()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => HomePage()));
                        }
                      },
                      child: Text(
                        !model.isLoggedIn() ? 'Entre ou cadastre-se' : 'Sair',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
