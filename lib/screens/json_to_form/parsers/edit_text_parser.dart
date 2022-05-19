import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../json_to_form_with_theme.dart';
import '../widgets/edit_text_value.dart';
import 'widget_parser.dart';

class EditTextParser implements WidgetParser {
  final OnValueChanged? onValueChanged;

  final String? description;
  final String name;
  bool readOnly = false;
  bool long = true;
  @override
  final String id;
  @override
  dynamic chosenValue;
  final bool isBeforeHeader;
  OnValueChanged? onValueChangedLocal;
  final Widget Function(int date, String id)? dateBuilder;
  @override
  int? time;
  @override
  int index;

  EditTextParser(this.name, this.description, this.id, this.chosenValue,
      this.onValueChanged, this.isBeforeHeader, this.index, this.dateBuilder) {
    onValueChangedLocal = (String id, dynamic value) async {
      chosenValue = value;
      if (onValueChanged != null) {
        return await onValueChanged!(id, value);
      }
      return Future.value(false);
    };
  }

  @override
  EditTextParser.fromJson(Map<String, dynamic> json, this.onValueChanged,
      this.isBeforeHeader, this.index,
      [this.dateBuilder])
      : name = json['name'],
        description = json['description'],
        id = json['id'],
        time = json['time'],
        long = json["long"] ?? false,
        readOnly = json['read_only'] ?? false,
        chosenValue = json['chosen_value'] ?? "";

  @override
  set id(String _id) {
    // TODO: implement id
  }

  @override
  Widget getWidget(bool refresh) {
    return EditTextValue(
        getUpdatedTime: () {
          return time;
        },
        getUpdatedValue: () {
          return chosenValue;
        },
        onTimeUpdated: (int newTime) {
          time = newTime;
        },
        name: name,
        id: id,
        description: description,
        chosenValue: chosenValue,
        key: ValueKey(id),
        isBeforeHeader: isBeforeHeader,
        onValueChanged: (String id, dynamic value) async {
          if (chosenValue != value) {
            chosenValue = value;
            if (onValueChanged != null) {
              return await onValueChanged!(id, value);
            }
          }
          return false;
        },
        time: time,
        long: long,
        isReadOnly: readOnly,
        dateBuilder: dateBuilder);
  }

  @override
  setChosenValue(value) {
    chosenValue = value ?? "";
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'id': id,
        'chosen_value': chosenValue,
        'read_only': readOnly,
        'long': long,
        'time': time,
        'long': long
      };
}
