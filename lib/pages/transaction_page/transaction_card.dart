import 'package:AkudoTask/models/transaction_model.dart';
import 'package:AkudoTask/models/user_model.dart';
import 'package:AkudoTask/providers/user_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransCard extends StatelessWidget {
  final Transaction transaction;
  TransCard({this.transaction});
  @override
  Widget build(BuildContext context) {
    UserModel userModel = Provider.of<UserProvider>(context, listen: false)
        .getSpecificUser(transaction.userId);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8.0),
      decoration: Global().containerDecoration.copyWith(
          color: transaction.tranSuccess
              ? Theme.of(context).primaryColor
              : Colors.red,
          border: Border.all(color: Theme.of(context).accentColor)),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.amberAccent,
            child: Icon(
              transaction.moneySent
                  ? Icons.send_outlined
                  : Icons.call_received_sharp,
              size: 24,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(width: 20.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TO : ${userModel.userName}",
                  style: Global().titleText,
                ),
                Text(
                  "Id: ${transaction.transId}",
                  softWrap: false,
                  style: Global().titleText,
                ),
                SizedBox(height: 10),
                Text(
                  "Date:  ${Global().dateformatDefault(transaction.dateTime)}",
                  style: Global().titleText,
                ),
                SizedBox(height: 5),
                Text(
                  "Amount:  ${transaction.amount}",
                  style: Global().titleText,
                ),
                Text(
                  "Rewards:  ${transaction.rewards}",
                  style: Global().titleText,
                ),
                SizedBox(height: 5),
                if (transaction.description.isNotEmpty)
                  Text(
                    "Description:  ${transaction.description}",
                    style: Global().titleText,
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
