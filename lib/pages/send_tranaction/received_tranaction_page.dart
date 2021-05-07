import 'package:AkudoTask/models/user_model.dart';
import 'package:AkudoTask/pages/send_tranaction/send_tranaction_page.dart';
import 'package:AkudoTask/pages/send_tranaction/sent_money_card.dart';
import 'package:AkudoTask/providers/user_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bottom_modal_sheet.dart';

class ReceiveTranaction extends StatefulWidget {
  static const routeName = '/receive-transaction';

  @override
  _ReceiveTranactionState createState() => _ReceiveTranactionState();
}

class _ReceiveTranactionState extends State<ReceiveTranaction> {
  List<UserModel> userList = [];
  UserModel userData;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    userList = Provider.of<UserProvider>(context).addedUserList;
    userData = Provider.of<UserProvider>(context).userDetails;
    super.didChangeDependencies();
  }

  void receiveMoney(String userId, String description, double amount) {
    try {
      Provider.of<UserProvider>(context, listen: false)
          .receiveMoney(userId, amount, description);
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
        title: Text("Receive Money"),
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
                    .pushReplacementNamed(SendTransaction.routeName);
              },
            ),
            Divider(
              color: Theme.of(context).accentColor,
              thickness: 0.9,
            ),
            SizedBox(height: 10.0),
            Text(
              "Current Balance:  ${userData.balance}",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10.0),
            if (userList.length > 0) Text("Friend List :"),
            SizedBox(height: 5.0),
            Expanded(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) => UserCard(
                  userData: userList[index],
                  sendMoney: receiveMoney,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
