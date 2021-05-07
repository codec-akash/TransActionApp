import 'package:AkudoTask/models/user_model.dart';
import 'package:AkudoTask/pages/send_tranaction/bottom_modal_sheet.dart';
import 'package:AkudoTask/pages/send_tranaction/reward_dialog.dart';
import 'package:AkudoTask/pages/send_tranaction/sent_money_card.dart';
import 'package:AkudoTask/pages/send_tranaction/received_tranaction_page.dart';
import 'package:AkudoTask/providers/user_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SendTransaction extends StatefulWidget {
  static const routeName = '/send-transaction';

  @override
  _SendTransactionState createState() => _SendTransactionState();
}

class _SendTransactionState extends State<SendTransaction> {
  List<UserModel> userList = [];
  UserModel userData;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    userList = Provider.of<UserProvider>(context).addedUserList;
    userData = Provider.of<UserProvider>(context).userDetails;
    super.didChangeDependencies();
  }

  void sendMoney(
      String userId, String description, double amount, double rewards) {
    try {
      Provider.of<UserProvider>(context, listen: false)
          .sendMoney(userId, amount, description, rewards);
      showDialog(
          context: context, builder: (ctx) => RewardDialog(rewards: rewards));
    } catch (e) {
      print(e);
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Send Money"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )),
                builder: (context) => Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: BottomModalSheet(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Text(
                "Do you want to receive money ? Click here",
                style: Global().subHeaderText.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(ReceiveTranaction.routeName);
              },
            ),
            Divider(
              color: Theme.of(context).accentColor,
              thickness: 0.9,
            ),
            SizedBox(height: 10.0),
            Text(
              "Current Balance:  ${userData.balance}",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10.0),
            Text(
              "Get amazing rewards on transaction for more then 500 Rs",
              style: TextStyle(
                  fontSize: 16.0, color: Theme.of(context).accentColor),
            ),
            SizedBox(height: 10.0),
            userList.length > 0
                ? Text("Friend List :")
                : Expanded(
                    child: Center(
                      child: Text(
                        "Add New Friends from top !",
                        style: Global().subHeaderText,
                      ),
                    ),
                  ),
            SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) => UserCard(
                  userData: userList[index],
                  sendMoney: sendMoney,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
