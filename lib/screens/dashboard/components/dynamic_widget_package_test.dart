import 'package:admin/screens/config/size_config.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

late final JsonWidgetRegistry registry;
Map<String, dynamic> _json = {
  "type": "text_form_field",
  "id": "email_address",
  "args": {
    "decoration": {
      "hintText": "name@example.com",
      "labelText": "Email Address",
      "suffixIcon": {
        "type": "icon_button",
        "args": {
          "icon": {
            "type": "icon",
            "args": {
              "icon": {
                "codePoint": 57704,
                "fontFamily": "MaterialIcons",
                "size": 50
              }
            }
          },
        }
      }
    },
    "validators": [
      {"type": "required"},
      {"type": "email"}
    ]
  }
};

class DynamicWidget extends StatefulWidget {
  const DynamicWidget({Key? key}) : super(key: key);

  @override
  State<DynamicWidget> createState() => _DynamicWidgetState();
}

class _DynamicWidgetState extends State<DynamicWidget> {
  JsonWidgetData? _data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            height: SizeConfig.screenheight,
            width: SizeConfig.screenwidth,
            child: _data!.build(
              context: context,
            )),
      ),
    );
  }

  @override
  void initState() {
    _data = JsonWidgetData.fromDynamic(_json);
    super.initState();
  }
}
