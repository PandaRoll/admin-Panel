import 'package:flutter/src/widgets/framework.dart';

import '../json_to_form_with_theme.dart';
import 'widget_parser.dart';

abstract class WidgetParserFactory {
  WidgetParser? getWidgetParser(
      String type,
      int index,
      Map<String, dynamic> widgetJson,
      bool isBeforeHeader,
      OnValueChanged? onValueChanged,
      Widget Function(int date, String id)? dateBuilder);
}
