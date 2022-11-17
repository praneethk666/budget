// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:budget/models/transactions.dart';
import 'package:intl/intl.dart';

class T extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTransxx;
  const T(this.transactions, this.deleteTransxx, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
          return Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "NO TRANSACTIONS ADDED!",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              // ignore: avoid_unnecessary_containers
              SizedBox(
                  height: constraints.maxHeight*0.6,
                  child: Image.asset(
                    'assests/images/waiting.png',
                    fit: BoxFit.cover,
                  ))
            ],
          );
        }),)
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                          child: Text('₹${transactions[index].amount}')),
                    ),
                  ),
                  title: Text(transactions[index].title),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width>460?ElevatedButton.icon(
                    icon: Icon(
                      color: Colors.red[600],
                      Icons.delete_forever_rounded,
                  ), onPressed: () {deleteTransxx(transactions[index].id);  }, label: Text('Delete'),):IconButton(
                    icon: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red[600],
                    ),
                    onPressed: () {
                      deleteTransxx(transactions[index].id);
                    },
                  ),
                ),
              );
            },
          );
  }
}
