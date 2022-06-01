import 'dart:convert';

import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../main/json_to_form/index.dart';

class DynamicFilterWidget extends StatefulWidget {
  final dynamic data_json;
  const DynamicFilterWidget({required this.data_json, Key? key})
      : super(key: key);

  @override
  State<DynamicFilterWidget> createState() => _DynamicFilterWidgetState();
}

class _DynamicFilterWidgetState extends State<DynamicFilterWidget> {
  String form = json.encode(
    [
      {'type': 'Date', 'label': 'Textarea test', 'value': "10/10/2022"},
      {'type': 'Date', 'label': 'Textarea test', 'value': "10/10/2022"},
      {'type': 'Date', 'label': 'Textarea test', 'value': "10/10/2022"},
      {'type': 'Date', 'label': 'Textarea test', 'value': "10/10/2022"},
      {'type': 'Date', 'label': 'Textarea test', 'value': "10/10/2022"},
      {'type': 'Button', 'label': 'Get Report', 'on_pressed': ""}
    ],
  );
  late dynamic formItems;

  var radioValue;
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      return SizedBox(
        // width: orientation == Orientation.portrait
        //     ? SizeConfig.screenwidth
        //     : SizeConfig.screenheight,
        child: Column(children: [
          Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.spaceEvenly,
              crossAxisAlignment: WrapCrossAlignment.end,
              verticalDirection: VerticalDirection.down,
              children: jsonToForm(json.decode(form))),
        ]),
      );
    });
  }

  @override
  void initState() {
    formItems = json.decode(form);

// TODO: implement initState
    super.initState();
  }

  List<Widget> jsonToForm(dynamic formItems) {
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
            width: SizeConfig.widthMultiplier * 40,
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
          // decorations: widget.decorations,
          // errorMessages: widget.errorMessages,
          // validations: widget.validations,
          // keyboardTypes: widget.keyboardTypes,
        ));
      }

      if (item['type'] == "Date") {
        listWidget.add(SizedBox(
          width: SizeConfig.widthMultiplier * 45,
          child: new JsonDate(
            item: item,
            onChange: onChange,
            position: formItems.indexOf(item),
            // decorations: widget.decorations,
            // errorMessages: widget.errorMessages,
            // validations: widget.validations,
            // keyboardTypes: widget.keyboardTypes,
          ),
        ));
      }
      if (item['type'] == "Button") {
        listWidget.add(SizedBox(
            //width: SizeConfig.widthMultiplier * 25,
            child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ElevatedButton(
              onPressed: () {},
              child: Text(item['label']),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(18),
              )),
        )));
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
                        //  _handleChanged();
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
                    // _handleChanged();
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
                        //  _handleChanged();
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
      //_handleChanged();
    });
  }
}
