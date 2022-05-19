import 'package:flutter/widgets.dart';

import 'json_form_theme.dart';


/// Used to make provided [ChatTheme] class available through the whole package
class InheritedJsonFormTheme extends InheritedWidget {
  /// Creates [InheritedWidget] from a provided [ChatTheme] class
  const InheritedJsonFormTheme({
    Key? key,
    required this.theme,
    required Widget child,
  }) : super(key: key, child: child);

  /// Represents chat theme
  final JsonFormTheme theme;

  static InheritedJsonFormTheme of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<InheritedJsonFormTheme>()!;
  }

  @override
  bool updateShouldNotify(InheritedJsonFormTheme oldWidget) =>
      theme.hashCode != oldWidget.theme.hashCode;
}
