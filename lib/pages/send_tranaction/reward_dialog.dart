import 'package:AkudoTask/providers/user_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RewardDialog extends StatelessWidget {
  final double rewards;
  RewardDialog({this.rewards});
  @override
  Widget build(BuildContext context) {
    return rewards == 0.0
        ? AlertDialog(
            title: Text("Successful"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Your Transaction has been completed",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Okay",
                    style: Global().subHeaderText,
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          )
        : AlertDialog(
            title: Text("Rewards"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "U have got Rs: $rewards as rewards by making transaction",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    "Okay",
                    style: Global().subHeaderText,
                  ),
                  textColor: Colors.white,
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
  }
}
