import 'dart:math';

import 'package:AkudoTask/models/transaction_model.dart';
import 'package:AkudoTask/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  int loggedIn = 0;
  UserModel _user;
  List<UserModel> addedUsers = [];
  List<Transaction> userTransaction = [];

  UserModel get userDetails => _user;

  List<UserModel> get addedUserList => [...addedUsers];

  UserModel getSpecificUser(String userId) {
    return addedUsers.firstWhere((element) => element.userId == userId);
  }

  void addUser(String name) {
    print("reached");
    UserModel newUser = UserModel(
      userId: DateTime.now().toIso8601String(),
      userName: name,
    );
    addedUsers.add(newUser);
    notifyListeners();
  }

  void deleteUser(String userId) {
    addedUsers.removeWhere((element) => element.userId == userId);
    notifyListeners();
  }

  void createInitialUser() {
    loggedIn++;
    if (loggedIn == 1) {
      _user = UserModel(
          userId: DateTime.now().toIso8601String(), userName: "Demo User");
    }
  }

  void sendMoney(String userId, double amount, String description) {
    UserModel targetUser =
        addedUsers.firstWhere((element) => element.userId == userId);
    bool isTrasactionComplete = Random().nextBool();
    print(isTrasactionComplete);
    if (_user.balance < amount) {
      throw 'Not enough balance';
    }
    Transaction transaction = Transaction(
      transId: DateTime.now().toIso8601String(),
      userId: userId,
      amount: amount,
      description: description,
      dateTime: DateTime.now(),
      moneySent: true,
      tranSuccess: isTrasactionComplete,
    );
    userTransaction.add(transaction);
    if (isTrasactionComplete) {
      _user.balance -= amount;
      targetUser.balance += amount;
    } else {
      throw 'Transaction Failed due to some issue';
    }
    notifyListeners();
  }
}
