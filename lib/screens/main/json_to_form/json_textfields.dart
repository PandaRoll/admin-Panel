import 'package:flutter/material.dart';

import 'functions.dart';
class JsonTextField extends StatefulWidget {
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final InputDecoration decorations;
  final Map keyboardTypes;
  JsonTextField({
    Key? key,
    required this.item,
    required this.onChange,
    required this.position,
    this.errorMessages = const {},
    this.validations = const {},
    required this.decorations,
    this.keyboardTypes = const {},
  }) : super(key: key);

  @override
  _JsonTextField createState() => new _JsonTextField();
}

class _JsonTextField extends State<JsonTextField> {
  dynamic item;

  @override
  Widget build(BuildContext context) {
    Widget label = SizedBox.shrink();
    if (Fun.labelHidden(item)) {
      label = new Container(
        child: new Text(
          item['label'] ?? "",
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
    }
    return Card(
      elevation: 2,
      child: new Container(
        margin: new EdgeInsets.only(top: 5.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new TextFormField(
              controller: null,
              initialValue: item['value'] ?? null,
              decoration:
                  InputDecoration(isCollapsed: true, border: InputBorder.none),
              //  item['decoration'] ??
              //     widget.decorations[item['key']] ??
              //     new InputDecoration(
              //       hintText: item['placeholder'] ?? "",
              //       helperText: item['helpText'] ?? "",
              //     ),
              maxLines: item['type'] == "TextArea" ? 10 : 1,
              onChanged: (String value) {
                item['value'] = value;
                // _handleChanged();
                //  print(value);
                widget.onChange(widget.position, value);
              },
              obscureText: item['type'] == "Password" ? true : false,
              keyboardType: item['keyboardType'] ??
                  widget.keyboardTypes[item['key']] ??
                  TextInputType.text,
              validator: (value) {
                if (widget.validations.containsKey(item['key'])) {
                  return widget.validations[item['key']](item, value);
                }
                if (item.containsKey('validator')) {
                  if (item['validator'] != null) {
                    if (item['validator'] is Function) {
                      return item['validator'](item, value);
                    }
                  }
                }
                if (item['type'] == "Email") {
                  return Fun.validateEmail(item, value!);
                }

                if (item.containsKey('required')) {
                  if (item['required'] == true ||
                      item['required'] == 'True' ||
                      item['required'] == 'true') {
                    return isRequired(item, value);
                  }
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  String? isRequired(item, value) {
    if (value.isEmpty) {
      return widget.errorMessages[item['key']] ?? 'Please enter some text';
    }
    return null;
  }
}
