import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() => runApp(DrillDown());

class DrillDown extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drilldown Pie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

dynamic chart;

class _MyHomePageState extends State<MyHomePage> {
  bool isDrilledChart = false;
  @override
  void initState() {
    getDefaultChart();
    super.initState();
  }

  num getRandomInt(int min, int max) {
    final Random random = Random();
    return min + random.nextInt(max - min);
  }

  void getDrilledChart(num index) {
    isDrilledChart = true;
    if (index % 2 == 0) {
      setState(() {
        chart = SfCartesianChart(
            backgroundColor: Colors.white,
            primaryXAxis: CategoryAxis(),
            series: <ColumnSeries<SalesData, String>>[
              ColumnSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Peter', getRandomInt(15, 23)),
                    SalesData('Mark', getRandomInt(4, 20)),
                    SalesData('Lucifer', getRandomInt(10, 35)),
                    SalesData('Jack', getRandomInt(10, 50)),
                    SalesData('jacob', getRandomInt(6, 43))
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]);
      });
    } else {
      setState(() {
        chart = SfCartesianChart(
            backgroundColor: Colors.white,
            primaryXAxis: CategoryAxis(),
            series: <ColumnSeries<SalesData, String>>[
              ColumnSeries<SalesData, String>(
                  dataSource: <SalesData>[
                    SalesData('Peter', getRandomInt(15, 23)),
                    SalesData('Mark', getRandomInt(4, 20)),
                    SalesData('Lucifer', getRandomInt(10, 35)),
                    SalesData('Jack', getRandomInt(10, 50)),
                    SalesData('jacob', getRandomInt(6, 43))
                  ],
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales,
                  // Enable data label
                  dataLabelSettings: DataLabelSettings(isVisible: true))
            ]);
      });
    }
  }

  void getDefaultChart() {
    isDrilledChart = false;
    chart = SfCircularChart(
        backgroundColor: Colors.white,
        title: ChartTitle(text: 'Sales Analysis'),
        legend: Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: false),
        series: <CircularSeries<SalesData, String>>[
          PieSeries<SalesData, String>(
              animationDuration: 0,
              onPointTap: (ChartPointDetails pointInteractionDetails) {
                getDrilledChart(pointInteractionDetails.pointIndex!);
              },
              dataSource: chartData,
              xValueMapper: (SalesData sales, _) => sales.year,
              yValueMapper: (SalesData sales, _) => sales.sales)
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Drilldown Pie'),
        ),
        body: Column(
          children: <Widget>[
            Visibility(
              visible: isDrilledChart,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() {
                    getDefaultChart();
                  });
                },
              ),
            ),
            Container(height: 450, child: chart),
          ],
        ));
  }

  static dynamic chartData = <SalesData>[
    SalesData('Jan', 1000),
    SalesData('Feb', 2500),
    SalesData('Mar', 760),
    SalesData('Apr', 1897),
    SalesData('May', 2987)
  ];
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final num sales;
}
