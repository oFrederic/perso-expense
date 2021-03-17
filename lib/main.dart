import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';
import './models/transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses Manager',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            headline5: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              color: Colors.deepOrange,
              fontFamily: 'OpenSans',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            button: TextStyle(color: Colors.white)),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'Grocery',
      amount: 6999,
      date: DateTime.now().subtract(
        Duration(days: 6),
      ),
    ),
    Transaction(
      id: 't2',
      title: 'Shopping',
      amount: 2663,
      date: DateTime.now().subtract(
        Duration(days: 5),
      ),
    ),
    Transaction(
      id: 't3',
      title: 'Car rental',
      amount: 8900,
      date: DateTime.now().subtract(
        Duration(days: 5),
      ),
    ),
    Transaction(
      id: 't4',
      title: 'Bar',
      amount: 9050,
      date: DateTime.now().subtract(
        Duration(days: 4),
      ),
    ),
    Transaction(
      id: 't5',
      title: 'Restaurant',
      amount: 6500,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't6',
      title: 'Shopping',
      amount: 4500,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't7',
      title: 'Cinema',
      amount: 3250,
      date: DateTime.now().subtract(
        Duration(days: 3),
      ),
    ),
    Transaction(
      id: 't8',
      title: 'Travel',
      amount: 12653,
      date: DateTime.now().subtract(
        Duration(days: 2),
      ),
    ),
    Transaction(id: 't9', title: 'Bar', amount: 5060, date: DateTime.now()),
    Transaction(
        id: 't10', title: 'New shoes', amount: 8500, date: DateTime.now()),
  ];

  List<Transaction> get _recenteTransations {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, int amount, DateTime chosenDate) {
    final newTransaction = Transaction(
      title: title,
      amount: amount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses Manager'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Chart(_recenteTransations),
            Container(
              padding: EdgeInsets.all(8),
              height: 200,
              child: Card(
                child: TransactionChart(_recenteTransations),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions, _deleteTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {_startAddNewTransaction(context)},
      ),
    );
  }
}
