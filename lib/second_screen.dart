import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transactions_list.dart';
import './models/transactions.dart';
import './widgets/chart.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen>
    with WidgetsBindingObserver {
  final List<Transactions> _userTransactionsList = [
    /* Transactions(
        id: 'A10', title: 'T-shirt', amount: 9000, date: DateTime.now()),
    Transactions(
        id: 'A11', title: 'Groceries', amount: 600, date: DateTime.now()), */
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('inside didChangeAppLifecycleState $state');
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  void _startAddingUserTx(BuildContext cntxt) {
    showModalBottomSheet(
        context: cntxt,
        builder: (context) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime choosenDate) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: choosenDate);
    setState(() {
      _userTransactionsList.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactionsList.removeWhere((element) => element.id == id);
    });
  }

  List<Transactions> get _recentTransactions {
    return _userTransactionsList.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  bool showChart = false;

  List<Widget> buildLandscapeContent(
      PreferredSizeWidget appbar, MediaQueryData mediaQuery) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show chart',
              style: Theme.of(context)
                  .textTheme
                  .headline6), //have to give theme for iOS as it won't take attribute from a material theme
          Switch.adaptive(
            value: showChart,
            activeColor: Theme.of(context).toggleableActiveColor,
            onChanged: (val) {
              setState(() => showChart = val);
            },
          )
        ],
      ),
      showChart
          ? Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child: Chart(_recentTransactions))
          : Container(
              height: (mediaQuery.size.height -
                      appbar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.8,
              child:
                  TransactionsList(_userTransactionsList, _deleteTransaction),
            ),
    ];
  }

  List<Widget> buildPortraitContent(
      PreferredSizeWidget appbar, MediaQueryData mediaQuery) {
    return [
      Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.25,
        child: Chart(_recentTransactions),
      ),
      Container(
        height: (mediaQuery.size.height -
                appbar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: TransactionsList(_userTransactionsList, _deleteTransaction),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: const Text(
              "My Personal Expenses",
            ),
            trailing: Builder(
              builder: (cx) => IconButton(
                onPressed: () => _startAddingUserTx(cx),
                icon: const Icon(
                  CupertinoIcons.add,
                  color: CupertinoColors.white,
                ),
              ),
            ),
          )
        : AppBar(
            title: const Text(
              "My Personal Expenses",
              //style: TextStyle(fontFamily: 'OpenSans'), //was used before creating appBarTheme in theme
            ),
            actions: [
              Builder(
                builder: (cx) => IconButton(
                    onPressed: () => _startAddingUserTx(cx),
                    icon: const Icon(Icons.add)),
              ),
            ],
          ) as PreferredSizeWidget;
    return Builder(
      builder: (BuildContext context) {
        final mediaQuery = MediaQuery.of(context);
        final bool isLandscape =
            mediaQuery.orientation == Orientation.landscape;

        Widget pageBody = SafeArea(
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (isLandscape) ...buildLandscapeContent(appbar, mediaQuery),
                if (!isLandscape) ...buildPortraitContent(appbar, mediaQuery),
              ],
            ),
          ),
        );

        return Platform.isIOS
            ? CupertinoPageScaffold(
                navigationBar: appbar as ObstructingPreferredSizeWidget,
                child: pageBody,
              )
            : Scaffold(
                appBar: appbar,
                body: pageBody,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Platform.isIOS
                    ? Container()
                    : Builder(
                        builder: (cx) => FloatingActionButton(
                            onPressed: () => _startAddingUserTx(cx),
                            child: const Icon(Icons.add)),
                      ),
              );
      },
    );
  }
}
