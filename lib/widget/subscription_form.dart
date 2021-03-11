import 'package:flutter/material.dart';
import 'package:signature/signature.dart';

/*class SubscriptionForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          ExpansionTile(
            maintainState: true,
            tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            title: Text('Assinaturas'),
            leading: Icon(Icons.subscriptions),
          ),
          Divider(color: Theme.of(context).primaryColor),
        ],
      ),
    );
  }
}*/

class SubscriptionForm extends StatefulWidget {
  @override
  _SubscriptionFormState createState() => _SubscriptionFormState();
}

class _SubscriptionFormState extends State<SubscriptionForm> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          maintainState: true,
          tilePadding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          title: Text('Assinaturas'),
          leading: Icon(Icons.subscriptions),
          children: [
            Text(
              'Assinatura do responsável pelo preenchimento',
            ),
            Signature(
              controller: _controller,
              height: 300,
              backgroundColor: Colors.lightBlueAccent,
            ),
            Container(
              decoration: const BoxDecoration(color: Colors.black),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.check),
                        color: Theme.of(context).primaryColor,
                        onPressed: () async {
                          if (_controller.isNotEmpty) {
                            var data = await _controller.toPngBytes();
                            return Scaffold(
                              body: Center(
                                child: Container(
                                  height: 300,
                                  child: Image.memory(data),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                      /*Text(
                        'Limpar assinatura',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),*/
                      IconButton(
                        icon: const Icon(Icons.clear),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          _controller.clear();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /*MaterialApp(
              home: Builder(
                builder: (context) => Scaffold(
                  body: ListView(
                    children: [
                      Container(
                        height: 300,
                        child: Center(
                          child: Text('Big container to test scrolling issues'),
                        ),
                      ),
                      Signature(
                        controller: _controller,
                        height: 300,
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                      Container(
                        decoration: const BoxDecoration(color: Colors.black),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check),
                              color: Theme.of(context).primaryColor,
                              onPressed: () async {
                                if (_controller.isNotEmpty) {
                                  var data = await _controller.toPngBytes();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Scaffold(
                                      appBar: AppBar(),
                                      body: Center(
                                        child: Container(
                                            color: Colors.grey[300],
                                            child: Image.memory(data)),
                                      ),
                                    );
                                  }));
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.clear),
                              color: Theme.of(context).primaryColor,
                              onPressed: (){
                                setState(() {
                                  _controller.clear();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        child: Center(
                          child: Text('Big container to test scrolling issues'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ],
    );
  }
}
