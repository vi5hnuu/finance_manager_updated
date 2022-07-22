import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  NewTransaction({required this.callback});
  void Function({required String title, required double amount,required DateTime chosenDate}) callback;

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime? chosenDate;
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
      keyboardType: TextInputType.number
    ).then((date) => {
      if(date!=null)
        setState((){
          chosenDate=date;
        })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromRGBO(238, 238, 238, 1.0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Container(
        padding: const EdgeInsets.all(10).copyWith(bottom:MediaQuery.of(context).viewInsets.bottom+10),//bottom<-keyboard height+10(isScrolledControlled:true in show modal bottom sheet)
        margin: EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,//else it will take full screen
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'ADD NEW TRANSACTION',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromRGBO(141, 182, 236, 1.0)),
                textAlign: TextAlign.center,
              ),
            ),
            TextField(
              autofocus: false,
              textAlign: TextAlign.center,
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter title',
                labelText: 'Title',
                helperText: 'e.g Bought a new laptop',
                prefixIcon: const Icon(Icons.notes_rounded),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(const Radius.circular(15)),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Color.fromRGBO(124, 170, 220, 1.0),
                    )),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autofocus: false,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(
                hintText: 'Enter Amount',
                labelText: 'Amount',
                helperText: 'e.g 500',
                prefixIcon: Icon(Icons.currency_rupee),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    borderSide: BorderSide(
                      width: 2,
                      color: Color.fromRGBO(124, 170, 220, 1.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Text( '${chosenDate!=null ? DateFormat('dd/MMM/yyyy  hh:mm a', 'en_US').format(chosenDate!) : 'No Dates Chosen'}'),
                  SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    onPressed:_presentDatePicker,
                    child: Text('Chose Date'),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          side: BorderSide(width: 2, color: Colors.blueAccent)),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String titleText = _titleController.text;

                double? amountData = double.tryParse(_amountController.text);
                if (titleText.isEmpty || amountData == null || amountData <= 0 || chosenDate==null)
                  return;
                widget.callback(title: titleText, amount: amountData,chosenDate: chosenDate!);
              },
              child: const Text('Add'),
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(5),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(120, 40),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
