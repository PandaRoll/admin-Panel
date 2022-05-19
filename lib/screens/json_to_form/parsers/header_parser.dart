import 'package:flutter/cupertino.dart';


import '../json_to_form_with_theme.dart';
import '../widgets/header.dart';
import 'widget_parser.dart';

class HeaderParser implements WidgetParser {
  HeaderParser(this.name, this.id, this.index);

  final String name;
  final String id;

  HeaderParser.fromJson(Map<String, dynamic> json, this.index)
      : name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'id': id,
      };

  Widget getWidget(bool refresh) {
    return Header(
      name: name,
      id: id,
    );
  }

  @override
  dynamic chosenValue = "";

  @override
  set id(String _id) {
    // TODO: implement id
  }

  @override
  int index;

  @override
  int? time;

  @override
  setChosenValue(value) {
    // TODO: implement setChosenValue
  }

}
