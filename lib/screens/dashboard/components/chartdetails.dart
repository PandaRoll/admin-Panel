import 'package:admin/screens/dashboard/components/piechart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ChartDetails extends StatelessWidget {
  const ChartDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chart Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: defaultPadding),
          DashboardPiechart(),
        ],
      ),
    );
  }

}

