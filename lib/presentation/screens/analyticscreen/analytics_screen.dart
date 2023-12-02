import 'package:expense_tracker/data/data_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key, required this.analyticdata});
  final List<DataAnalyticsData> analyticdata;

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  TooltipBehavior? _tooltipBehavior;
  @override
  void initState() {
    super.initState();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: widget.analyticdata.length == 1
          ? Center(
              child: Text(
                'Not much data to show analytics',
                style: TextStyle(
                  fontSize: 15,
                  color: Theme.of(context).colorScheme.inverseSurface,
                ),
              ),
            )
          : Center(
              child: SizedBox(
                child: SfCartesianChart(
                  title: ChartTitle(text: 'Yearly expenses analysis'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis: DateTimeAxis(
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                      intervalType: DateTimeIntervalType.years),
                  primaryYAxis: NumericAxis(
                    numberFormat:
                        NumberFormat.currency(locale: 'en_In', symbol: "₹"),
                  ),
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<DataAnalyticsData, DateTime>(
                      name: 'Yearly Expenses',
                      dataSource: widget.analyticdata.reversed.toList(),
                      xValueMapper: (datum, _) =>
                          DateTime(DateTime.now().year - datum.year),
                      yValueMapper: (datum, _) => datum.totalamt,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      xAxisName: 'Total Expense',
                      yAxisName: 'Year',
                      enableTooltip: true,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
