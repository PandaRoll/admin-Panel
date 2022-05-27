import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/chartdetails.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../main/json_to_form/functions.dart';
import '../main/report_data.dart';
import 'components/header.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      MyFiles(),
                      SizedBox(height: defaultPadding),
                      cardList(context, report_data),
                      if (Responsive.isMobile(context)) ...[
                        SizedBox(height: defaultPadding),
                        StorageDetails(),
                        SizedBox(height: defaultPadding),
                        ChartDetails(),
                      ]
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context)) ...[
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    flex: 2,
                    child: ChartDetails(),
                  ),
                ]
              ],
            )
          ],
        ),
      ),
    );
  }
}
