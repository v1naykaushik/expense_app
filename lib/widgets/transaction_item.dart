import 'dart:math';
import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    required Key key,
    required this.transaction,
    required Function deleteTransaction,
  })  : _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transactions transaction;
  final Function _deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? borderColor;
  @override
  void initState() {
    super.initState();
    List borderColorsList = [
      Colors.red,
      Colors.green,
      Colors.yellow,
      Colors.blue,
    ];
    borderColor = borderColorsList[Random().nextInt(4)];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        leading: /* CircleAvatar(       //cause tutorial have CircleAvatar not Container
              radius: 30, */
            Container(
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor!, width: 2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                '\$${widget.transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          //style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat('dd-LLL-yyyy').format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: (() =>
                    widget._deleteTransaction(widget.transaction.id)),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
                label: Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).errorColor),
                ),
              )
            : IconButton(
                onPressed: (() =>
                    widget._deleteTransaction(widget.transaction.id)),
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
    );
  }
}
