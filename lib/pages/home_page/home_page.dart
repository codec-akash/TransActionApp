import 'package:AkudoTask/providers/theme_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeNotifier>(context);

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
      body: Column(
        children: [],
      ),
    );
  }
}
