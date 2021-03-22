import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/input_customized.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: InputCustomized(
                    inputBorder: border,
                    hint: 'Data/Início do serviço',
                    label: 'Data/Início do serviço',
                    inputType: TextInputType.datetime,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    onSaved: (dateInitService) {
                      _checklist.dateInitService = dateInitService;
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 4, top: 4),
                    child: InputCustomized(
                      inputBorder: border,
                      hint: 'Hora/Início do serviço',
                      label: 'Hora/Início do serviço',
                      inputType: TextInputType.datetime,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        HoraInputFormatter(),
                      ],
                      onSaved: (hourInitService) {
                        _checklist.hourInitService = hourInitService;
                      },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: InputCustomized(
                    inputBorder: border,
                    hint: 'Data/Término do serviço',
                    label: 'Data/Término do serviço',
                    inputType: TextInputType.datetime,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      DataInputFormatter(),
                    ],
                    onSaved: (dateEndService) {
                      _checklist.dateEndService= dateEndService;
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 4, top: 4),
                    child: InputCustomized(
                      inputBorder: border,
                      hint: 'Hora/Término do serviço',
                      label: 'Hora/Término do serviço',
                      inputType: TextInputType.datetime,
                      inputFormatter: [
                        FilteringTextInputFormatter.digitsOnly,
                        HoraInputFormatter(),
                      ],
                      onSaved: (hourEndService) {
                        _checklist.hourEndService = hourEndService;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
