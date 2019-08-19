import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarChartSample1 extends StatefulWidget {
  String am;
  BarChartSample1(this.am);
  @override
  State<StatefulWidget> createState() => BarChartSample1State();

}

class BarChartSample1State extends State<BarChartSample1> {

  final Color barColor = Colors.white;
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final double width = 22;
  TextStyle estiloSmall = new TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: "TitiliumRegular");

  List<BarChartGroupData> rawBarGroups;
  List<BarChartGroupData> showingBarGroups;

  StreamController<BarTouchResponse> barTouchedResultStreamController;

  int touchedGroupIndex;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 6);
    final barGroup2 = makeGroupData(1, 7.0);
    final barGroup3 = makeGroupData(2, 8.2);
    final barGroup4 = makeGroupData(3, 9.5);
    final barGroup5 = makeGroupData(4, 10.0);
    final barGroup6 = makeGroupData(5, 11.5);
    final barGroup7 = makeGroupData(6, 12.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;

    barTouchedResultStreamController = StreamController();
    barTouchedResultStreamController.stream.distinct().listen((BarTouchResponse response) {
      if (response == null) {
        return;
      }

      if (response.spot == null) {
        setState(() {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
        });
        return;
      }

      touchedGroupIndex = showingBarGroups.indexOf(response.spot.touchedBarGroup);

      setState(() {
        if (response.touchInput is FlLongPressEnd) {
          touchedGroupIndex = -1;
          showingBarGroups = List.of(rawBarGroups);
        } else {
          showingBarGroups = List.of(rawBarGroups);
          if (touchedGroupIndex != -1) {
            showingBarGroups[touchedGroupIndex] = showingBarGroups[touchedGroupIndex].copyWith(
              barRods: showingBarGroups[touchedGroupIndex].barRods.map((rod) {
                return rod.copyWith(color: Colors.yellow, y: rod.y + 1);
              }).toList(),
            );
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.4,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Rendimento Aplicação Mínima R\$ ${widget.am}", style: estiloSmall,),
              SizedBox(
                height: 28,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: FlChart(
                    chart: BarChart(BarChartData(
                      barTouchData: BarTouchData(
                        touchTooltipData: TouchTooltipData(
                          tooltipBgColor: Colors.blueGrey,
                          getTooltipItems: (touchedSpots) {
                            return touchedSpots.map((touchedSpot) {
                              String weekDay;
                              switch (touchedSpot.spot.x.toInt()) {
                                case 0: weekDay = 'Monday'; break;
                                case 1: weekDay = 'Tuesday'; break;
                                case 2: weekDay = 'Wednesday'; break;
                                case 3: weekDay = 'Thursday'; break;
                                case 4: weekDay = 'Friday'; break;
                                case 5: weekDay = 'Saturday'; break;
                                case 6: weekDay = 'Sunday'; break;
                              }
                              return TooltipItem(weekDay + '\n' + touchedSpot.spot.y.toString(), TextStyle(color: Colors.yellow));
                            }).toList();
                          }
                        ),
                        touchResponseSink: barTouchedResultStreamController.sink,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          textStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                          margin: 16,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Jan';
                              case 1:
                                return 'Fev';
                              case 2:
                                return 'Mar';
                              case 3:
                                return 'Abr';
                              case 4:
                                return 'Mai';
                              case 5:
                                return 'Jun';
                              case 6:
                                return 'Jul';
                            }
                          }
                        ),
                        leftTitles: SideTitles(showTitles: false,),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      barGroups: showingBarGroups,
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(x: x, barRods: [
      BarChartRodData(
        y: y,
        color: barColor,
        width: width,
        isRound: true,
        backDrawRodData: BackgroundBarChartRodData(
          show: true,
          y: 20,
          color: barBackgroundColor,
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    barTouchedResultStreamController.close();
  }
}