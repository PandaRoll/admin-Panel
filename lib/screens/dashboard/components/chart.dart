import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../config/size_config.dart';
import '../../dashboard.dart';

List<PieChartSectionData> paiChartSelectionDatas = [
  PieChartSectionData(
    color: primaryColor,
    value: 25,
    showTitle: true,
    radius: 25,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 20,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFFFFCF26),
    value: 10,
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    color: Color(0xFFEE2727),
    value: 15,
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    color: primaryColor.withOpacity(0.1),
    value: 25,
    showTitle: false,
    radius: 13,
  ),
];

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                startDegreeOffset: -90,
                sections: getPieChartsections(),
                pieTouchData: PieTouchData(
                  enabled: true,
                )),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  "29.1",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("of 128GB")
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> getPieChartsections() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndex;
      double fontSizes = isTouched
          ? SizeConfig.textMultiplier * 3
          : SizeConfig.textMultiplier * 2;
      final radius = isTouched ? 60.0 : 20.0 + (3 * i);

      return PieChartSectionData(
        showTitle: true,
        color: colorList[i],
        value: double.parse((10 * i).toString()),
        title: (10 * i).toString() + '%',
        radius: radius,
        titleStyle: GoogleFonts.montserrat(
          fontSize: fontSizes,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      );
    });
  }
}
