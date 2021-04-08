import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  Widget _displayCorrectIcon(String title) {
    //return Image.asset('assets/images/cocktail.png');
    switch (title) {
      case 'Bar':
        return Image.asset('assets/images/cocktail.png');
        break;
      case 'Shopping':
        return Image.asset('assets/images/shoping.png');
        break;
      case 'Car rental':
        return Image.asset('assets/images/car.png');
        break;
      case 'Grocery':
        return Image.asset('assets/images/grocery.png');
        break;
      case 'Restaurant':
        return Image.asset('assets/images/restaurant.png');
        break;
      case 'Cinema':
        return Image.asset('assets/images/cinema.png');
        break;
      case 'Travel':
        return Image.asset('assets/images/travel.png');
        break;
      default:
        return Image.asset('assets/images/yen.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'Add some transactions!',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/money.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 35,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: ClipOval(
                          child: _displayCorrectIcon(transactions[index].title),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.headline5),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: Text(
                      '¥${transactions[index].amount}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    onLongPress: () =>
                        deleteTransaction(transactions[index].id),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
