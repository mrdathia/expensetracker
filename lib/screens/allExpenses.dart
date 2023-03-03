import 'dart:math' as math;
import 'package:expensetracker/screens/pie.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../utils/appTools.dart';
import '../utils/styleConstants.dart';

class AllExpenses extends StatefulWidget {
  @override
  State<AllExpenses> createState() => _AllExpensesState();
}

class _AllExpensesState extends State<AllExpenses> {
  final dataMap = <String, double>{
    "Flutter": 5000,
    "React": 300,
    "Xamarin": 2456,
    "Ionic": 2332,
  };

  final legendLabels = <String, String>{
    "Flutter": "Flutter legend",
    "React": "React legend",
    "Xamarin": "Xamarin legend",
    "Ionic": "Ionic legend",
  };

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1.0),
      const Color.fromRGBO(254, 154, 92, 1),
    ]
  ];
  ChartType? _chartType = ChartType.disc;
  bool _showCenterText = true;
  double? _ringStrokeWidth = 32;
  double? _chartLegendSpacing = 32;

  bool _showLegendsInRow = false;
  bool _showLegends = true;
  bool _showLegendLabel = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = false;
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape? _legendShape = LegendShape.circle;
  LegendPosition? _legendPosition = LegendPosition.right;

  int key = 0;

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pop();
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: hexToColor("#121212"),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Daily Expenses",
                    style: kGoogleStyleTexts.copyWith(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                PieChart(
                  key: ValueKey(key),
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 1500),
                  chartLegendSpacing: _chartLegendSpacing!,
                  chartRadius:
                      math.min(MediaQuery.of(context).size.width / 1.2, 300),
                  colorList: colorList,
                  initialAngleInDegree: 0,
                  chartType: _chartType!,
                  centerText: _showCenterText ? "Expenses" : null,
                  legendLabels: _showLegendLabel ? legendLabels : {},
                  legendOptions: LegendOptions(
                    showLegendsInRow: _showLegendsInRow,
                    legendPosition: _legendPosition!,
                    showLegends: _showLegends,
                    legendShape: _legendShape == LegendShape.circle
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    legendTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: ChartValuesOptions(
                    showChartValueBackground: _showChartValueBackground,
                    showChartValues: _showChartValues,
                    showChartValuesInPercentage: _showChartValuesInPercentage,
                    showChartValuesOutside: _showChartValuesOutside,
                  ),
                  ringStrokeWidth: _ringStrokeWidth!,
                  emptyColor: Colors.grey,
                  gradientList: _showGradientColors ? gradientList : null,
                  emptyColorGradient: const [
                    Color(0xff6c5ce7),
                    Colors.blue,
                  ],
                  baseChartColor: Colors.transparent,
                ),
                SizedBox(
                  height: 500,
                  child: Expanded(
                    child: SingleChildScrollView(
                      child: LayoutBuilder(
                        builder: (context, BoxConstraints) {
                          return Column(
                            children: [
                              SwitchListTile(
                                value: _showGradientColors,
                                title: Text(
                                  "Show Gradient Colors",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showGradientColors = val;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Pie Chart Options'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "chartType",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: DropdownButton<ChartType>(
                                    value: _chartType,
                                    dropdownColor: hexToColor("#121212"),
                                    items: [
                                      DropdownMenuItem(
                                        value: ChartType.disc,
                                        child: Text(
                                          "disc",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: ChartType.ring,
                                        child: Text(
                                          "ring",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      setState(() {
                                        _chartType = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "ringStrokeWidth",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: DropdownButton<double>(
                                    value: _ringStrokeWidth,
                                    disabledHint: Text(
                                      "select chartType.ring",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    dropdownColor: hexToColor("#121212"),
                                    items: [
                                      DropdownMenuItem(
                                        value: 16,
                                        child: Text(
                                          "16",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 32,
                                        child: Text(
                                          "32",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 48,
                                        child: Text(
                                          "48",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                    onChanged: (_chartType == ChartType.ring)
                                        ? (val) {
                                            setState(() {
                                              _ringStrokeWidth = val;
                                            });
                                          }
                                        : null,
                                  ),
                                ),
                              ),
                              SwitchListTile(
                                value: _showCenterText,
                                title: Text(
                                  "showCenterText",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showCenterText = val;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                  "chartLegendSpacing",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<double>(
                                    value: _chartLegendSpacing,
                                    disabledHint: Text(
                                      "select chartType.ring",
                                      style: kGoogleStyleTexts.copyWith(
                                          color: Colors.white,
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    dropdownColor: hexToColor("#121212"),
                                    items: [
                                      DropdownMenuItem(
                                        value: 16,
                                        child: Text(
                                          "16",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 32,
                                        child: Text(
                                          "32",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 48,
                                        child: Text(
                                          "48",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: 64,
                                        child: Text(
                                          "64",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      setState(() {
                                        _chartLegendSpacing = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Legend Options'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              SwitchListTile(
                                value: _showLegends,
                                title: Text(
                                  "showLegends",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showLegends = val;
                                  });
                                },
                              ),
                              SwitchListTile(
                                value: _showLegendsInRow,
                                title: Text(
                                  "showLegendsInRow",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showLegendsInRow = val;
                                  });
                                },
                              ),
                              SwitchListTile(
                                value: _showLegendLabel,
                                title: Text(
                                  "showLegendLabels",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showLegendLabel = val;
                                  });
                                },
                              ),
                              ListTile(
                                title: Text(
                                  "legendShape",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<LegendShape>(
                                    value: _legendShape,
                                    dropdownColor: hexToColor("#121212"),
                                    items: [
                                      DropdownMenuItem(
                                        value: LegendShape.circle,
                                        child: Text(
                                          "BoxShape.circle",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: LegendShape.rectangle,
                                        child: Text(
                                          "BoxShape.rectangle",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      setState(() {
                                        _legendShape = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "legendPosition",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<LegendPosition>(
                                    value: _legendPosition,
                                    dropdownColor: hexToColor("#121212"),
                                    items: [
                                      DropdownMenuItem(
                                        value: LegendPosition.left,
                                        child: Text(
                                          "left",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: LegendPosition.right,
                                        child: Text(
                                          "right",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: LegendPosition.top,
                                        child: Text(
                                          "top",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      DropdownMenuItem(
                                        value: LegendPosition.bottom,
                                        child: Text(
                                          "bottom",
                                          style: kGoogleStyleTexts.copyWith(
                                              color: Colors.white,
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      setState(() {
                                        _legendPosition = val;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  'Chart values Options'.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall!
                                      .copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                              SwitchListTile(
                                value: _showChartValueBackground,
                                title: Text(
                                  "showChartValueBackground",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showChartValueBackground = val;
                                  });
                                },
                              ),
                              SwitchListTile(
                                value: _showChartValues,
                                title: Text(
                                  "showChartValues",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showChartValues = val;
                                  });
                                },
                              ),
                              SwitchListTile(
                                value: _showChartValuesInPercentage,
                                title: Text(
                                  "showChartValuesInPercentage",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showChartValuesInPercentage = val;
                                  });
                                },
                              ),
                              SwitchListTile(
                                value: _showChartValuesOutside,
                                title: Text(
                                  "showChartValuesOutside",
                                  style: kGoogleStyleTexts.copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    _showChartValuesOutside = val;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
