import 'package:flutter/material.dart';

class BudgetForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          ExpansionTile(
            maintainState: true,
            tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            title: Text('Orçamento'),
            leading: Icon(Icons.monetization_on),
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Digite o orçamento',
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
