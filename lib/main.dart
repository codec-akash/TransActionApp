import 'package:AkudoTask/pages/home_page/home_page.dart';
import 'package:AkudoTask/pages/send_tranaction/send_tranaction_page.dart';
import 'package:AkudoTask/pages/send_tranaction/received_tranaction_page.dart';
import 'package:AkudoTask/pages/transaction_page/transaction_list.dart';
import 'package:AkudoTask/providers/theme_provider.dart';
import 'package:AkudoTask/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          title: 'Flutter Demo',
          theme: theme.darkTheme ? dark : light,
          home: HomePage(),
          routes: {
            SendTransaction.routeName: (ctx) => SendTransaction(),
            ReceiveTranaction.routeName: (ctx) => ReceiveTranaction(),
            TransactionList.routeName: (ctx) => TransactionList(),
          },
        ),
      ),
    );
  }
}
