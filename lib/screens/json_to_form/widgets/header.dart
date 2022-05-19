import 'package:flutter/widgets.dart';

import '../themes/inherited_json_form_theme.dart';

class Header extends StatelessWidget {
  final String name;
  final String id;
  const Header({Key? key, required this.name, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
      padding: InheritedJsonFormTheme.of(context).theme.headerContainerPadding,
      margin: InheritedJsonFormTheme.of(context).theme.headerContainerMargins,
      decoration:
          InheritedJsonFormTheme.of(context).theme.headerContainerDecoration,
      child: Text(
        name,
        style: InheritedJsonFormTheme.of(context).theme.headerTextStyle,
      ),
    );
  }
}
