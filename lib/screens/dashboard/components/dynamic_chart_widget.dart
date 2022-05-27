import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../config/size_config.dart';
import '../../dashboard.dart';

class DynamicChartWidget extends StatefulWidget {
  final String chartData;
  final String type;

  const DynamicChartWidget(
      {Key? key, required this.chartData, required this.type})
      : super(key: key);

  @override
  State<DynamicChartWidget> createState() => _DynamicChartWidgetState();
}

class _ChartData {
  final String x;
  final double y;
  _ChartData(this.x, this.y);
}

class _ChartDataStacked {
  final String x;
  final List<double> y;

  _ChartDataStacked(this.x, this.y);
}

class _DynamicChartWidgetState extends State<DynamicChartWidget> {
  late TooltipBehavior _tooltip;
  late List<_ChartData> data;
  late List<dynamic> chartData;

  late List<_ChartDataStacked> data2 = [
    _ChartDataStacked("A", [4, 5, 6, 3, 2]),
    _ChartDataStacked("B", [4, 5, 2, 3, 1]),
    _ChartDataStacked("C", [4, 8, 5, 7, 6]),
    _ChartDataStacked("D", [4, 2, 2, 2, 2]),
    _ChartDataStacked("E", [4, 8, 0, 3, 5])
  ];

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          // Container(
          //   child: SfCartesianChart(
          //       primaryXAxis: CategoryAxis(),
          //       primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
          //       tooltipBehavior: _tooltip,
          //       series: <ChartSeries<_ChartData, String>>[
          //         ColumnSeries<_ChartData, String>(
          //             dataSource: getChartData(data),
          //             xValueMapper: (_ChartData data, _) => data.x,
          //             yValueMapper: (_ChartData data, _) => data.y,
          //             name: 'Gold',
          //             color: Color.fromRGBO(8, 142, 255, 1))
          //       ]),
          //   // SfCartesianChart(
          //   //   primaryXAxis: ChartAxis(),
          //   // )
          // ),
          // SfCartesianChart(
          //     primaryXAxis: CategoryAxis(),
          //     tooltipBehavior: _tooltip,
          //     enableAxisAnimation: true,
          //     isTransposed: true,
          //     series: <ChartSeries>[
          //       StackedBarSeries<_ChartDataStacked, String>(
          //         groupName: 'Group A',
          //         dataSource: getChartDataStacked(data2),
          //         xValueMapper: (_ChartDataStacked data, _) => data.x,
          //         yValueMapper: (_ChartDataStacked data, _) => data.y.first,
          //       ),
          //       StackedBarSeries<_ChartDataStacked, String>(
          //           groupName: 'Group B',
          //           dataSource: getChartDataStacked(data2),
          //           xValueMapper: (_ChartDataStacked data, _) => data.x,
          //           yValueMapper: (_ChartDataStacked data, _) => data.y[1]),
          //       StackedBarSeries<_ChartDataStacked, String>(
          //           groupName: 'Group A',
          //           dataSource: getChartDataStacked(data2),
          //           xValueMapper: (_ChartDataStacked data, _) => data.x,
          //           yValueMapper: (_ChartDataStacked data, _) => data.y[2]),
          //       StackedBarSeries<_ChartDataStacked, String>(
          //           groupName: 'Group B',
          //           dataSource: getChartDataStacked(data2),
          //           xValueMapper: (_ChartDataStacked data, _) => data.x,
          //           yValueMapper: (_ChartDataStacked data, _) => data.y[3]),
          //     ]),
          SizedBox(
              //height: SizeConfig.heightMultiplier * 40,
              width: SizeConfig.screenwidth,
              child: getChart(json.decode(widget.chartData))),
          if (widget.type == 'piechart')
            SizedBox(
                width: SizeConfig.screenwidth,
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  children: chartData
                      .map((e) => Container(
                            padding: EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  color: colorList[chartData.indexOf(e) % 12],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(e['x'])
                              ],
                            ),
                          ))
                      .toList(),
                ))
        ],
      ),
    );
  }

  Widget getChart(List<dynamic> chartData) {
    // switch (chartData.first['type']) {
    switch (widget.type) {
      case 'piechart':
        return SizedBox(
          height: SizeConfig.heightMultiplier * 30,
          width: SizeConfig.screenwidth,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              }),
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: getPieChartsections(chartData.first['data']),
            ),
          ),
        );

      case ('barchart'):
        return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<dynamic, String>>[
              ColumnSeries<dynamic, String>(
                  dataSource: chartData.first['data'],
                  xValueMapper: (dynamic data, _) => data['x'],
                  yValueMapper: (dynamic data, _) => data['y'].first,
                  name: 'Gold',
                  color: Color.fromRGBO(8, 142, 255, 1))
            ]);
      case ('stacked'):
        return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            tooltipBehavior: _tooltip,
            enableAxisAnimation: true,
            isTransposed: true,
            
            series: <ChartSeries>[
              for (dynamic item in chartData) ...[
                for (int i = 0; i < item['data'].first['y'].length; i++)
                  StackedBarSeries<dynamic, String>(
                    groupName: item['groupName'],
                    dataSource: item['data'],
                    xValueMapper: (dynamic data, _) => data['x'],
                    yValueMapper: (dynamic data, _) => data['y'][i],
                    
                  ),
              ]
            ]);
      case ('line'):
        return SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            //primaryYAxis: NumericAxis(minimum: 0, maximum: 40, interval: 10),
            tooltipBehavior: _tooltip,
            series: <ChartSeries<dynamic, String>>[
              for (dynamic item in chartData) ...[
                for (int i = 0; i < item['data'].first['y'].length; i++)
                  LineSeries<dynamic, String>(
                      dataSource: chartData.first['data'],
                      xValueMapper: (dynamic data, _) => data['x'],
                      yValueMapper: (dynamic data, _) => data['y'][i],
                      name: item['groupName'],
                      color: colorList[i])
              ]
            ]);
      default:
        return Container();
    }
  }

  List<_ChartData> getChartData(List<_ChartData> data) {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      double fontSizes = isTouched
          ? SizeConfig.textMultiplier * 3
          : SizeConfig.textMultiplier * 2;
      final radius = isTouched ? 60.0 : 50.0;

      return _ChartData(data[i].x, data[i].y);
    });
  }

  List<_ChartDataStacked> getChartDataStacked(List<_ChartDataStacked> data) {
    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      double fontSizes = isTouched
          ? SizeConfig.textMultiplier * 3
          : SizeConfig.textMultiplier * 2;
      final radius = isTouched ? 60.0 : 50.0;

      return _ChartDataStacked(data[i].x, data[i].y);
    });
  }

  List<PieChartSectionData> getPieChartsections(List<dynamic> chartData) {
    return List.generate(chartData.length, (i) {
      final isTouched = i == touchedIndex;
      List<dynamic> yValues = chartData[i]['y'];

      double fontSizes = isTouched
          ? SizeConfig.textMultiplier * 3
          : SizeConfig.textMultiplier * 2;
      final radius = isTouched ? 60.0 : 25.0 + (3 * i);

      return PieChartSectionData(
        showTitle: true,
        color: colorList[i],
        value: double.parse(yValues.first.toString()),
        title: yValues.first.toString(),
        radius: radius,
        titleStyle: GoogleFonts.montserrat(
          fontSize: fontSizes,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );
    });
  }

  @override
  void initState() {
    data = [
      _ChartData('CHN', 12),
      _ChartData('GER', 15),
      _ChartData('RUS', 30),
      _ChartData('BRZ', 6.4),
      _ChartData('IND', 14)
    ];
    chartData = json.decode(widget.chartData).first['data'];

    _tooltip = TooltipBehavior(enable: true);

    super.initState();
  }
}
