import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';
import './models/transactions.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transactions> _userTransactionsList = [
    Transactions(
        id: 'A10', title: 'T-shirt', amount: 9000, date: DateTime.now()),
    Transactions(
        id: 'A11', title: 'Groceries', amount: 600, date: DateTime.now()),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: DateTime.now());
    setState(() {
      _userTransactionsList.add(newTx);
    });
  }

  void _startAddingUserTx(BuildContext cntxt) {
    showModalBottomSheet(
        context: cntxt,
        builder: (context) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purple,
          //secondary: Colors.amber,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text("Title of App"),
          actions: [
            Builder(
              builder: (cx) => IconButton(
                  onPressed: () => _startAddingUserTx(cx),
                  icon: const Icon(Icons.add)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                color: Colors.green[700],
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Text(
                    'Chart will come here.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TransactionsList(_userTransactionsList),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Builder(
          builder: (cx) => FloatingActionButton(
              onPressed: () => _startAddingUserTx(cx),
              child: const Icon(Icons.add)),
        ),
      ),
    );
  }
}
