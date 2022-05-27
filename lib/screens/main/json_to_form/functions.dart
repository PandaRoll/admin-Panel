import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/RecentFile.dart';
import '../../../responsive.dart';
import '../../dashboard/components/recent_files.dart';

Widget cardList(BuildContext context, List<dynamic> data) {
  if (Responsive.isMobile(context)) {
    return ListView.builder(
        itemCount: demoRecentFiles.length,
        itemBuilder: (context, index) {
          return Column();
        });
  } else {
    return SizedBox(
      width: double.infinity,
      child: DataTable2(
        columnSpacing: defaultPadding,
        minWidth: 600,
        columns: [
          DataColumn(
            label: Text("File Name"),
          ),
          DataColumn(
            label: Text("Date"),
          ),
          DataColumn(
            label: Text("Size"),
          ),
        ],
        rows: List.generate(
          demoRecentFiles.length,
          (index) => recentFileDataRow(demoRecentFiles[index]),
        ),
      ),
    );
  }
}

class Fun {
  static bool labelHidden(item) {
    if (item.containsKey('hiddenLabel')) {
      if (item['hiddenLabel'] is bool) {
        return !item['hiddenLabel'];
      }
    } else {
      return true;
    }
    return false;
  }

  static String? validateEmail(item, String value) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }
    return 'Email is not valid';
  }
}
