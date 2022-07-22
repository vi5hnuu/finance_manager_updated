import 'package:flutter/material.dart';

/*
120 : total height
Total spending amount= x;
mon :mo <-total spending on monday
tue :tu <-total spending on tuesday
wed :we <-total spending on wednesday
thr :th <-total spending on thrusday
fri :fr <-total spending on friday
sat :sa <-total spending on saturday
sun :su <-total spending on sunday

let spedingPctOfTotal=(mo/x)*100 <- this percent of spending amount
perOf120=spedingPctOfTotal*120/100
*/

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double totalSpending;
  ChartBar(
      {required this.label,
      required this.spendingAmount,
      required this.totalSpending});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (BuildContext ctx,BoxConstraints cts){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              spendingAmount.toStringAsFixed(2),
            ),
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                        height: cts.maxHeight*0.8,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                          color: Colors.green,
                        )),
                    Container(
                      height:spendingAmount==0 ? 0: (spendingAmount/totalSpending)*(cts.maxHeight*0.8),
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        color: Color.fromRGBO(241, 238, 5, 1.0),
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                  ],
                ),
                SizedBox(
                  height: cts.maxHeight*0.1,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                )
              ]
          ),
        ],
      );
    });
  }
}
