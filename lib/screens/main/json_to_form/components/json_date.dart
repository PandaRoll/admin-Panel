import 'package:flutter/material.dart';

import '../functions.dart';

class JsonDate extends StatefulWidget {
  final dynamic item;
  final Function onChange;
  final int position;
  final Map errorMessages;
  final Map validations;
  final Map decorations;
  final Map keyboardTypes;
  JsonDate({
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
  _JsonDate createState() => new _JsonDate();
}

class _JsonDate extends State<JsonDate> {
  dynamic item;

  @override
  Widget build(BuildContext context) {
    Widget label = SizedBox.shrink();
    if (Fun.labelHidden(item)) {
      label = new Container(
        child: new Text(
          item['label'],
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      );
    }
    return new Container(
      margin: new EdgeInsets.only(top: 5.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          label,
          new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                  // onTap: () {
                  //   selectDate();
                  // },
                  child: Card(
                elevation: 2,
                child: Center(
                  child: new TextFormField(
                    readOnly: true,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: InputBorder.none, isCollapsed: true,
                      hintText: item['value'] ?? "",
                      //prefixIcon: Icon(Icons.date_range_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          selectDate();
                        },
                        icon: Icon(Icons.calendar_today_rounded),
                      ),
                    ),
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    item = widget.item;
  }

  Future selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now().subtract(new Duration(days: 360)),
        firstDate: new DateTime.now().subtract(new Duration(days: 360)),
        lastDate: new DateTime.now().add(new Duration(days: 360)));
    if (picked != null) {
      String date =
          "${picked.year.toString()}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      this.setState(() {
        item['value'] = date;
        widget.onChange(widget.position, date);
      });
    }
  }
}
