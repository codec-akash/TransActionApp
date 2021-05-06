import 'package:AkudoTask/models/user_model.dart';
import 'package:AkudoTask/utils/global.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  final UserModel userData;
  final Function sendMoney;
  UserCard({this.userData, this.sendMoney});

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool isExpanded = false;
  TextEditingController _amountController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final _form = GlobalKey<FormState>();

  void sendMoneyFromUser() {
    if (_form.currentState.validate()) {
      double amount = double.parse(_amountController.text);
      widget.sendMoney(
          widget.userData.userId, _descriptionController.text.trim(), amount);
      setState(() {
        _amountController.clear();
        _descriptionController.clear();
        isExpanded = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Theme.of(context).accentColor, width: 2.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name:   ${widget.userData.userName}",
                    style: Global().subHeaderText,
                  ),
                  Text(
                    "Balance:   ${widget.userData.balance}",
                    style: Global().subHeaderText,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(isExpanded ? Icons.minimize : Icons.add),
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                  ),
                  SizedBox(width: 10.0),
                  IconButton(
                    icon: Icon(Icons.delete_outline_rounded, color: Colors.red),
                    onPressed: () {},
                  )
                ],
              ),
            ],
          ),
          isExpanded
              ? Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _amountController,
                          decoration: Global()
                              .textFieldDecoration
                              .copyWith(labelText: 'Amount'),
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Value Should be greater then 0";
                            }
                            if (double.parse(value) < 0.0) {
                              return "Value Should be greater then 0";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8.0),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: Global()
                              .textFieldDecoration
                              .copyWith(labelText: 'Description'),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: RaisedButton(
                            color: Theme.of(context).accentColor,
                            textColor: Colors.white,
                            child: Text("Send Money"),
                            onPressed: () {
                              sendMoneyFromUser();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
