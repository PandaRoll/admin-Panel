// ignore_for_file: must_be_immutable, unnecessary_new

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'config/app_theme.dart';
import 'config/size_config.dart';

late DataGridCell listcell;

class EmployeeDataSource extends DataGridSource {
  List<DataGridRow> _employeeData = [];

  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<dynamic> employeeData}) {
    for (int i = 0; i < employeeData.length; i++) {
      String rowData = employeeData[i]['value'];

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

  List<DataGridCell> dataTableColumnValueSetter(List<dynamic> data, int index) {
    return List.generate(data.length, (i) {
      String rowData = data[i]['value'];

      List<String> rowDataList = [];

      rowDataList = rowData.split(" ");

      listcell = DataGridCell<String>(
          columnName: data[i]['title'], value: rowDataList[index]);

      return listcell;
    });
  }
}

class ReportMobile extends StatefulWidget {
  const ReportMobile({Key? key}) : super(key: key);

  @override
  State<ReportMobile> createState() => _ReportMobileState();
}

class _ReportMobileState extends State<ReportMobile> {
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

  ////////////////////////////////////////////////////////////////
  var dataJson = [
    {
      'title': 'Colour',
      'value': 'Red Orange Yellow Blue Black',
    },
    {
      'title': 'Product',
      'value': 'Shoes Bags Coats Jacket Slippers',
    },
    {
      'title': 'Price',
      'value': '₹100 ₹1200 ₹300 ₹400 ₹1600',
    },
  ];
  final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();
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
                  SizedBox(
                      child: SfDataGridTheme(
                    data: SfDataGridThemeData(
                        gridLineColor: AppTheme.colors.foscherblue,
                        gridLineStrokeWidth: 1.0),
                    child: SfDataGrid(
                        allowMultiColumnSorting: true,
                        allowTriStateSorting: true,
                        showSortNumbers: true,
                        allowSorting: true,
                        allowColumnsResizing: true,
                        source: EmployeeDataSource(employeeData: (dataJson)),
                        columnWidthMode: ColumnWidthMode.fill,
                        // shrinkWrapRows: true,
                        selectionMode: SelectionMode.singleDeselect,
                        verticalScrollPhysics:
                            const NeverScrollableScrollPhysics(),
                        columns: dataTableColumnHeaderSetter(
                          (dataJson),
                        )),
                  )),
                  // Card(
                  //     child: NumberPaginator(
                  //   numberPages: 10,
                  //   onPageChange: (int index) {
                  //     setState(() {});
                  //   },
                  //   // initially selected index
                  //   initialPage: 0,
                  //   // default height is 48
                  //   height: (SizeConfig.widthMultiplier * 14),
                  //   buttonShape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(8),
                  //   ),
                  //   buttonSelectedForegroundColor: Colors.white,
                  //   buttonUnselectedForegroundColor:
                  //       AppTheme.colors.foscherblue,
                  //   buttonUnselectedBackgroundColor: Colors.white,
                  //   buttonSelectedBackgroundColor: AppTheme.colors.foscherblue,
                  // )),
                  TextButton(onPressed: (){
                    
                  }, child: Text("Click"))
                ],
        
              ),
            ),
          )),
    );
  }
  List<GridColumn> dataTableColumnHeaderSetter(List<dynamic> data) {
    return List.generate(data.length, (i) {
      return GridColumn(
          columnName: data[i]['title'],
          label: Container(
              padding: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.centerLeft,
              child: Text(
                data[i]['title'],
                // textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  fontSize: 2.2 * SizeConfig.textMultiplier,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.colors.foscherblue,
                ),
              )));
    });
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

  @override
  void initState() {
    super.initState();
  }
}
