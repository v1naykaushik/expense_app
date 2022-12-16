import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction) {
    print('inside NewTransaction widget constructor');
  }

  @override
  State<NewTransaction> createState() {
    print('inside createState()');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  @override
  void initState() {
    super.initState();
    print('inside init()');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('inside didUpdateWidget()');
  }

  @override
  void dispose() {
    super.dispose();
    print('inside dispose()');
  }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTxData() {
    String enteredTitle = _titleController.text;
    double enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(_titleController.text,
        double.parse(_amountController.text), _selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2022),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
              right: 10,
              top: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Title',
                  contentPadding: EdgeInsets.symmetric(horizontal: 5)),
              //onChanged: (val) => title = val,
              controller: _titleController,
              onSubmitted: (_) => _submitTxData(),
            ),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Amount',
                  contentPadding: EdgeInsets.symmetric(horizontal: 5)),
              //onChanged: (val) => amount = val,
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitTxData(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_selectedDate == null
                    ? 'no date chosen'
                    : 'picked date: ${DateFormat('dd-LLL-yyyy').format(_selectedDate!)}'),
                AdaptiveTextButton('Choose Date', _presentDatePicker),
              ],
            ),
            ElevatedButton(
              onPressed: () => _submitTxData(),
              /* () {
                  //print('$title for amount: $amount');
                  //print('${titleController.text} for ${amountController.text} rupees');

                } */ //old way
              child: const Text('Save Transaction'),
            ),
          ]),
        ),
      ),
    );
  }
}
