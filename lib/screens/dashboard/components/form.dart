import 'dart:convert';

import 'package:admin/screens/main/json_to_form/json_to_form.dart';
import 'package:flutter/material.dart';

class AllFieldsV1 extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  AllFieldsV1({Key? key, required this.title}) : super(key: key);

  @override
  _AllFieldsV1 createState() => new _AllFieldsV1();
}

class _AllFieldsV1 extends State<AllFieldsV1> {
  String sendEmailForm = json.encode([
    {'type': 'Input', 'title': 'Subject', 'placeholder': "Subject"},
    {'type': 'TareaText', 'title': 'Message', 'placeholder': "Content"},
  ]);
  String form = json.encode([
    {
      'key': 1,
      'type': 'Input',
      'title': 'Username',
      'label': 'Username',
      'placeholder': "Enter Your Username",
      'required': true
    },
    {
      'key': 2,
      'type': 'Password',
      'title': 'Password',
      'label': 'Password',
      'required': true
    },
    {
      'type': 'Input',
      'title': 'Hi Group',
      'placeholder': "Hi Group flutter",
      'validator': 'digitsOnly'
    },
    {'type': 'Email', 'title': 'Email test', 'placeholder': "hola a todos"},
    {
      'type': 'RadioButton',
      'title': 'Radio Button tests',
      'value': 2,
      'list': [
        {
          'title': "product 1",
          'value': 1,
        },
        {
          'title': "product 2",
          'value': 2,
        },
        {
          'title': "product 3",
          'value': 3,
        }
      ]
    },
    {
      'type': 'TareaText',
      'title': 'TareaText test',
      'placeholder': "hola a todos"
    },
    {
      'type': 'Switch',
      'title': 'Online',
      'switchValue': false,
    },
    {
      'type': 'Checkbox',
      'title': 'Checkbox test',
      'list': [
        {
          'title': "product 1",
          'value': true,
        },
        {
          'title': "product 2",
          'value': false,
        },
        {
          'title': "product 3",
          'value': false,
        }
      ]
    },
    {
      'type': 'Checkbox',
      'title': 'Checkbox test 2',
      'list': [
        {
          'title': "product 1",
          'value': true,
        },
        {
          'title': "product 2",
          'value': true,
        },
        {
          'title': "product 3",
          'value': false,
        }
      ]
    },
    {
      'key': 'date',
      'type': 'Date',
      'label': 'date',
      'required': true,
    },
    {
      'key': 'select1',
      'type': 'Select',
      'label': 'Select test',
      'value': 'product 1',
      'items': [
        {
          'label': "product 1",
          'value': "product 1",
        },
        {
          'label': "product 2",
          'value': "product 2",
        },
        {
          'label': "product 3",
          'value': "product 3",
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
        title: new Text("All Fields V1"),
      ),
      body: new SingleChildScrollView(
        child: new Container(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: new Column(children: <Widget>[
            new CoreForm(
              form: form,
              onChanged: (dynamic response) {
                this.response = response;
              },
            ),
            new ElevatedButton(
                child: new Text('Send'),
                onPressed: () {
                  print(this.response.toString());
                  
                }),
          ]),
        ),
      ),
    );
  }
}
