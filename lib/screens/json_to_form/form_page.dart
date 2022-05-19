import 'package:admin/screens/config/size_config.dart';
import 'package:admin/screens/json_to_form/json_to_form_with_theme.dart';
import 'package:admin/screens/json_to_form/themes/json_form_theme.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class JsonTheme extends JsonFormTheme {
  JsonTheme(
      {required EdgeInsets headerContainerPadding,
      required InputDecoration inputDecoration,
      required double editTextHeight,
      required TextStyle editTextStyle,
      required EdgeInsets staticTextPadding,
      required EdgeInsets lineMargins,
      required BoxDecoration staticContainerDecoration,
      required TextStyle titleTextStyle,
      required BoxDecoration headerContainerDecoration,
      required TextStyle headerTextStyle,
      required double toggleMinWidth,
      required double toggleMinHeight,
      required double toggleFontSize,
      required Color toggleActiveColor,
      required Color toggleActiveTextColor,
      required Color toggleInactiveColor,
      required Color toggleInactiveTextColor,
      required Widget? dropDownIcon,
      required Widget? underLineWidget,
      required TextStyle nameTextStyle,
      required EdgeInsets nameContainerPadding,
      required BoxDecoration nameContainerDecoration,
      required TextStyle descriptionTextStyle,
      required TextStyle staticTextStyle,
      required EdgeInsets linePadding,
      required BoxDecoration linePaDecoration,
      required BoxDecoration linePaDecorationAboveHeader,
      required Color editTextCursorColor,
      required double editTextWidth,
      required Color backgroundColor,
      required TextStyle editTextStyleFocus,
      required InputDecoration inputDecorationReadOnly,
      required EdgeInsets editTextMargins,
      required EdgeInsets editTextLongMargins,
      required EdgeInsets headerContainerMargins,
      required int? debounceTime,
      required double dropDownWith,
      required TextInputType? keyboardTypeLong,
      required TextInputType? keyboardTypeShort,
      required double toggleWidthOfHeader,
      required double editTextWidthOfHeader,
      required double dropDownWidthOfHeader,
      required double staticTextWidthOfHeader,
      required double staticValueWidth})
      : super(
            overflow: true,
            headerContainerPadding: headerContainerPadding,
            inputDecoration: inputDecoration,
            editTextHeight: editTextHeight,
            editTextStyle: editTextStyle,
            staticTextPadding: staticTextPadding,
            lineMargins: lineMargins,
            staticContainerDecoration: staticContainerDecoration,
            titleTextStyle: titleTextStyle,
            headerContainerDecoration: headerContainerDecoration,
            headerTextStyle: headerTextStyle,
            toggleMinWidth: toggleMinWidth,
            toggleMinHeight: toggleMinHeight,
            toggleFontSize: toggleFontSize,
            toggleActiveColor: toggleActiveColor,
            toggleActiveTextColor: toggleActiveTextColor,
            toggleInactiveColor: toggleInactiveColor,
            toggleInactiveTextColor: toggleInactiveTextColor,
            dropDownIcon: dropDownIcon,
            underLineWidget: underLineWidget,
            nameTextStyle: nameTextStyle,
            nameContainerPadding: nameContainerPadding,
            nameContainerDecoration: nameContainerDecoration,
            descriptionTextStyle: descriptionTextStyle,
            staticTextStyle: staticTextStyle,
            linePadding: linePadding,
            linePaDecoration: linePaDecoration,
            linePaDecorationAboveHeader: linePaDecorationAboveHeader,
            editTextCursorColor: editTextCursorColor,
            editTextWidth: editTextWidth,
            backgroundColor: backgroundColor,
            editTextStyleFocus: editTextStyleFocus,
            inputDecorationReadOnly: inputDecorationReadOnly,
            editTextMargins: editTextMargins,
            editTextLongMargins: editTextLongMargins,
            headerContainerMargins: headerContainerMargins,
            debounceTime: debounceTime,
            dropDownWith: dropDownWith,
            keyboardTypeLong: keyboardTypeLong,
            keyboardTypeShort: keyboardTypeShort,
            toggleWidthOfHeader: toggleWidthOfHeader,
            editTextWidthOfHeader: editTextWidthOfHeader,
            dropDownWidthOfHeader: dropDownWidthOfHeader,
            staticTextWidthOfHeader: staticTextWidthOfHeader,
            staticValueWidth: staticValueWidth);
}

class _FormPageState extends State<FormPage> {
  final Map<String, dynamic> json = {
    "widgets": [
      {"type": "header", "name": "Header", "id": "29"},
      {
        "id": "1",
        "name": "DVT",
        "type": "toggle",
        "values": ["On", "Off"],
        "chosen_value": null,
        "time": 1630164109066,
      },
      {"type": "header", "name": "Header2", "id": "39"},
      {
        "id": "56",
        "name": "ADVT",
        "type": "toggle",
        "values": ["On", "Off"],
        "chosen_value": "Off",
        "time": 0,
      },
      {
        "id": "2",
        "name": "edit_text",
        "type": "edit_text",
        "chosen_value": "value which is long value",
        "description": "(description..)",
        "time": 1640164109066,
      },
      {
        "id": "26",
        "name": "Long name of the line but a short",
        "type": "static_text",
        "chosen_value": "value",
        "description": "(description..)",
        "time": 1640164109066,
      },
      {
        "id": "3",
        "name": "Blood Pressure",
        "type": "edit_text",
        "chosen_value": "ValAAAAAA",
        "time": 1640260609562,
        "description": "mmHg - with a long description",
      },
      {"type": "header", "name": "Header", "id": "99"},
      {
        "id": "4",
        "name": "Drop down",
        "type": "drop_down",
        "time": 1640264109066,
        "values": ["Low-Intermediate", "Medium", "High", ""],
        "chosen_value": "Low-Intermediate"
      },
      {
        "id": "5",
        "name": "Dynamic Drop down",
        "type": "drop_down",
        "values": ["one", "two", "three"],
        "chosen_value": "one",
        "time": 1530164109066,
      }
    ]
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        height: SizeConfig.screenheight,
        width: SizeConfig.screenwidth,
        child: JsonFormWithTheme(
          jsonWidgets: json,
          theme: JsonTheme(
            backgroundColor: Color.fromARGB(255, 140, 241, 193),
            debounceTime: null,
            descriptionTextStyle: TextStyle(
                fontSize: SizeConfig.widthMultiplier * 2, color: Colors.black),
            dropDownIcon: Icon(Icons.arrow_downward),
            dropDownWidthOfHeader: SizeConfig.widthMultiplier * 20,
            dropDownWith: SizeConfig.widthMultiplier * 50,
            editTextCursorColor: Colors.black,
            editTextHeight: 50,
            editTextLongMargins: EdgeInsets.all(5),
            editTextMargins: EdgeInsets.all(5),
            editTextStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2, color: Colors.black),
            editTextStyleFocus: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2, color: Colors.black),
            headerTextStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2, color: Colors.black),
            nameTextStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2, color: Colors.black),
            staticTextStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2, color: Colors.black),
            titleTextStyle: TextStyle(
                fontSize: SizeConfig.textMultiplier * 2, color: Colors.black),
            editTextWidth: SizeConfig.widthMultiplier * 70,
            editTextWidthOfHeader: SizeConfig.widthMultiplier * 20,
            headerContainerDecoration: BoxDecoration(),
            headerContainerMargins: EdgeInsets.all(4),
            headerContainerPadding: EdgeInsets.all(5),
            inputDecoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3))),
            inputDecorationReadOnly: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black))),
            keyboardTypeLong: TextInputType.text,
            keyboardTypeShort: TextInputType.text,
            lineMargins: EdgeInsets.all(5),
            linePaDecoration:
                BoxDecoration(border: Border.all(color: Colors.black)),
            linePadding: EdgeInsets.all(5),
            linePaDecorationAboveHeader: BoxDecoration(),
            nameContainerDecoration: BoxDecoration(),
            staticContainerDecoration: BoxDecoration(),
            nameContainerPadding: EdgeInsets.all(5),
            staticTextPadding: EdgeInsets.all(5),
            // overflow: true,
            staticTextWidthOfHeader: SizeConfig.widthMultiplier * 20,
            staticValueWidth: SizeConfig.widthMultiplier * 20,
            toggleActiveColor: Colors.green,
            toggleActiveTextColor: Colors.white,
            toggleFontSize: SizeConfig.textMultiplier * 3,
            toggleInactiveColor: Colors.grey,
            toggleInactiveTextColor: Colors.white,
            toggleMinHeight: 30,
            toggleMinWidth: 80,
            toggleWidthOfHeader: SizeConfig.widthMultiplier * 10,
            underLineWidget: Container(),
            // activeToggleBorder: Border(),
            //mainAxisAlignmentOfName: MainAxisAlignment.start,
            //staticTextValueAlign: TextAlign.start),
          ),
        ),
      ),
    ));
  }
}
