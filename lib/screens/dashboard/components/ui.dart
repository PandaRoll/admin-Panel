import 'dart:convert';

import 'package:admin/screens/dashboard/components/json_to_ui.dart';
import 'package:flutter/material.dart';

class UI extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  UI({Key? key, required this.title}) : super(key: key);

  @override
  _UI createState() => new _UI();
}

class _UI extends State<UI> {
  String form = json.encode([
    {
      'type': 'Card',
      'children': [
        {
          'title': 'Executed Amount',
          'value': '₹278956',
          // 'icon': 'https://cdn-icons-png.flaticon.com/512/4549/4549880.png',
          // 'subtitle': 'Ociuz Infotech'
        },
        {
          'title': 'Debit Amount',
          'value': '₹278789',
          // 'icon': 'https://cdn-icons-png.flaticon.com/512/4549/4549881.png',
          'subtitle': 'Amount of debit'
        },
        {
          'title': 'Credit Amount',
          'value': '₹678956',
          // 'icon': 'https://cdn-icons-png.flaticon.com/512/4549/4549880.png',
          'subtitle': 'Credits received'
        },
        {
          'title': 'Sales Amount',
          'value': '₹568956',
          // 'icon': 'https://cdn-icons-png.flaticon.com/512/4549/4549881.png',
          'subtitle': 'Sales for the year'
        }
      ]
    },
  ]);
  dynamic response;
  // Map decorations = {
  //   1: InputDecoration(
  //     prefixIcon: Icon(Icons.account_box),
  //     border: OutlineInputBorder(),
  //   ),
  //   2: InputDecoration(
  //       prefixIcon: Icon(Icons.security), border: OutlineInputBorder()),
  // };
  @override
  Widget build(BuildContext context) {
    print(form);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("UI"),
      ),
      body: new SizedBox(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(children: [CoreUiTranslator(form: form)]),
      ),
    );
  }
}
