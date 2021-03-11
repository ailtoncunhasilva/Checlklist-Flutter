import 'dart:async';
import 'dart:typed_data';

import 'package:auto_checklist/models/checklistmodel.dart';
import 'package:auto_checklist/widget/widget_to_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShareImage extends StatefulWidget {
  final Checklist checklist;

  ShareImage(this.checklist);
  @override
  _ShareImageState createState() => _ShareImageState(checklist);
}

class _ShareImageState extends State<ShareImage> {
  // ignore: close_sinks
  final _controller = StreamController<QuerySnapshot>.broadcast();

  final Checklist checklist;

  _ShareImageState(this.checklist);

  GlobalKey key;
  Uint8List bytes;

  Widget buildImage(bytes){
    if(bytes != null) return Image.memory(bytes);

    Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share Image'),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data.document.length,
              itemBuilder: (_, index) {
                return WidgetToImage(
                  builder: (key) {
                    this.key = key;
                    Card(
                      margin: EdgeInsets.all(6),
                      child: buildImage(bytes),/*Column(
                        children: [
                          Text(checklist.id),
                          Image.network(checklist.photos[0]),
                          buildImage(bytes),
                        ],
                      ),*/
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
