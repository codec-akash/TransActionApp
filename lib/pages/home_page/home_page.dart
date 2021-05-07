import 'package:AkudoTask/models/user_model.dart';
import 'package:AkudoTask/pages/send_tranaction/send_tranaction_page.dart';
import 'package:AkudoTask/pages/send_tranaction/received_tranaction_page.dart';
import 'package:AkudoTask/pages/transaction_page/transaction_list.dart';
import 'package:AkudoTask/providers/theme_provider.dart';
import 'package:AkudoTask/providers/user_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool revealAmount = false;
  UserModel userData;

  @override
  void didChangeDependencies() {
    Provider.of<UserProvider>(context, listen: false).createInitialUser();
    userData = Provider.of<UserProvider>(context, listen: false).userDetails;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("TaskApp"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Theme.of(context).accentColor,
              alignment: Alignment.bottomLeft,
              child: Text(
                "  Hello Kiddo,",
                style: Global().headerText,
              ),
            ),
            ListTile(
              title: Text(
                "Dark Theme",
                style: Global().subHeaderText.copyWith(
                    color: theme.darkTheme ? Colors.white : Colors.black),
              ),
              trailing: Switch(
                value: theme.darkTheme,
                onChanged: (value) {
                  theme.toggleTheme();
                },
              ),
            ),
            ListTile(
              title: Text(
                "Send Transaction",
                style: Global().subHeaderText.copyWith(
                    color: theme.darkTheme ? Colors.white : Colors.black),
              ),
              trailing: Icon(Icons.send_outlined),
              onTap: () {
                Navigator.of(context).pushNamed(SendTransaction.routeName);
              },
            ),
            ListTile(
              title: Text(
                "Receive Transaction",
                style: Global().subHeaderText.copyWith(
                    color: theme.darkTheme ? Colors.white : Colors.black),
              ),
              trailing: Icon(Icons.call_received_sharp),
              onTap: () {
                Navigator.of(context).pushNamed(ReceiveTranaction.routeName);
              },
            ),
            ListTile(
              title: Text(
                "Transaction History",
                style: Global().subHeaderText.copyWith(
                    color: theme.darkTheme ? Colors.white : Colors.black),
              ),
              trailing: Icon(Icons.history_rounded),
              onTap: () {
                Navigator.of(context).pushNamed(TransactionList.routeName);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 36,
        padding: EdgeInsets.only(right: 4),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape:
                    RoundedRectangleBorder(borderRadius: Global().borderRadius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Send",
                      style: Global().titleText,
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.send_outlined),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(SendTransaction.routeName);
                },
              ),
            ),
            SizedBox(width: 15.0),
            Expanded(
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape:
                    RoundedRectangleBorder(borderRadius: Global().borderRadius),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Receive",
                      style: Global().titleText,
                    ),
                    SizedBox(width: 8.0),
                    Icon(Icons.call_received_sharp),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(ReceiveTranaction.routeName);
                },
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          children: [
            Text(
              "Heyy, Your Current Total Amount is :",
              style: TextStyle(
                fontSize: 26.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                textColor: Theme.of(context).primaryColor,
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                child: Text(
                  revealAmount ? "${userData.balance}" : "Click to reveal",
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  setState(() {
                    revealAmount = !revealAmount;
                  });
                },
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              "Want To See your transactions ?",
              style: TextStyle(
                fontSize: 26.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              child: OutlineButton(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                textColor: Theme.of(context).primaryColor,
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                child: Text(
                  "Click here",
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(TransactionList.routeName);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
