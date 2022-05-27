import 'package:admin/models/MyFiles.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/pluto_grid_demo.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../config/size_config.dart';
import 'file_info_card.dart';

class FileInfoCardGridView extends StatelessWidget {
  final int crossAxisCount;

  final double childAspectRatio;
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlutoGridDemo(
                        // title: "form",
                        )));
          },
          child: FileInfoCard(info: demoMyFiles[index])),
    );
  }
}

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "My Files",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: SizeConfig.screenwidth < 650 ? 2 : 4,
            childAspectRatio:
                SizeConfig.screenwidth < 650 && SizeConfig.screenwidth > 350
                    ? 1.2
                    : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: SizeConfig.screenwidth < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}
