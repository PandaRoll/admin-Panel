// ignore_for_file: must_be_immutable, unnecessary_new

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'config/app_theme.dart';
import 'config/size_config.dart';

class ReportMobile extends StatefulWidget {
  const ReportMobile({Key? key}) : super(key: key);

  @override
  State<ReportMobile> createState() => _ReportMobileState();
}

class _ReportMobileState extends State<ReportMobile> {
  @override
  void initState() {
    super.initState();
  }

  Widget? dateErrorNotif(errorDate) {
    if (errorDate) {
      return Text(
        "From and To dates required!",
        style: GoogleFonts.montserrat(
          fontSize: 2 * SizeConfig.textMultiplier,
          fontWeight: FontWeight.normal,
          color: Colors.red,
        ),
      );
    }
    return null;
  }

  String customerName = "", selectedCustomerName = "";

  bool errorDate = false;
  final TextEditingController toDateController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();

  String loginId = "", custId = "", apiKey = "";

  String dp = "";

  String password = "";

  bool changeDP = false;
  String userName = "";
  String userType = "";

  late bool connectivity;

  final RefreshController refreshController =
      RefreshController(initialRefresh: false);
  final GlobalKey refresherKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    var customerList;
    var dashBoardItems;
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
              "Report",
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: SizeConfig.widthMultiplier * 100,
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  elevation: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: SizeConfig.widthMultiplier *
                                                2.5),
                                        child: Text(
                                          "Customer List",
                                          style: GoogleFonts.montserrat(
                                              fontSize: 2.2 *
                                                  SizeConfig.textMultiplier,
                                              fontWeight: FontWeight.w500,
                                              color:
                                                  AppTheme.colors.foscherblue),
                                        ),
                                      ),
                                      SizedBox(
                                        height: SizeConfig.widthMultiplier * 15,
                                        width: SizeConfig.widthMultiplier * 90,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          elevation: 1,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: Center(
                                                  child: DropdownButton<String>(
                                                    items: customerList
                                                        .map((item) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: (item.id),
                                                        child: Row(
                                                          children: [
                                                            const Icon(
                                                                Icons.people),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Flexible(
                                                              child: Text(
                                                                item.customerName
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style: GoogleFonts.montserrat(
                                                                    fontSize: 1.9 *
                                                                        SizeConfig
                                                                            .textMultiplier,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    color: AppTheme
                                                                        .colors
                                                                        .foscherblue),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }).toList(),
                                                    isExpanded: true,
                                                    hint: Text(
                                                      "Loading...",
                                                      style: GoogleFonts.montserrat(
                                                          fontSize: 1.8 *
                                                              SizeConfig
                                                                  .textMultiplier,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: AppTheme.colors
                                                              .foscherblue),
                                                    ),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        customerName = value!;
                                                        selectedCustomerName =
                                                            customerName;
                                                      });
                                                    },
                                                    value: selectedCustomerName,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: SizeConfig.widthMultiplier * 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 30,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: fromDateController,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppTheme.colors.foscherblue),
                                        ),
                                        labelText: 'From Date',
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize:
                                                2.2 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.colors.foscherblue),
                                      ),
                                      onTap: () async {
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        ).then((selectedDate) {
                                          if (selectedDate != null) {
                                            fromDateController.text =
                                                DateFormat('yyyy-MM-dd')
                                                    .format(selectedDate);
                                          }
                                        });
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty || value.isEmpty) {
                                          setState(() {
                                            errorDate = true;
                                          });
                                          return '';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.widthMultiplier * 30,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: toDateController,
                                      decoration: InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppTheme.colors.foscherblue),
                                        ),
                                        labelText: 'To Date',
                                        labelStyle: GoogleFonts.montserrat(
                                            fontSize:
                                                2.2 * SizeConfig.textMultiplier,
                                            fontWeight: FontWeight.w500,
                                            color: AppTheme.colors.foscherblue),
                                      ),
                                      onTap: () async {
                                        await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100),
                                        ).then(
                                          (selectedDate) {
                                            if (selectedDate != null) {
                                              toDateController.text =
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate);
                                            }
                                          },
                                        );
                                      },
                                      validator: (value) {
                                        if (value!.isEmpty || value.isEmpty) {
                                          setState(() {
                                            errorDate = true;
                                          });
                                          return '';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.widthMultiplier * 5,
                            ),
                            Container(
                              width: SizeConfig.widthMultiplier * 30,
                              height: SizeConfig.widthMultiplier * 11,
                              decoration: BoxDecoration(
                                color: AppTheme.colors.foscherblue,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: MaterialButton(
                                onPressed: () async {},
                                child: Text(
                                  "Save",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 2 * SizeConfig.textMultiplier,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                        gridLineColor: AppTheme.colors.foscherblue,
                        gridLineStrokeWidth: 1.0),
                    child: SfDataGrid(
                      source: EmployeeDataSource(
                          employeeData: dashBoardItems!.oSsummary),
                      columnWidthMode: ColumnWidthMode.fitByCellValue,
                      shrinkWrapRows: true,
                      selectionMode: SelectionMode.singleDeselect,
                      verticalScrollPhysics:
                          const NeverScrollableScrollPhysics(),
                      columns: dataTableColumnHeaderSetter(
                          dashBoardItems!.oSsummary),
                    ),
                  )),
                  Card(
                      child: NumberPaginator(
                    numberPages: 10,
                    onPageChange: (int index) {
                      setState(() {});
                    },
                    // initially selected index
                    initialPage: 0,
                    // default height is 48
                    height: (SizeConfig.widthMultiplier * 14),
                    buttonShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    buttonSelectedForegroundColor: Colors.white,
                    buttonUnselectedForegroundColor:
                        AppTheme.colors.foscherblue,
                    buttonUnselectedBackgroundColor: Colors.white,
                    buttonSelectedBackgroundColor: AppTheme.colors.foscherblue,
                  )),
                ],
              ),
            ),
          )),
    );
  }

////////////////////////////////////////////////////////////////

  List<GridColumn> dataTableColumnHeaderSetter(List<dynamic> summary) {
    return List.generate(summary.length, (i) {
      return GridColumn(
          columnName: summary[i].head,
          label: Container(
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                summary[i].head,
                // textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 2.2 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.colors.foscherblue,
                ),
              )));
    });
  }
}

late DataGridCell listcell;

class EmployeeDataSource extends DataGridSource {
  List<DataGridCell> dataTableColumnValueSetter(
      List<dynamic> summary, int index) {
    return List.generate(summary.length, (i) {
      String rowData = summary[i].value;

      List<String> rowDataList = [];

      rowDataList = rowData.split(" ");

      listcell = DataGridCell<String>(
          columnName: summary[i].head, value: rowDataList[index]);

      return listcell;
    });
  }

  List<DataGridRow> _employeeData = [];

  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<dynamic> employeeData}) {
    for (int i = 0; i < employeeData.length; i++) {
      String rowData = employeeData[i].value;

      List<String> rowDataList = [];

      rowDataList = rowData.split(" ");
      _employeeData = rowDataList
          .mapIndexed((index, details) => DataGridRow(
              cells: dataTableColumnValueSetter(employeeData, index)))
          .toList();
    }
  }

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          e.value.toString(),
          style: GoogleFonts.montserrat(
            fontSize: 2.2 * SizeConfig.textMultiplier,
            fontWeight: FontWeight.normal,
            color: AppTheme.colors.foscherblue,
          ),
        ),
      );
    }).toList());
  }
}
