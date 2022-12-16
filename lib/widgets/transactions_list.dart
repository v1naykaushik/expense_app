import 'package:flutter/material.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';
import './transaction_item.dart';

class TransactionsList extends StatelessWidget {
  final List<Transactions> transactionsList;
  final Function _deleteTransaction;
  TransactionsList(this.transactionsList, this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return transactionsList.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset('assets/images/no_data.png')),
                  Container(
                    height: constraints.maxHeight * 0.10,
                    child: Text(
                      'No transactions added yet',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactionsList.length,
            itemBuilder: (context, index) {
              return TransactionItem(
                transaction: transactionsList[index],
                deleteTransaction: _deleteTransaction,
                key: ValueKey(transactionsList[index].id),
              );
              /*return Card(            //this was used earlier when ListTile was not known
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Text(
                            '\$${transactionsList[index].amount.toStringAsFixed(2)}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20),
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              transactionsList[index].title,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            Text(
                              DateFormat('dd-LLL-yyyy')
                                  .format(transactionsList[index].date),
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 11),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ); */
            },
          );
  }
}
