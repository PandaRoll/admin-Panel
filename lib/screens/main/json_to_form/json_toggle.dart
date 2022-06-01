import 'package:flutter/material.dart';

class JsonToggle extends StatefulWidget {
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;
  JsonToggle({
    Key? key,
    required this.item,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
  }) : super(key: key);

  @override
  _JsonToggle createState() => new _JsonToggle();
}

class _JsonToggle extends State<JsonToggle> {
  dynamic item;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Row(children: <Widget>[
        new Expanded(child: new Text(item['label'])),
        new Switch(
          value: item['value'] ?? false,
          onChanged: (bool value) {
            this.setState(() {
              item['value'] = value;
              widget.onChange(widget.position, value);
            });
          },
        ),
      ]),
    );
  }

  @override
  void initState() {
    super.initState();
    item = widget.item;
    if (item['value'] == null) {
      item['value'] = false;
    }
  }

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }
}
