import 'package:finance_manager/model/transaction.dart';
import 'package:finance_manager/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart({required this.recentTransactions});

  List<Map<String,Object>> get groupedTransactionValue{
    return List.generate(7, (index){
        final weekDay=DateTime.now().subtract(Duration(days: index));
        double totalSum=recentTransactions.fold(0, (double previousValue,Transaction tnx){
          if(tnx.date.day==weekDay.day && tnx.date.month==weekDay.month && tnx.date.year==weekDay.year){
            return previousValue+=tnx.amount;
          }else
            return previousValue;
        });
        return {'day':DateFormat.E().format(weekDay),'amount':totalSum};
  }).reversed.toList(growable: false);
  }

  double get totalSpending{
    return recentTransactions.fold(0, (double previousValue,Transaction tnx){
        return previousValue+=tnx.amount;
    });
  }
  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValue);
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValue.map((data){
              return ChartBar(label: data['day'] as String,spendingAmount: data['amount'] as double,totalSpending: totalSpending,);
            }).toList(),
        ),
      ),
    );
  }
}
