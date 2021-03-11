import 'package:flutter/material.dart';

class Forms{

  final Forms forms;

  Forms(this.forms);

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

}
