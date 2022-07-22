import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function({required String id}) callback;
  TransactionList({required this.transactions,required this.callback});
  @override
  Widget build(BuildContext context) {
    return Card(
      //list of transactions
      color: const Color.fromRGBO(238, 238, 238, 1.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: transactions.isEmpty
          ? Image(
              image: AssetImage('assets/images/waiting.png'),
              fit: BoxFit.contain,
            )
          : Padding(
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    //transaction
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Row(
                      children: [
                        Container(
                          width: 125,
                          height: 50,
                          alignment: Alignment.center,
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                              '₹ ${transactions[index].amount.toStringAsFixed(2)}',
                              overflow: TextOverflow.fade,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: const Color.fromRGBO(0, 125, 0, 1)),
                            ),
                          ),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.green,
                              width: 2,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              transactions[index].title.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              DateFormat('dd/MMM/yyyy', 'en_US')
                                  .format(transactions[index].date),
                              style: const TextStyle(
                                  color: Color.fromRGBO(120, 120, 120, 1.0)),
                            )
                          ],
                        ),
                        Expanded(

                          child: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                            child: IconButton(
                              onPressed: () {
                                callback(id:this.transactions[index].id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              splashRadius: 30,
                              iconSize: 30,
                              tooltip: 'Delete this task 🗑️',
                              splashColor: Color.fromRGBO(231, 206, 127, 1.0),
                              highlightColor:  Color.fromRGBO(
                                  234, 182, 183, 1.0),
                            ),
                          ),
                        ),

                      ],
                    ),
                  );
                },
                itemCount: transactions.length,
              ),
            ),
    );
  }
}

///
///  children: transactions.map((transaction) {
//               }).toList(growable: false),
