library json_to_form;

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../responsive.dart';
import '../../config/size_config.dart';

class CardGrid extends StatelessWidget {
  final dynamic axisCount;
  final dynamic childAspectRatio;

  final dynamic item;

  const CardGrid({
    Key? key,
    required this.item,
    this.axisCount = 4,
    this.childAspectRatio = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: item['children'].length,
      itemBuilder: ((context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          elevation: 2,
          color:
              Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(.5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if ((item['children'][index]['title'] != "" &&
                          item['children'][index]['title'] != null)) ...[
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            child: Text(item['children'][index]['title'],
                                style: TextStyle(
                                    fontSize: SizeConfig.vmin * 3.2,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300)),
                          ),
                        ),
                      ],
                      if ((item['children'][index]['icon'] != "" &&
                          item['children'][index]['icon'] != null)) ...[
                        Image.network(
                          item['children'][index]['icon'],
                          width: SizeConfig.vw * 8,
                          // cacheHeight: 256,
                          // cacheWidth: 256,
                        ),
                      ]
                    ],
                  ),
                  if ((item['children'][index]['value'] != "" ||
                      item['children'][index]['value'] != null)) ...[
                    Text(item['children'][index]['value'],
                        style: TextStyle(
                            fontSize: SizeConfig.vmin * 3.8,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                  ],
                  if ((item['children'][index]['subtitle'] != "" &&
                      item['children'][index]['subtitle'] != null)) ...[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(item['children'][index]['subtitle'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: SizeConfig.vmin * 2,
                              color: Colors.white,
                              fontWeight: FontWeight.normal)),
                    ),
                  ]
                ],
              ),
            ),
          ),
        );
      }),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // maxCrossAxisExtent: SizeConfig.screenwidth,
          crossAxisCount: this.axisCount,
          childAspectRatio: this.childAspectRatio),
    );
  }
}

class CoreUiTranslator extends StatefulWidget {
  final String form;
  final dynamic formMap;

  const CoreUiTranslator({
    required this.form,
    this.formMap,
  });

  @override
  _CoreUiTranslatorState createState() =>
      new _CoreUiTranslatorState(formMap ?? json.decode(form));
}

class _CoreUiTranslatorState extends State<CoreUiTranslator> {
  final dynamic uiItems;

  int radioValue = -1;

  _CoreUiTranslatorState(this.uiItems);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: jsonToUI(),
      ),
    );
  }

  List<Widget> jsonToUI() {
    List<Widget> listWidget = [];

    for (var item in uiItems) {
      if (item['type'] == "Card") {
        listWidget.add(
          Responsive(
            mobile: CardGrid(
              item: item,
              axisCount: SizeConfig.screenwidth < 650 ? 2 : 3,
              childAspectRatio:
                  SizeConfig.screenwidth < 650 && SizeConfig.screenwidth > 350
                      ? 1.5
                      : 1.5,
            ),
            tablet: CardGrid(
              item: item,
            ),
            desktop: CardGrid(
                item: item,
                axisCount: SizeConfig.screenwidth > 1000 &&
                        SizeConfig.screenwidth < 1400
                    ? 3
                    : 4,
                childAspectRatio: SizeConfig.screenwidth < 1400 ? 1.1 : 1.4),
          ),
        );
      }
      if (item['type'] == "") {
        // listWidget.add();
      }

      if (item['type'] == "") {
        // listWidget.add();
      }
    }
    return listWidget;
  }
}
