import 'package:AkudoTask/providers/user_provider.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomModalSheet extends StatefulWidget {
  @override
  _BottomModalSheetState createState() => _BottomModalSheetState();
}

class _BottomModalSheetState extends State<BottomModalSheet> {
  TextEditingController _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void submitUser() {
    if (_formKey.currentState.validate()) {
      Provider.of<UserProvider>(context, listen: false)
          .addUser(_nameController.text);
      _nameController.clear();
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
}
