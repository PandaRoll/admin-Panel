library json_to_form;

import 'dart:convert';

import 'package:admin/screens/main/json_to_form/components/json_textfields.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import 'components/json_date.dart';
import 'components/json_dropdown.dart';

class CoreForm extends StatefulWidget {
  final String form;
  final dynamic formMap;
  final EdgeInsets? padding;
  final String? labelText;
  final ValueChanged<dynamic> onChanged;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? errorBorder;
  final OutlineInputBorder? disabledBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final OutlineInputBorder? focusedBorder;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;
  const CoreForm({
    required this.form,
    required this.onChanged,
    this.labelText,
    this.padding,
    this.formMap,
    this.enabledBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.errorMessages = const {},
    this.validations = const {},
    this.decorations = const {},
    this.keyboardTypes = const {},
  });

  @override
  _CoreFormState createState() =>
      new _CoreFormState(formMap ?? json.decode(form));
}

class _CoreFormState extends State<CoreForm> {
  final dynamic formItems;

  int radioValue = -1;

  _CoreFormState(this.formItems);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: widget.padding ?? EdgeInsets.all(8),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: jsonToForm(),
      ),
    );
  }

  List<Widget> jsonToForm() {
    List<Widget> listWidget = [];

    for (var item in formItems) {
      if (item['type'] == "Input" ||
          item['type'] == "Password" ||
          item['type'] == "Email" ||
          item['type'] == "TareaText") {
        listWidget.add(new Container(
            padding: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(
              item['title'],
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            )));
        listWidget.add(SizedBox(
            width: SizeConfig.widthMultiplier * 95,
            height: SizeConfig.widthMultiplier * 15,
            child: JsonTextField(
              item: item,
              onChange: onChange,
              position: 0,
              decorations: InputDecoration(border: InputBorder.none),
            )));
      }
      if (item['type'] == "Select") {
        listWidget.add(new JsonDropDown(
          item: item,
          onChange: onChange,
          position: formItems.indexOf(item),
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

      if (item['type'] == "Date") {
        listWidget.add(new JsonDate(
          item: item,
          onChange: onChange,
          position: formItems.indexOf(item),
          decorations: widget.decorations,
          errorMessages: widget.errorMessages,
          validations: widget.validations,
          keyboardTypes: widget.keyboardTypes,
        ));
      }

      if (item['type'] == "RadioButton") {
        listWidget.add(new Container(
            margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(item['title'],
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0))));
        radioValue = item['value'];
        for (var i = 0; i < item['list'].length; i++) {
          listWidget.add(
            new Row(
              children: <Widget>[
                new Expanded(child: new Text(item['list'][i]['title'])),
                new Radio<int>(
                    value: item['list'][i]['value'],
                    groupValue: radioValue,
                    onChanged: (value) {
                      this.setState(() {
                        radioValue = value!;
                        item['value'] = value;
                        _handleChanged();
                      });
                    })
              ],
            ),
          );
        }
      }

      if (item['type'] == "Switch") {
        listWidget.add(
          new Row(children: <Widget>[
            new Expanded(child: new Text(item['title'])),
            new Switch( 
                value: item['switchValue'],
                onChanged: (bool value) {
                  this.setState(() {
                    item['switchValue'] = value;
                    _handleChanged();
                  });
                })
          ]),
        );
      }

      if (item['type'] == "Checkbox") {
        listWidget.add(new Container(
            margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(item['title'],
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0))));
        for (var i = 0; i < item['list'].length; i++) {
          listWidget.add(
            new Row(
              children: <Widget>[
                new Expanded(child: new Text(item['list'][i]['title'])),
                new Checkbox(
                    value: item['list'][i]['value'],
                    onChanged: (value) {
                      this.setState(() {
                        item['list'][i]['value'] = value;
                        _handleChanged();
                      });
                    })
              ],
            ),
          );
        }
      }
    }
    return listWidget;
  }

  void onChange(int position, dynamic value) {
    this.setState(() {
      formItems[position]['value'] = value;
      _handleChanged();
    });
  }

  void _handleChanged() {
    widget.onChanged(formItems);
  }
}
