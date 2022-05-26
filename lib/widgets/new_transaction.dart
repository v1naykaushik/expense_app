import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  //String title = '';
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitTxData() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount == 0) {
      return;
    }
    widget.addTransaction(
        titleController.text, double.parse(amountController.text));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
        Card(
          child: TextField(
            decoration: const InputDecoration(
                labelText: 'Title',
                contentPadding: EdgeInsets.symmetric(horizontal: 5)),
            //onChanged: (val) => title = val,
            controller: titleController,
            onSubmitted: (_) => submitTxData(),
          ),
        ),
        Card(
          child: TextField(
            decoration: const InputDecoration(
                labelText: 'Amount',
                contentPadding: EdgeInsets.symmetric(horizontal: 5)),
            //onChanged: (val) => amount = val,
            controller: amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitTxData(),
          ),
        ),
        TextButton(
          onPressed: () => submitTxData()
          /* () {
              //print('$title for amount: $amount');
              //print('${titleController.text} for ${amountController.text} rupees');

            } */
          ,
          child: const Text('Save Transaction'),
        ),
      ]),
    );
  }
}
