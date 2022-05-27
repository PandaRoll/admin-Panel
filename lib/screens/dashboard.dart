// ignore_for_file: must_be_immutable, unnecessary_new, file_names
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'config/app_theme.dart';
import 'config/size_config.dart';

// List<DataColumn> dataTableColumnHeaderSetter(List<OSsummary> summary) {
//   return List.generate(summary.length, (i) {
//     return DataColumn(
//       label: Text(
//         summary[i].head,
//         textAlign: TextAlign.center,
//       ),
//       numeric: true,
//       tooltip: "",
//     );
//   });
// }

// List<DataCell> dataTableColumnValueSetter(List<OSsummary> summary) {
//   return List.generate(summary.length, (i) {
//     return DataCell(
//       Text(
//         summary[i].value,
//         textAlign: TextAlign.center,
//       ),
//       showEditIcon: false,
//       placeholder: false,
//     );
//   });
// }

List<Color> colorList = [
  AppTheme.colors.dashBoardGradientC1,
  AppTheme.colors.dashBoardGradientC2,
  AppTheme.colors.dashBoardGradientC3,
  AppTheme.colors.dashBoardGradientC4,
  AppTheme.colors.dashBoardGradientC5,
  AppTheme.colors.dashBoardGradientC6,
  AppTheme.colors.dashBoardGradientC7,
  AppTheme.colors.dashBoardGradientC8,
  AppTheme.colors.dashBoardGradientC9,
  AppTheme.colors.dashBoardGradientC11,
  AppTheme.colors.dashBoardGradientC12,
  AppTheme.colors.dashBoardGradientC13,
  AppTheme.colors.dashBoardGradientC14,
  AppTheme.colors.dashBoardGradientC15,
  AppTheme.colors.dashBoardGradientC16,
  AppTheme.colors.dashBoardGradientC17,
  AppTheme.colors.dashBoardGradientC18,
  AppTheme.colors.dashBoardGradientC10,
  AppTheme.colors.dashBoardGradientC19,
  AppTheme.colors.dashBoardGradientC20,
];

List<DashBoardItem> dashBoardList = [
  DashBoardItem(
      title: "Sales Amount",
      gradColor1: AppTheme.colors.dashBoardGradientC11,
      gradColor2: AppTheme.colors.dashBoardGradientC12),
  DashBoardItem(
      title: "Sales Quantity",
      gradColor1: AppTheme.colors.foscherbluelight,
      gradColor2: AppTheme.colors.dashBoardGradientC1),
];

List<DashBoardItem> invoiceCount = [
  DashBoardItem(
      title: "Invoiced Cust.",
      gradColor1: AppTheme.colors.dashBoardGradientC9,
      gradColor2: AppTheme.colors.dashBoardGradientC10),
  DashBoardItem(
      title: "Invoice Count",
      gradColor1: AppTheme.colors.dashBoardGradientC2,
      gradColor2: AppTheme.colors.dashBoardGradientC12),
];

int touchedIndex = -1;

List<PieChartSectionData> showingSections(List<Category>? category) {
  return List.generate(5, (i) {
    final isTouched = i == touchedIndex;
    double fontSizes = isTouched
        ? SizeConfig.textMultiplier * 3
        : SizeConfig.textMultiplier * 2;
    final radius = isTouched ? 60.0 : 50.0;

    return PieChartSectionData(
      color: colorList[i],
      value: 8,
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

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class DashBoardItem {
  String title;
  Color gradColor1;
  Color gradColor2;

  DashBoardItem({
    required this.title,
    required this.gradColor1,
    required this.gradColor2,
  });
}

class Indicator extends StatelessWidget {
  Color color;
  String text;
  bool isSquare;
  double size;
  Color textColor;

  Indicator({
    Key? key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Flexible(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 2.2 * SizeConfig.textMultiplier,
              fontWeight: FontWeight.w500,
              color: AppTheme.colors.foscherblue,
            ),
          ),
        )
      ],
    );
  }
}

class _DashBoardState extends State<DashBoard> {
  // DBProvider db = DBProvider();

  String loginId = "", custId = "", apiKey = "";
  // late List<UserData> userData;
  String dp = "";
  late bool connectivity;

  // late ConnectivityStatus connectionStatus;
  String password = "";
  List<_SalesData> salesData = [];

  List<_SalesData> qtyData = [];
  bool changeDP = false;
  String userName = "";
  String userType = "";
  // late Future<DashBoardModel> dashBoardFuture;
  // DashBoardModel? dashBoardItems;
  final RefreshController refreshController =
      RefreshController(initialRefresh: false);

  final GlobalKey refresherKey = GlobalKey();

  ImageCropper imgCropper = ImageCropper();

  List<String> imageList = [];
  ////////////////////////////////////////////////////////////////

  List<String> pathStrings = [];
  String error = "";

  List<String> images = [];

  final _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    // connectionStatus = Provider.of<ConnectivityStatus>(context);
    // connectivity = checkNetwork(connectionStatus);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: AppTheme.colors.foscherblue,
              ),
              elevation: 5,
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text(
                "Dashboard",
                style: GoogleFonts.montserrat(
                  fontSize: 3 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.normal,
                  color: AppTheme.colors.foscherblue,
                ),
              ),
              automaticallyImplyLeading: true,
            ),
            body: SizedBox(
                // color: Colors.white,
                width: SizeConfig.screenwidth,
                height: SizeConfig.screenheight,
                child: SmartRefresher(
                    key: refresherKey,
                    controller: refreshController,
                    enablePullUp: false,
                    physics: const BouncingScrollPhysics(),
                    footer: const ClassicFooter(
                      loadStyle: LoadStyle.ShowWhenLoading,
                      completeDuration: Duration(milliseconds: 500),
                    ),
                    onRefresh: () async {
                      refreshController.refreshCompleted();
                    },
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        height: SizeConfig.widthMultiplier * 42,
                        width: SizeConfig.widthMultiplier * 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(360.0),
                                    ),
                                    elevation: 3,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        InkWell(
                                          borderRadius:
                                              BorderRadius.circular(360),
                                          radius:
                                              SizeConfig.widthMultiplier * 1,
                                          onTap: () {
                                            if (changeDP) {
                                              setState(() {
                                                changeDP = false;
                                              });
                                            } else {
                                              setState(() {
                                                changeDP = true;
                                              });
                                            }
                                          },
                                          child: Container(
                                            width:
                                                SizeConfig.widthMultiplier * 26,
                                            height:
                                                SizeConfig.widthMultiplier * 26,
                                            decoration: BoxDecoration(
                                              color:
                                                  AppTheme.colors.foscherblue,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(360),
                                              ),
                                            ),
                                            child: Card(
                                              shadowColor:
                                                  AppTheme.colors.foscherblue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        360.0),
                                              ),
                                              elevation: 2,
                                              child: Container(
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      25,
                                                  height: SizeConfig
                                                          .widthMultiplier *
                                                      25,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white54,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(360),
                                                    ),
                                                  ),
                                                  child:
                                                      // dp != ""
                                                      //     ?
                                                      ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      360),
                                                          child:
                                                              // Image.network(
                                                              //   dp,
                                                              //   fit: BoxFit.cover,
                                                              // ),

                                                              CachedNetworkImage(
                                                            imageUrl: dp,
                                                            imageBuilder: (context,
                                                                    imageProvider) =>
                                                                Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                shape: BoxShape
                                                                    .rectangle,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                image: DecorationImage(
                                                                    image:
                                                                        imageProvider,
                                                                    fit: BoxFit
                                                                        .cover),
                                                              ),
                                                            ),
                                                            fit: BoxFit.fill,
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Image.asset(
                                                              "assets/images/placeholder.png",
                                                              fit: BoxFit.cover,
                                                            ),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Icon(Icons
                                                                    .error),
                                                          ))
                                                  // : ClipRRect(
                                                  //     borderRadius:
                                                  //         BorderRadius
                                                  //             .circular(
                                                  //                 360),
                                                  //     child: Image.asset(
                                                  //       "assets/images/placeholder.png",
                                                  //       fit: BoxFit.cover,
                                                  //     ),
                                                  //   ),
                                                  ),
                                            ),
                                          ),
                                        ),
                                        changeDP
                                            ? InkWell(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(150),
                                                  bottomRight:
                                                      Radius.circular(150),
                                                ),
                                                onTap: () {
                                                  showOptions(context);
                                                },
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  width: SizeConfig
                                                          .widthMultiplier *
                                                      26,
                                                  height: SizeConfig
                                                          .widthMultiplier *
                                                      13,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white24,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(100),
                                                      bottomRight:
                                                          Radius.circular(100),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Change",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 1.8 *
                                                              SizeConfig
                                                                  .textMultiplier,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppTheme.colors
                                                              .foscherblue,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.camera_alt,
                                                        size: 20,
                                                        color: AppTheme
                                                            .colors.foscherblue,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(
                                                height: 0,
                                              ),
                                      ],
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/logo.png",
                                    height: SizeConfig.widthMultiplier * 6,
                                    width: SizeConfig.widthMultiplier * 20,
                                    fit: BoxFit.cover,
                                  ),
                                ],
                              ),
                              VerticalDivider(
                                indent: SizeConfig.widthMultiplier * 5,
                                endIndent: SizeConfig.widthMultiplier * 5,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    child: Text(
                                      " Edit Profile",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 2 * SizeConfig.textMultiplier,
                                        fontWeight: FontWeight.w500,
                                        color: AppTheme.colors.foscherbluelight,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        "/resetPassword",
                                      );
                                    },
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        userName,
                                        style: GoogleFonts.montserrat(
                                          fontSize:
                                              2 * SizeConfig.textMultiplier,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.colors.foscherblue,
                                        ),
                                      ),
                                      Text(
                                        (userType == "OWN_SMAN")
                                            ? "SALES MAN"
                                            : (userType == "USR")
                                                ? "CUSTOMER"
                                                : "DISTRIBUTER",
                                        style: GoogleFonts.montserrat(
                                          fontSize:
                                              1.8 * SizeConfig.textMultiplier,
                                          fontWeight: FontWeight.w900,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        "ID: $custId",
                                        style: GoogleFonts.montserrat(
                                          fontSize:
                                              1.8 * SizeConfig.textMultiplier,
                                          fontWeight: FontWeight.w500,
                                          color: AppTheme.colors.foschercherry,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        indent: SizeConfig.widthMultiplier * 5,
                        endIndent: SizeConfig.widthMultiplier * 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              itemCount: dashBoardList.length,
                              gridDelegate:
                                  // SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 150),
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.75),
                              //3,.70 & 2,.75//3/3

                              itemBuilder: (context, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  radius: SizeConfig.widthMultiplier * 1,
                                  onTap: () {},
                                  child: SizedBox(
                                      child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                            colors: [
                                              dashBoardList[index].gradColor1,
                                              dashBoardList[index].gradColor2
                                            ],
                                            begin: const FractionalOffset(
                                                0.0, 0.0),
                                            end: const FractionalOffset(
                                                1.0, 0.0),
                                            stops: const [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.widthMultiplier * 2),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 3.5 *
                                                          SizeConfig
                                                              .textMultiplier,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  dashBoardList[index].title,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 3 *
                                                        SizeConfig
                                                            .textMultiplier,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                                );
                              }),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              ),
                              Text(
                                "Category Wise Sales Shares",
                                style: GoogleFonts.montserrat(
                                  fontSize: 2.5 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.colors.foscherblue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 1,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: AspectRatio(
                                  aspectRatio: 1.3,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: AspectRatio(
                                          aspectRatio: .5,
                                          child: PieChart(
                                            PieChartData(
                                                pieTouchData: PieTouchData(
                                                    touchCallback:
                                                        (FlTouchEvent event,
                                                            pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndex = -1;
                                                      return;
                                                    }
                                                    touchedIndex =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                }),
                                                borderData: FlBorderData(
                                                  show: false,
                                                ),
                                                sectionsSpace: 0,
                                                centerSpaceRadius: 40,
                                                sections:
                                                    showingSections(null)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.widthMultiplier * 60,
                                        width: SizeConfig.widthMultiplier * 30,
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 9,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Indicator(
                                                    color: colorList[index],
                                                    text: "",
                                                    size: SizeConfig
                                                            .widthMultiplier *
                                                        5,
                                                    isSquare: true,
                                                  ),
                                                  SizedBox(
                                                    height: SizeConfig
                                                            .widthMultiplier *
                                                        2,
                                                  )
                                                ],
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Divider(
                            indent: SizeConfig.widthMultiplier * 5,
                            endIndent: SizeConfig.widthMultiplier * 5,
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 1,
                          ),
                          GridView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const ScrollPhysics(),
                              itemCount: invoiceCount.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.75),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  radius: SizeConfig.widthMultiplier * 1,
                                  onTap: () {},
                                  child: SizedBox(
                                      child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                        gradient: LinearGradient(
                                            colors: [
                                              invoiceCount[index].gradColor1,
                                              invoiceCount[index].gradColor2
                                            ],
                                            begin: const FractionalOffset(
                                                0.0, 0.0),
                                            end: const FractionalOffset(
                                                1.0, 0.0),
                                            stops: const [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            SizeConfig.widthMultiplier * 2),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "",
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 3.5 *
                                                          SizeConfig
                                                              .textMultiplier,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  invoiceCount[index].title,
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 3 *
                                                        SizeConfig
                                                            .textMultiplier,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                                );
                              }),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              ),
                              Text(
                                "Outstanding Summary Total",
                                style: GoogleFonts.montserrat(
                                  fontSize: 2.5 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.colors.foscherblue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 1,
                          ),
                          InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(10),
                            radius: SizeConfig.widthMultiplier * 1,
                            child: SizedBox(
                                width: SizeConfig.widthMultiplier * 100,
                                height: SizeConfig.widthMultiplier * 32,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Container(
                                    width: SizeConfig.widthMultiplier * 100,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      gradient: LinearGradient(
                                          colors: [
                                            AppTheme
                                                .colors.dashBoardGradientC11,
                                            AppTheme.colors.dashBoardGradientC1,
                                          ],
                                          begin:
                                              const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          stops: const [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          SizeConfig.widthMultiplier * 1),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: SizedBox(
                                            width:
                                                SizeConfig.widthMultiplier * 95,
                                            height:
                                                SizeConfig.widthMultiplier * 32,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: 5,
                                                itemBuilder: (context, index) {
                                                  return SizedBox(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          " " + " ",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 2.2 *
                                                                SizeConfig
                                                                    .textMultiplier,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: SizeConfig
                                                                  .widthMultiplier *
                                                              10,
                                                          child: const Divider(
                                                            color: Colors.white,
                                                          ),
                                                          width: SizeConfig
                                                                  .widthMultiplier *
                                                              20,
                                                        ),
                                                        Text(
                                                          " " + " ",
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 2.2 *
                                                                SizeConfig
                                                                    .textMultiplier,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color: Colors.white,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                })),
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 5,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              ),
                              Text(
                                "Month Wise \nSales & Quantity Comparsion",
                                style: GoogleFonts.montserrat(
                                  fontSize: 2.5 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.colors.foscherblue,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 2,
                              ),
                              Text(
                                "(Select graph type to see graph data.)",
                                style: GoogleFonts.montserrat(
                                  fontSize: 2 * SizeConfig.textMultiplier,
                                  fontWeight: FontWeight.w400,
                                  color: AppTheme.colors.foscherblue,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.widthMultiplier * 1,
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.white,
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  width: SizeConfig.widthMultiplier * 100,
                                  child: Column(children: [
                                    //Initialize the chart widget
                                    SfCartesianChart(
                                        primaryXAxis: CategoryAxis(),
                                        legend: Legend(isVisible: true),
                                        enableAxisAnimation: true,
                                        // Enable tooltip
                                        tooltipBehavior:
                                            TooltipBehavior(enable: true),
                                        series: <
                                            ChartSeries<_SalesData, String>>[
                                          LineSeries<_SalesData, String>(
                                              dataSource: salesData,
                                              xValueMapper:
                                                  (_SalesData sales, _) =>
                                                      sales.month,
                                              yValueMapper:
                                                  (_SalesData sales, _) =>
                                                      sales.sales,
                                              name: 'Sales',
                                              color:
                                                  AppTheme.colors.foscherblue,
                                              // Enable data label
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                      isVisible: true)),
                                          LineSeries<_SalesData, String>(
                                              dataSource: qtyData,
                                              xValueMapper:
                                                  (_SalesData sales, _) =>
                                                      sales.month,
                                              yValueMapper:
                                                  (_SalesData sales, _) =>
                                                      sales.sales,
                                              name: 'Quantity',
                                              color:
                                                  AppTheme.colors.foschercherry,
                                              // Enable data label
                                              dataLabelSettings:
                                                  const DataLabelSettings(
                                                      isVisible: true)),
                                        ]),
                                  ])),
                            ),
                          ),
                        ],
                      )
                    ]))))));
  }

  cropImage(
      String filePath, loginId, password, apiKey, BuildContext context) async {
    CroppedFile? croppedImage = await imgCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 750,
        maxHeight: 750,
        uiSettings: [
          AndroidUiSettings(
              toolbarColor: AppTheme.colors.foscherblue,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings()
        ]);

    if (croppedImage != null) {
      imageList.add(croppedImage.path);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
              height: SizeConfig.widthMultiplier * 32,
              child: Column(children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(
                    "Camera",
                    style: GoogleFonts.montserrat(
                      fontSize: 2.3 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                    // show the camera

                    _showCamera();
                    // return snackBarWidget(context, "Image Limit Reached",
                    //     Icons.warning_rounded, Colors.red, 1);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(
                    "Choose from Gallery",
                    style: GoogleFonts.montserrat(
                      fontSize: 2.3 * SizeConfig.textMultiplier,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    _showPhotoLibrary(context, 100);
                    // return snackBarWidget(context, "Image Limit Reached",
                    //     Icons.warning_rounded, Colors.red, 1);
                  },
                )
              ]));
        });
  }

  void _showCamera() async {
    final _picker = ImagePicker();

    await _picker.pickImage(source: ImageSource.camera).then((value) {
      cropImage(value!.path, loginId, password, apiKey, context);
    });
  }

  _showPhotoLibrary(context, int? quality) async {
    try {
      await _picker
          .pickImage(
        source: ImageSource.gallery,
        imageQuality: quality,
      )
          .then((value) {
        cropImage(value!.path, loginId, password, apiKey, context);
      });
    } catch (e) {
      setState(() {});
    }
  }
}

class _SalesData {
  final String month;

  final double sales;
  _SalesData(this.month, this.sales);
}
