import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/input_customized.dart';
import 'package:flutter/material.dart';

class CardAfterServiceproved extends StatefulWidget {
  final Checklist _checklist;

  CardAfterServiceproved(this._checklist);

  @override
  _CardAfterServiceprovedState createState() =>
      _CardAfterServiceprovedState(_checklist);
}

class _CardAfterServiceprovedState extends State<CardAfterServiceproved> {
  final Checklist _checklist;

  _CardAfterServiceprovedState(this._checklist);

  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            InputCustomized(
              hint: 'Peças fornecidas pelo cliente',
              label: 'Peças fornecidas pelo cliente',
              inputBorder: border,
              onSaved: (parts) {
                _checklist.parts = parts;
              },
            ),
            SizedBox(height: 4),
            InputCustomized(
              hint: 'Serviços executados',
              label: 'Serviços executados',
              inputBorder: border,
              onSaved: (servicePerformed) {
                _checklist.servicePerformed = servicePerformed;
              },
            ),
            SizedBox(height: 4),
            InputCustomized(
              hint: 'Mecânico',
              label: 'Mecânico',
              inputBorder: border,
              onSaved: (mechanic){
                _checklist.mechanic = mechanic;
              },
            ),
          ],
        ),
      ),
    );
  }
}
