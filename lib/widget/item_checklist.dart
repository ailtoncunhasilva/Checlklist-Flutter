import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/screens/pdf_new.dart';
import 'package:flutter/material.dart';

class ItemChecklist extends StatelessWidget {
  final Checklist checklist;
  final VoidCallback onTapItem;
  final VoidCallback onPressedRemove;

  ItemChecklist({
    @required this.checklist,
    this.onTapItem,
    this.onPressedRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  checklist.photos[0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                flex: 3,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            checklist.marca,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            checklist.placa,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            checklist.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (this.onPressedRemove != null)
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        color: Colors.red,
                        onPressed: this.onPressedRemove,
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          //final bytes = await Utils.capture(key);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MyPdf(checklist)),
                          );
                          /*Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => ShareImage(checklist))
                          );*/
                        },
                        child: Text(
                          'PDF',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
