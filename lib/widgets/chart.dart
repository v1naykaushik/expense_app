import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transactions> transactionsList;
  Chart(this.transactionsList);
  var weekDay = DateTime.now();
  double combinedAmount = 0.0;

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      weekDay = DateTime.now().subtract(Duration(days: index));
      combinedAmount = 0.0;
      for (var i = 0; i < transactionsList.length; i++) {
        if (transactionsList[i].date.day == weekDay.day &&
            transactionsList[i].date.month == weekDay.month &&
            transactionsList[i].date.year == weekDay.year) {
          combinedAmount += transactionsList[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 2),
        'amount': combinedAmount
      };
    }).reversed.toList();
  }

  double get sumOfWeekAmount {
    /* double sumAmount = 0.0;
    groupedTransactionValues.forEach((element) {
      sumAmount += ((element['amount']) as double);
    });
    return sumAmount; */
    return groupedTransactionValues.fold(0.0, (sum, element) {
      return sum + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    //print('${DateFormat.E().format(weekDay).substring(0, 2)} : $combinedAmount : $sumOfWeekAmount');
    //print(groupedTransactionValues);
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              //flex: 1,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  sumOfWeekAmount == 0
                      ? 0.0
                      : ((data['amount'] as double) / sumOfWeekAmount)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
