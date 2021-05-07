import 'package:AkudoTask/models/transaction_model.dart';
import 'package:AkudoTask/pages/transaction_page/transaction_card.dart';
import 'package:AkudoTask/providers/user_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransactionList extends StatelessWidget {
  static const routeName = '/transList';
  @override
  Widget build(BuildContext context) {
    List<Transaction> transaction =
        Provider.of<UserProvider>(context, listen: false).userTrans;
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction History"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: transaction.isEmpty
            ? Container(
                child: Center(
                  child: Text(
                    "Ops No Transactions",
                    style: Global().subHeaderText,
                  ),
                ),
              )
            : ListView(
                children: transaction
                    .map((trans) => TransCard(
                          transaction: trans,
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
