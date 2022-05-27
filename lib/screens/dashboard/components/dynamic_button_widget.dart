import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';

typedef OnTap<T> = Function(T);

class DynamicButton extends StatefulWidget {
  final dynamic button_data;
 
  final OnTap onTap;

  const DynamicButton(
      {Key? key,
      required this.button_data,
      
      required this.onTap})
      : super(key: key);

  @override
  State<DynamicButton> createState() => _DynamicButtonWidgetState();
}

class _DynamicButtonWidgetState extends State<DynamicButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          widget.onTap("");
         
        },
        child: buttonChild(
            widget.button_data['type'], widget.button_data['content']),
        style: ElevatedButton.styleFrom(
          primary: getColor(widget.button_data['color']),
        ));
  }

  buttonChild(String type, String data) {
    switch (type) {
      case ("text_button"):
        return Text(data);
      case ("icon_button"):
        return getIcon(data);
    }
  }

  Color getColor(String color) {
    switch (color) {
      case ("red"):
        return Colors.red;
      case ("green"):
        return Colors.green;
      case ("blue"):
        return Colors.blue;
      default:
        return Colors.blue;
    }
  }

  Icon getIcon(String data) {
    switch (data) {
      case ("icon_check"):
        return Icon(
          Icons.check,
          color: Colors.white,
        );
      case ("icon_close"):
        return Icon(
          Icons.close,
          color: Colors.white,
        );
      case ("icon_save"):
        return Icon(
          Icons.save,
          color: Colors.white,
        );
      case ("icon_delete"):
        return Icon(
          Icons.delete_forever,
          color: Colors.white,
        );
      case ("icon_upload"):
        return Icon(Icons.upload_file);
      default:
        return Icon(
          Icons.error_outline,
          color: Colors.white,
        );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
}
