import 'dart:convert';

import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/chartdetails.dart';
import 'package:admin/screens/dashboard/components/dynamic_chart_widget.dart';
import 'package:admin/screens/dashboard/components/my_fields.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/header.dart';
import 'components/recent_files.dart';
import 'components/storage_details.dart';

var json_data = [
  {
    'type': 'line',
    'title': 'TItle',
    'groupName': 'Group1',
    'data': [
      {
        'x': 'value1',
        'y': [10, 12],
      },
      {
        'x': 'value2',
        'y': [15, 12],
      },
      {
        'x': 'value3',
        'y': [5, 10],
      },
      {
        'x': 'value4',
        'y': [22, 6],
      },
      {
        'x': 'value5',
        'y': [15, 20],
      },
      {
        'x': 'value6',
        'y': [14, 25],
      }
    ]
  },
  {
    'type': 'stacked',
    'title': 'TItle',
    'groupName': 'Group2',
    'data': [
      {
        'x': 'value1',
        'y': [17, 15],
      },
      {
        'x': 'value2',
        'y': [10, 10],
      },
      {
        'x': 'value3',
        'y': [15, 5],
      },
      {
        'x': 'value4',
        'y': [5, 20],
      },
      {
        'x': 'value5',
        'y': [10, 15],
      },
      {
        'x': 'value6',
        'y': [15, 20],
      }
    ]
  }
];

// ,{
//   'type':'barchart',
//   'title' : 'TItle',
//   'data' : {
//     'x' : 'value',
//     'y' :'[12]',
//     'groupName' : 'Group1'
//   }

// },{
//   'type':'stacked',
//   'title' : 'TItle',
//   'data' : {
//     'x' : 'value',
//     'y' :'[10,5,8,12]',
//     'groupName' : 'Group1'
//   }

// },{
//   'type':'line',
//   'title' : 'TItle',
//   'data' : {
//     'x' : 'value',
//     'y' :'[10,5,8,12]',
//     'groupName' : 'Group1'
//   }

//}

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
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
                      RecentFiles(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) StorageDetails(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                      if (Responsive.isMobile(context)) ChartDetails(),
                      DynamicChartWidget(
                        chartData: json.encode(json_data),
                        type: "barchart",
                      ),
                      DynamicChartWidget(
                        chartData: json.encode(json_data),
                        type: "stacked",
                      ),
                      DynamicChartWidget(
                        chartData: json.encode(json_data),
                        type: "piechart",
                      ),
                      DynamicChartWidget(
                        chartData: json.encode(json_data),
                        type: "line",
                      )
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: StorageDetails(),
                  ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),
                // On Mobile means if the screen is less than 850 we dont want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: ChartDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
