import 'dart:convert';

import 'package:admin/screens/dashboard/components/json_to_widgets.dart';
import 'package:flutter/material.dart';

class UI extends StatefulWidget {
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("UI"),
      ),
      body: new SizedBox(
        child: new Column(children: [CoreUiTranslator(form: form)]),
      ),
    );
  }
}
