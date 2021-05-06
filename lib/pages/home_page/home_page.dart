import 'package:AkudoTask/pages/send_tranaction/send_tranaction_page.dart';
import 'package:AkudoTask/pages/transaction_page/received_tranaction_page.dart';
import 'package:AkudoTask/providers/theme_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);

    bool revealAmount = false;

    return Scaffold(
      appBar: AppBar(
        title: Text("TaskApp"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              color: Theme.of(context).accentColor,
              alignment: Alignment.bottomLeft,
              child: Text(
                "  Hello Yongster,",
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
            ),
            ListTile(
              title: Text(
                "Receive Transaction",
                style: Global().subHeaderText.copyWith(
                    color: theme.darkTheme ? Colors.white : Colors.black),
              ),
              trailing: Icon(Icons.call_received_sharp),
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
                    Text("Send"),
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
                    Text("Receive"),
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
                color: Colors.white,
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
                textColor: Colors.white,
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 2.0),
                child: Text(
                  revealAmount ? "0.0" : "Click to reveal",
                  style: TextStyle(fontSize: 18.0),
                ),
                onPressed: () {
                  setState(() {
                    revealAmount = !revealAmount;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
