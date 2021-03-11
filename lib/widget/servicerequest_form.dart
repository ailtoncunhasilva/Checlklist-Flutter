import 'package:flutter/material.dart';

class ServiceRequestForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          ExpansionTile(
            maintainState: true,
            tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            title: Text('Serviçoes solicitados(inspeção/manutenção/reparação)'),
            leading: Icon(Icons.build),
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Digite os servições solicitados',
                  ),
                  maxLines: null,
                ),
              ),
            ],
          ),
          Divider(color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}
