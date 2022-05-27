import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../config/size_config.dart';
import '../../dashboard.dart';



List<PieChartSectionData> showingSections() {
  return List.generate(5, (i) {
    final isTouched = i == touchedIndex;
    double fontSizes = isTouched
        ? SizeConfig.textMultiplier * 3
        : SizeConfig.textMultiplier * 2;
    final radius = isTouched ? 60.0 : 50.0;

    return PieChartSectionData(
      color: colorList[i],
      value: 5,
      title: '%',
      radius: radius,
      titleStyle: GoogleFonts.montserrat(
        fontSize: fontSizes,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    );
  });
}

class DashboardPiechart extends StatefulWidget {
  const DashboardPiechart({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardPiechart> createState() => _DashboardPiechartState();
}

class _DashboardPiechartState extends State<DashboardPiechart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
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
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections()),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Text(
                  "40",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text("of 100")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
