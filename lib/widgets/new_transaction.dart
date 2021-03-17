import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;

  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = int.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((chosenDate) {
      if (chosenDate == null) {
        return;
      }

      setState(() {
        _selectedDate = chosenDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Title',
                icon: Icon(Icons.article_outlined),
              ),
              controller: _titleController,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Amount',
                icon: Icon(Icons.money),
              ),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Icon(Icons.calendar_today_outlined),
                  ),
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'No Date Chosen!'
                          : DateFormat.yMMMd().format(_selectedDate),
                    ),
                  ),
                  TextButton(
                    child: Text('Choose Date'),
                    onPressed: _presentDatePicker,
                    style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              child: Text('Add Transaction'),
              onPressed: _submitData,
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                textStyle: TextStyle(
                  color: Theme.of(context).textTheme.button.color,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
