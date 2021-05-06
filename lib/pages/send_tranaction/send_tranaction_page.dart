import 'package:AkudoTask/models/user_model.dart';
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

  TextEditingController _nameController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    userList = Provider.of<UserProvider>(context).addedUserList;
    userData = Provider.of<UserProvider>(context).userDetails;
    super.didChangeDependencies();
  }

  void submitUser() {
    if (_formKey.currentState.validate()) {
      Provider.of<UserProvider>(context, listen: false)
          .addUser(_nameController.text);
      _nameController.clear();
      Navigator.of(context).pop();
    }
  }

  void sendMoney(String userId, String description, double amount) {
    try {
      Provider.of<UserProvider>(context, listen: false)
          .sendMoney(userId, amount, description);
    } catch (e) {
      print(e);
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  Widget addUser() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 50.0),
              TextFormField(
                controller: _nameController,
                decoration: Global()
                    .textFieldDecoration
                    .copyWith(labelText: 'User Name'),
                validator: (value) {
                  if (value.length < 3) {
                    return 'Enter a valid name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  color: Theme.of(context).accentColor,
                  textColor: Colors.white,
                  child: Text("Add User"),
                  onPressed: () {
                    submitUser();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Send Transaction"),
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
                  child: addUser(),
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
