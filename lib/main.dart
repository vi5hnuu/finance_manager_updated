import 'package:finance_manager/widgets/chart.dart';
import 'package:finance_manager/widgets/new_transaction.dart';
import 'package:finance_manager/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() {
  //allow only protrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tnx) {
      return tnx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList(growable: false);
  }

  void _addNewTransaction(
      {required String title,
      required double amount,
      required DateTime chosenDate}) {
    final newTransaction = Transaction(
        id: chosenDate.toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTransaction);
    });
    Navigator.pop(context);
  }

  void _deleteTransaction({required String id}) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
        context: ctx,
        backgroundColor: Colors.transparent,
        isDismissible: true,
        builder: (BuildContext bctx) {
          return NewTransaction(callback: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery=MediaQuery.of(context);
    final isPortrait =
        mediaQuery.orientation == Orientation.portrait;
    final appBar = AppBar(
      title: Text('Your Finance Manager'.toUpperCase()),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            _startAddNewTransaction(context);
          },
          icon: Icon(Icons.add),
          tooltip: 'Add new Finance',
          splashRadius: 25,
          splashColor: Colors.lightBlueAccent,
        )
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
    );
    return SafeArea(
      child: Scaffold(
        floatingActionButton: isPortrait
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _startAddNewTransaction(context);
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, //default
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!isPortrait)
                Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Show Chart'),
                      Switch(
                          value: _showChart,
                          onChanged: (val) {
                            setState(() {
                              _showChart = val;
                            });
                          })
                    ],
                  ),
                ),
              if (isPortrait || (!isPortrait && _showChart))
                SizedBox(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      (isPortrait ? 0.25 : 0.8),
                  child: Chart(
                    recentTransactions: _recentTransaction,
                  ),
                ),
              if (isPortrait || (!isPortrait && !_showChart))
                SizedBox(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.75,
                  child: TransactionList(
                      transactions: _userTransactions,
                      callback: _deleteTransaction),
                )
            ],
          ),
        ),
      ),
    );
  }
}
