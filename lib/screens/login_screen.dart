import 'package:auto_checklist/models/user_model.dart';
import 'package:auto_checklist/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final TextStyle style = TextStyle(
      color: Colors.white,
      fontSize: 16,
    );

    final Color color = Theme.of(context).primaryColor;

    final ShapeBorder shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Entre ou cadastre-se',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      key: _scaffoldKey,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            height: MediaQuery.of(context).size.height * 0.30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/logotipopng.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ScopedModelDescendant<UserModel>(
            builder: (context, child, model) {
              if (model.isLoading)
                return Center(
                  child: CircularProgressIndicator(),
                );

              return Form(
                key: _formKey,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            labelText: 'Digite seu E-mail',
                            isDense: true,
                          ),
                          // ignore: missing_return
                          validator: (text) {
                            if (text.isEmpty || !text.contains('@'))
                              return 'E-mail inválido!';
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: _passController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            labelText: 'Digite sua senha',
                            isDense: true,
                          ),
                          // ignore: missing_return
                          validator: (text) {
                            if (text.isEmpty || text.length < 6)
                              return 'Senha deve ter no mínimo 6 digitos';
                          },
                          obscureText: true,
                          keyboardType: TextInputType.number,
                        ),
                        Divider(color: color),
                        Align(
                          alignment: Alignment.topRight,
                          child: FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Cadastre-se',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: color,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 1.0,
                          child: RaisedButton(
                            color: color,
                            shape: shape,
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                              model.signIn(
                                email: _emailController.text,
                                pass: _passController.text,
                                onSuccess: _onSuccess,
                                onFail: _onFail,
                              );
                            },
                            child: Text(
                              'Entrar',
                              style: style,
                            ),
                          ),
                        ),
                        Divider(color: color),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.only(top: 24),
                            child: Text(
                              'ACmobile',
                              style: TextStyle(
                                color: color,
                              ),
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
        ],
      ),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Falha ao fazer login',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
