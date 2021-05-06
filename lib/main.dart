import 'package:AkudoTask/pages/home_page/home_page.dart';
import 'package:AkudoTask/pages/send_tranaction/send_tranaction_page.dart';
import 'package:AkudoTask/pages/transaction_page/received_tranaction_page.dart';
import 'package:AkudoTask/providers/theme_provider.dart';
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
        ChangeNotifierProvider.value(
          value: ThemeNotifier(),
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
          },
        ),
      ),
    );
  }
}
