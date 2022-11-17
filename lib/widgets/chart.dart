import 'package:budget/models/transactions.dart';
import 'package:budget/widgets/chartwidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyWidget1 extends StatelessWidget {
  final List<Transactions> recentTs;
  MyWidget1(this.recentTs);
  List<Map<String, Object>> get groupedTVals {
    return List.generate(7, (index) {
      final weekD = DateTime.now().subtract(
        Duration(days: index),
      );
      var tsum = 0.0;
      for (var i = 0; i < recentTs.length; i++) {
        if (recentTs[i].date.day == weekD.day &&
            recentTs[i].date.month == weekD.month &&
            recentTs[i].date.year == weekD.year) {
          tsum += recentTs[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekD).substring(0, 2),
        'amount': tsum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTVals.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTVals.map((data) {
          return Flexible(
            fit: FlexFit.tight,
            child: Cbar(
                data['day'].toString(),
                (data['amount'] as double),
                maxSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / maxSpending),
          );
        }).toList()),
      ),
    );
  }
}
