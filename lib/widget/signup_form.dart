import 'package:auto_checklist/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(
      builder: (context, child, model) {
        if (model.isLoading)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nome do usuário',
                  ),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty) return 'Um nome é requerido';
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                  ),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || !text.contains('@'))
                      return 'E-mail inválido!';
                  },
                ),
                TextFormField(
                  controller: _passController,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                  ),
                  obscureText: true,
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 6)
                      return 'Senha inválida!';
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Telefone com DDD',
                  ),
                  // ignore: missing_return
                  validator: (text) {
                    if (text.isEmpty || text.length < 11)
                      return 'Telefone inválido! Mínimo de 11 digitos';
                  },
                ),
                SizedBox(height: 8),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 1.0,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        Map<String, dynamic> userData = {
                          'name': _nameController.text,
                          'email': _emailController.text,
                          'phone': _phoneController.text,
                        };

                        model.signUp(
                          userData: userData,
                          pass: _passController.text,
                          onSuccess: _onSuccess,
                          onFail: _onFail,
                        );
                      }
                    },
                    child: Text('Efetuar Cadastro'),
                    textColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onSuccess() {}

  void _onFail() {}
}

/*Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.only(right: 10, left: 10, bottom: 2),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'DADOS DO VEÍCULO',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.directions_car),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Fabricante:',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty) return 'Digite o nome fabricante';
                    },
                    keyboardType: TextInputType.text,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Modelo:',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      // ignore: missing_return
                      validator: (text) {
                        if (text.isEmpty) return 'Digite o modelo do veículo';
                      },
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Ano/Modelo:',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length > 4 || text.length < 4)
                        return 'Ano inválido';
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cor predominante:',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      // ignore: missing_return
                      validator: (text) {
                        if (text.isEmpty) return 'Digite a cor do veículo';
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Chassis:',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length > 17 || text.length < 17)
                        return 'Chassis inválido!';
                    },
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cód.Motor:',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      // ignore: missing_return
                      validator: (text) {
                        if (text.isEmpty || text.length > 9 || text.length < 9)
                          return 'Código inválido!';
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Válvulas:',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length > 1 || text.length < 1)
                        return 'Válvula inválida!';
                    },
                  ),
                ),
                SizedBox(width: 4),
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cilindros:',
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length > 1 || text.length < 1)
                        return 'Cilindro inválido!';
                    },
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Container(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Cilindradas:',
                        border: const OutlineInputBorder(),
                        isDense: true,
                      ),
                      // ignore: missing_return
                      validator: (text) {
                        if (text.isEmpty || text.length > 3 || text.length < 3)
                          return 'Cilindrada inválida!';
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'DADOS DO CLIENTE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(Icons.person),
                ],
              ),
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Nome do cliente: ',
                isDense: true,
              ),
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty) return 'Digite o nome do cliente';
              },
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'CPF: ',
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 11 || text.length > 11)
                        return 'CPF inválido!';
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'RG: ',
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty) return 'RG inválido!';
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Endereço: ',
                isDense: true,
              ),
              maxLines: null,
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty) return 'Digite o endereço';
              },
            ),
            SizedBox(height: 4),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Bairro: ',
                isDense: true,
              ),
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty) return 'Digite o bairro';
              },
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Cidade/Estado: ',
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty) return 'Digite a cidade e o estado';
                    },
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'CEP: ',
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 8 || text.length > 8)
                        return 'CEP inválido!';
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Telefone com DDD: ',
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 10 || text.length > 10)
                        return 'Telefone inválido!';
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(width: 4),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Celular/Whatsapp: ',
                      isDense: true,
                    ),
                    // ignore: missing_return
                    validator: (text) {
                      if (text.isEmpty || text.length < 11 || text.length > 11)
                        return 'Telefone inválido!';
                    },
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'E-mail: ',
                isDense: true,
              ),
              // ignore: missing_return
              validator: (text) {
                if (text.isEmpty || !text.contains('@'))
                  return 'E-mail inválido!';
              },
            ),
            SizedBox(height: 6),
            RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                if(_formKey.currentState.validate()){

                }
              },
              child: Text('CADASTRAR'),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );*/
//}

//}


