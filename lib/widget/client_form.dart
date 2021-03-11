import 'package:flutter/material.dart';

class ClientForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Divider divider = Divider(
      color: Theme.of(context).primaryColor,
    );

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

    //final formKey = GlobalKey<FormState>();

    return /*Form(
      key: formKey,
      child:*/ Column(
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
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        isDense: true,
                        labelText: 'Nome do cliente',
                      ),
                      keyboardType: TextInputType.name,
                      // ignore: missing_return
                      validator: (text){
                        if(text.isEmpty) return 'Digite um nome';
                      },
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.55,
                          child: TextFormField(
                            controller: _cpfController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                              labelText: 'CPF',
                            ),
                            keyboardType: TextInputType.number,
                            // ignore: missing_return
                            validator: (text){
                              if(text.isEmpty || text.length < 11 || text.length > 11) return 'CPF inválido!';
                            },
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: TextFormField(
                            controller: _rgController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                              labelText: 'RG',
                            ),
                            keyboardType: TextInputType.number,
                            // ignore: missing_return
                            validator: (text){
                              if(text.isEmpty) return 'RG inválido!';
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        isDense: true,
                        labelText: 'Endereço',
                      ),
                      // ignore: missing_return
                      validator: (text){
                        if(text.isEmpty) return 'Endereço inválido!';
                      },
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _neighborhoodController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        isDense: true,
                        labelText: 'Bairro',
                      ),
                      // ignore: missing_return
                      validator: (text){
                        if(text.isEmpty) return 'Bairro inválido!';
                      },
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: TextFormField(
                            controller: _cityController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                              labelText: 'Cidade',
                            ),
                            // ignore: missing_return
                            validator: (text){
                              if(text.isEmpty) return 'Cidade inválida!';
                            },
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: TextFormField(
                            controller: _stateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                              labelText: 'UF',
                            ),
                            // ignore: missing_return
                            validator: (text){
                              if(text.isEmpty) return 'UF inválido!';
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: TextFormField(
                            controller: _zipCodeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                              labelText: 'CEP',
                            ),
                            keyboardType: TextInputType.number,
                            // ignore: missing_return
                            validator: (text){
                              if(text.isEmpty || text.length < 8 || text.length > 8) return 'CEP inválido!';
                            },
                          ),
                        ),
                        SizedBox(width: 4),
                        Expanded(
                          child: TextFormField(
                            controller: _phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                              labelText: 'Fone WhatsApp c/DDD',
                            ),
                            keyboardType: TextInputType.number,
                            // ignore: missing_return
                            validator: (text){
                              if(text.isEmpty || text.length < 11 || text.length > 11) return 'Fone inválido!\nmínimo de 11 números';
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        isDense: true,
                        labelText: 'E-mail@',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      // ignore: missing_return
                      validator: (text){
                        if(text.isEmpty || !text.contains('@')) return 'E-mail inválido!';
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          divider,
        ],
      );
    //);
  }
}
