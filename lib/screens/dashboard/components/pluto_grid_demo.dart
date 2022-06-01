import 'dart:convert';
import 'dart:io';

import 'package:admin/responsive.dart';
import 'package:admin/screens/config/size_config.dart';
import 'package:admin/screens/dashboard/components/dynamic_button_widget.dart';
import 'package:admin/screens/dashboard/components/dynamic_filter_widget.dart';
import 'package:admin/screens/dashboard/report_data.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pluto_grid/pluto_grid.dart';

dynamic headerJson = [
  {
    'title': 'DOCNO',
    'field': 'DOCNO',
    'type': 'text',
    'textAlign': 'right',
    'width': 0.0,
  },
  {
    'title': 'PROJECTCODE',
    'field': 'PROJECTCODE',
    'type': 'select',
    'textAlign': 'left',
    'width': 200.0,
    'data': [100, 101, 102]
  },
  {
    'title': 'PROJECTNAME',
    'field': 'PROJECTNAME',
    'type': 'text',
    'textAlign': 'left',
    'width': 200.0,
  },
  {
    'title': 'STARTDATE',
    'field': 'STARTDATE',
    'type': 'date',
    'textAlign': 'left',
    'width': 200.0,
  },
  {
    'title': 'ENDDATE',
    'field': 'ENDDATE',
    'type': 'date',
    'textAlign': 'left',
    'width': 200.0,
  },
  {
    'title': 'CUSTOMERNAME',
    'field': 'CUSTOMERNAME',
    'type': 'text',
    'textAlign': 'left',
    'width': 200.0,
  },
  {
    'title': 'ADDRESS',
    'field': 'ADDRESS',
    'type': 'text',
    'textAlign': 'left',
    'width': 200.0,
  },
  {
    'title': 'CONTRACTVALUE',
    'field': 'CONTRACTVALUE',
    'type': 'text',
    'textAlign': 'right',
    'width': 200.0,
  },
  {
    'title': 'PLOTNO',
    'field': 'PLOTNO',
    'type': 'text',
    'textAlign': 'right',
    'width': 200.0,
  },
  {
    'title': 'ASSIGNED USERS',
    'field': 'ASSIGNED USERS',
    'type': 'text',
    'textAlign': 'left',
    'width': 200.0,
  },
  {
    'title': 'TYPE',
    'field': 'TYPE',
    'type': 'button',
    'textAlign': 'left',
    'width': 200.0,
    'data': [
      {
        'type': 'text_button',
        'color': 'red',
        'action': '',
        'content': 'Delete',
      },
      // {
      //   'type': 'text_button',
      //   'color': 'green',
      //   'action': '',
      //   'content': 'Approve',
      // },
      {
        'type': 'icon_button',
        'color': 'blue',
        'action': '',
        'content': 'icon_save',
      },
    ],
  },
];
// List<PlutoColumn> columns = [
//   /// Text Column definition
//   PlutoColumn(
//     title: 'text column',
//     field: 'text_field',
//     type: PlutoColumnType.text(),
//   ),

//   /// Number Column definition
//   PlutoColumn(
//     title: 'number column',
//     field: 'number_field',
//     type: PlutoColumnType.number(),
//   ),

//   /// Select Column definition
//   PlutoColumn(
//     title: 'select column',
//     field: 'select_field',
//     type: PlutoColumnType.select(['item1', 'item2', 'item3']),
//   ),

//   /// Datetime Column definition
//   PlutoColumn(
//     title: 'date column',
//     field: 'date_field',
//     type: PlutoColumnType.date(),
//   ),

//   /// Time Column definition
//   PlutoColumn(
//     title: 'time column',
//     field: 'time_field',
//     type: PlutoColumnType.time(),
//   ),
// ];
dynamic widthJson = {
  'ADDRESS': 200.0,
  'TYPE': 200.0,
};
// List<PlutoRow> rows = [
//   PlutoRow(
//     cells: {
//       'text_field': PlutoCell(value: 'Text cell value1'),
//       'number_field': PlutoCell(value: 2020),
//       'select_field': PlutoCell(value: 'item1'),
//       'date_field': PlutoCell(value: '2020-08-06'),
//       'time_field': PlutoCell(value: '12:30'),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'text_field': PlutoCell(value: 'Text cell value2'),
//       'number_field': PlutoCell(value: 2021),
//       'select_field': PlutoCell(value: 'item2'),
//       'date_field': PlutoCell(value: '2020-08-07'),
//       'time_field': PlutoCell(value: '18:45'),
//     },
//   ),
//   PlutoRow(
//     cells: {
//       'text_field': PlutoCell(value: 'Text cell value3'),
//       'number_field': PlutoCell(value: 2022),
//       'select_field': PlutoCell(value: 'item3'),
//       'date_field': PlutoCell(value: '2020-08-08'),
//       'time_field': PlutoCell(value: '23:59'),
//     },
//   ),
// ];

class ColumnHeaders {
  final String title;
  final String field;
  final String type;
  ColumnHeaders(this.title, this.type, this.field);
}

class PlutoGridDemo extends StatefulWidget {
  const PlutoGridDemo({Key? key}) : super(key: key);

  @override
  State<PlutoGridDemo> createState() => _PlutoGridDemoState();
}

class _PlutoGridDemoState extends State<PlutoGridDemo> {
  late PlutoGridStateManager _stateManager;

  bool isloading = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: Text("GRID"), actions: [
        if (Responsive.isMobile(context)) ...[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 500),
                          child: AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            insetPadding: EdgeInsets.zero,
                            backgroundColor: Colors.grey,
                            content: SizedBox(
                                width: SizeConfig.screenwidth,
                                // height: 500,
                                child: SingleChildScrollView(
                                    child: DynamicFilterWidget(data_json: ""))),
                          ),
                        );
                      });
                },
                child: Icon(Icons.filter_alt)),
          )
        ],
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                _defaultExportGridAsCSV();
              },
              child: Icon(Icons.import_export_rounded)),
        )
      ]),
      body: WillPopScope(
        onWillPop: () async {
          //   _stateManager.dispose();
          Navigator.pop(context);
          return true;
        },
        child: OrientationBuilder(builder: (context, orientation) {
          return SizedBox(
            height: orientation == Orientation.portrait
                ? SizeConfig.screenheight
                : SizeConfig.screenwidth,
            width: orientation == Orientation.portrait
                ? SizeConfig.screenwidth
                : SizeConfig.screenheight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!Responsive.isMobile(context))
                  DynamicFilterWidget(data_json: ""),
                Expanded(
                  child: PlutoGrid(
                    rows: getRows(
                        json.encode(headerJson), json.encode(report_data)),
                    columns: getColumns(
                        json.encode(headerJson), json.encode(widthJson)),
                    onRowDoubleTap: (event) {
                      print(event.row!.sortIdx.toString());
                    },
                    onRowChecked: (event) {
                      print(event.row!.sortIdx.toString());
                    },
                    onChanged: (PlutoGridOnChangedEvent event) {
                      //   print(event);
                    },
                    onLoaded: (PlutoGridOnLoadedEvent event) {
                      event.stateManager.setShowColumnFilter(true);
                      event.stateManager.notifyListeners();

                      // for (PlutoColumn column in event.stateManager.columns) {
                      //   if ((widthJson)[column.field] == null) {
                      //     event.stateManager.autoFitColumn(context, column);
                      //     event.stateManager.notifyListeners();
                      //   }
                      // }
                      setState(() {
                        isloading = false;
                      });
                      //print(event);
                    },
                    configuration: PlutoGridConfiguration(
                      enableColumnBorder: true,
                      iconColor: Colors.white,// pagination icons
                      gridBorderColor: Colors.white,
                      disabledIconColor: Colors.grey,// pagination icons
                      cellColorInEditState: Color.fromARGB(255, 1, 52, 94),//Filter fielld color
                      
                      gridBackgroundColor: Color(0xff212332),
                      cellTextStyle: TextStyle(color: Colors.white),
                      columnTextStyle: TextStyle(color: Colors.white),
                      enableGridBorderShadow: true,
                      menuBackgroundColor: Color(0xff222532),
                      activatedColor: Colors.blue, //selected row color
                      columnFilterConfig: PlutoGridColumnFilterConfig(
                        resolveDefaultColumnFilter: (column, resolver) {
                          // if (column.field == 'text') {
                          //   return resolver<PlutoFilterTypeContains>()
                          //       as PlutoFilterType;
                          // } else if (column.field == 'number') {
                          //   return resolver<PlutoFilterTypeGreaterThan>()
                          //       as PlutoFilterType;
                          // } else if (column.field == 'date') {
                          //   return resolver<PlutoFilterTypeLessThan>()
                          //       as PlutoFilterType;
                          // } else if (column.field == 'select') {
                          //   return resolver<ClassYouImplemented>() as PlutoFilterType;
                          // }
                          if (column.field == "date") {
                            return resolver<PlutoFilterTypeLessThan>()
                                as PlutoFilterType;
                          } else {
                            return resolver<PlutoFilterTypeContains>()
                                as PlutoFilterType;
                          }
                        },
                      ),
                    ),
                    createFooter: (stateManager) {
                      _stateManager = stateManager;

                      stateManager.setPageSize(20, notify: false); // default 40
                      return PlutoPagination(
                        stateManager,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    ));
  }

  getCells(jsonHeaders, jsonData) {
    var cells = [];
    Map<String, PlutoCell> map = {};
    for (int i = 0; i < jsonHeaders.length; i++) {
      var header = jsonHeaders[i]['field'];
      dynamic data = jsonData;

      map.addAll({header: PlutoCell(value: data[header] ?? "")});
    }

    return map;
  }

  List<PlutoColumn> getColumns(String headerJson, String widthJson) {
    dynamic jsonData = json.decode(headerJson);
    List<PlutoColumn> list =
        List<PlutoColumn>.generate(jsonData.length, (index) {
      return getPlutoColumn(jsonData[index], json.decode(widthJson));
    });
    return list;
  }

  PlutoColumn getPlutoColumn(jsonData, dynamic widthJson) {
    switch (jsonData['type']) {
      case ("button"):
        return PlutoColumn(
            width: (widthJson[jsonData['field']] == null ||
                    widthJson[jsonData['field']] == 0.0)
                ? PlutoGridSettings.columnWidth
                : widthJson[jsonData['field']],
            title: jsonData['title'],
            field: jsonData['field'],
            type: getType(
              jsonData['type'],
              jsonData['data'] ?? "",
            ),
            enableColumnDrag: false,
            enableContextMenu: false,
            renderer: (renderContext) {
              // return Row(
              //     mainAxisSize: MainAxisSize.max,
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: [
              // for (dynamic item in jsonData['data']) ...[
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: jsonData['data'].length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 2),
                      child: DynamicButton(
                        button_data: jsonData['data'][index],
                        onTap: (v) {
                          _stateManager.removeRows([renderContext.row]);
                        },
                      ),
                    );
                  });
              //  ]
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Icon(
              //     Icons.delete_forever,
              //     color: Colors.white,
              //   ),
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.red,
              //   ),
              // ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: Icon(
              //     Icons.check_outlined,
              //     color: Colors.white,
              //   ),
              //   style: ElevatedButton.styleFrom(primary: Colors.green),
              // ),
              // ],
              //);
            });
      case ("select"):
        return PlutoColumn(
            width: (widthJson[jsonData['field']] == null ||
                    widthJson[jsonData['field']] == 0.0)
                ? PlutoGridSettings.columnWidth
                : widthJson[jsonData['field']],
            title: jsonData['title'],
            field: jsonData['field'],
            type: getType(
              jsonData['type'],
              jsonData['data'] ?? "",
            ),
            enableEditingMode: true);
      default:
        return PlutoColumn(
            width: (widthJson[jsonData['field']] == null ||
                    widthJson[jsonData['field']] == 0.0)
                ? PlutoGridSettings.columnWidth
                : widthJson[jsonData['field']],
            title: jsonData['title'],
            field: jsonData['field'],
            enableFilterMenuItem: true,
            type: getType(
              jsonData['type'],
              jsonData['data'] ?? "",
            ),
            enableEditingMode: false,
            textAlign: jsonData['textAlign'] == 'right'
                ? PlutoColumnTextAlign.right
                : PlutoColumnTextAlign.left);
    }
  }

  getRows(String headerJson, String dataJson) {
    dynamic jsonHeaders = json.decode(headerJson);
    dynamic jsonData = json.decode(dataJson);
    List<PlutoRow> plutoRow = [];
    for (int index = 0; index < jsonData.length; index++) {
      plutoRow.add(PlutoRow(cells: getCells(jsonHeaders, jsonData[index])));
    }
    return plutoRow;
  }

  getType(String type, dynamic data) {
    switch (type) {
      case ("number"):
        return PlutoColumnType.number();
      case ("text"):
        return PlutoColumnType.text();
      case ("button"):
        return PlutoColumnType.text();
      case ("date"):
        return PlutoColumnType.date();
      case ("time"):
        return PlutoColumnType.time();
      case ("select"):
        return PlutoColumnType.select(data);
    }
  }

  void _defaultExportGridAsCSV() async {
    String title = "pluto_grid_export";
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    var exported =
        const Utf8Encoder().convert(PlutoExport.exportCSV(_stateManager));
    if (Platform.isAndroid) {
      File file =
          await File("/storage/emulated/0/Download/exported.csv").create();
      file.writeAsBytes(exported);
    }
    await FileSaver.instance.saveFile("$title.csv", exported, ".csv");
  }
}
