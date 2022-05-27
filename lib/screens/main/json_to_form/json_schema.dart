// library json_to_form;

// import 'dart:convert';

// import 'package:flutter/material.dart';

// import 'components/index.dart';
// import 'components/simple_date.dart';
// import 'components/simple_radios.dart';

// class JsonSchema extends StatefulWidget {
//   const JsonSchema({
//     required this.form,
//     required this.onChanged,
//     this.padding,
//     this.formMap,
//     this.autovalidateMode,
//     this.errorMessages = const {},
//     this.validations = const {},
//     this.decorations = const {},
//     this.keyboardTypes = const {},
//     this.buttonSave,
//     this.actionSave,
//   });

//   final Map errorMessages;
//   final Map validations;
//   final Map decorations;
//   final Map keyboardTypes;
//   final String form;
//   final Map? formMap;
//   final double? padding;
//   final Widget? buttonSave;
//   final Function? actionSave;
//   final ValueChanged<dynamic> onChanged;
//   final AutovalidateMode? autovalidateMode;

//   @override
//   _CoreFormState createState() =>
//       new _CoreFormState(formMap ?? json.decode(form));
// }

// class _CoreFormState extends State<JsonSchema> {
//   final dynamic formGeneral;

//   int radioValue = -1;

//   List<Widget> jsonToForm() {
//     List<Widget> listWidget = [];
//     if (formGeneral['title'] != null) {
//       listWidget.add(Text(
//         formGeneral['title'],
//         style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
//       ));
//     }
//     if (formGeneral['description'] != null) {
//       listWidget.add(Text(
//         formGeneral['description'],
//         style: new TextStyle(fontSize: 14.0, fontStyle: FontStyle.italic),
//       ));
//     }

//     for (var count = 0; count < formGeneral['fields'].length; count++) {
//       Map item = formGeneral['fields'][count];

//       if (item['type'] == "Input" ||
//           item['type'] == "Password" ||
//           item['type'] == "Email" ||
//           item['type'] == "TextArea" ||
//           item['type'] == "TextInput") {
//         listWidget.add(new JsonTextField(
//           item: item,
//           onChange: onChange,
//           position: count,
//           decorations: widget.decorations,
//           errorMessages: widget.errorMessages,
//           validations: widget.validations,
//           keyboardTypes: widget.keyboardTypes,
//         ));
//       }

//       if (item['type'] == "RadioButton") {
//         listWidget.add(new JsonRadios(
//           item: item,
//           onChange: onChange,
//           position: count,
//           decorations: widget.decorations,
//           errorMessages: widget.errorMessages,
//           validations: widget.validations,
//           keyboardTypes: widget.keyboardTypes,
//         ));
//       }

//       if (item['type'] == "Switch") {
//         listWidget.add(new JsonToggle(
//           item: item,
//           onChange: onChange,
//           position: count,
//           decorations: widget.decorations,
//           errorMessages: widget.errorMessages,
//           validations: widget.validations,
//           keyboardTypes: widget.keyboardTypes,
//         ));
//       }

//       if (item['type'] == "Checkbox") {
//         listWidget.add(new JsonCheckBox(
//           item: item,
//           onChange: onChange,
//           position: count,
//           decorations: widget.decorations,
//           errorMessages: widget.errorMessages,
//           validations: widget.validations,
//           keyboardTypes: widget.keyboardTypes,
//         ));
//       }

//       if (item['type'] == "Select") {
//         listWidget.add(new JsonDropDown(
//           item: item,
//           onChange: onChange,
//           position: count,
//           decorations: widget.decorations,
//           errorMessages: widget.errorMessages,
//           validations: widget.validations,
//           keyboardTypes: widget.keyboardTypes,
//         ));
//       }

//       if (item['type'] == "Date") {
//         listWidget.add(new JsonDate(
//           item: item,
//           onChange: onChange,
//           position: count,
//           decorations: widget.decorations,
//           errorMessages: widget.errorMessages,
//           validations: widget.validations,
//           keyboardTypes: widget.keyboardTypes,
//         ));
//       }
//     }

//     if (widget.buttonSave != null) {
//       listWidget.add(new Container(
//         margin: EdgeInsets.only(top: 10.0),
//         child: InkWell(
//           onTap: () {
//             if (_formKey.currentState!.validate()) {
//               widget.actionSave!(formGeneral);
//             }
//           },
//           child: widget.buttonSave,
//         ),
//       ));
//     }

//     return listWidget;
//   }

//   _CoreFormState(this.formGeneral);

//   void _handleChanged() {
//     widget.onChanged(formGeneral);
//   }

//   void onChange(int position, dynamic value) {
//     this.setState(() {
//       formGeneral['fields'][position]['value'] = value;
//       this._handleChanged();
//     });
//   }

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       autovalidateMode:
//           formGeneral['autoValidated'] ?? AutovalidateMode.disabled,
//       key: _formKey,
//       child: Container(
//         padding: EdgeInsets.all(widget.padding ?? 8.0),
//         child: Row(
//           children: [
//             formItem(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget formItem() {
//     return Row(
//       children: jsonToForm(),
//     );
//     // if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding);

//     // if (!Responsive.isMobile(context)) {
//     //   return Expanded(
//     //     child: Row(
//     //       children: jsonToForm(),
//     //     ),
//     //   );
//     // } else {
//     //   return Column(
//     //     crossAxisAlignment: CrossAxisAlignment.stretch,
//     //     children: jsonToForm(),
//     //   );
//     // }
//   }
// }
