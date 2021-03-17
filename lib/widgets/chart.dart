import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionChart extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionChart(this.transactions);

  List<Map<String, Object>> groupedTransactionValues() {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      int totalSum = 0;

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    List<charts.Series<dynamic, String>> series = [
      charts.Series(
          id: 'Transation',
          data: groupedTransactionValues(),
          domainFn: (series, _) => series['day'],
          measureFn: (series, _) => series['amount'],
          colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
          labelAccessorFn: (series, _) => "¥${series['amount']}"),
    ];

    return charts.BarChart(
      series,
      animate: true,
      barRendererDecorator: charts.BarLabelDecorator<String>(
          outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 8)),
    );
  }
}
