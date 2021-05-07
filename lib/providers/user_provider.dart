import 'dart:math';

import 'package:AkudoTask/models/transaction_model.dart';
import 'package:AkudoTask/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  int loggedIn = 0;
  UserModel _user;
  List<UserModel> addedUsers = [];
  List<Transaction> _userTransaction = [];

  UserModel get userDetails => _user;

  List<UserModel> get addedUserList => [...addedUsers];

  UserModel getSpecificUser(String userId) {
    return addedUsers.firstWhere((element) => element.userId == userId);
  }

  List<Transaction> get userTrans => _userTransaction.reversed.toList();

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

  void sendMoney(
      String userId, double amount, String description, double rewards) {
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
      rewards: isTrasactionComplete ? rewards : 0.0,
    );
    _userTransaction.add(transaction);
    if (isTrasactionComplete) {
      _user.balance -= amount;
      targetUser.balance += amount;
      _user.balance += rewards;
    } else {
      throw 'Transaction Failed due to some issue';
    }
    notifyListeners();
  }

  void receiveMoney(
      String userId, double amount, String description, double rewards) {
    UserModel targetUser =
        addedUsers.firstWhere((element) => element.userId == userId);
    bool isTrasactionComplete = Random().nextBool();
    print(isTrasactionComplete);
    if (amount > targetUser.balance) {
      throw "Your Friend does not have enough balance";
    }
    Transaction transaction = Transaction(
      transId: DateTime.now().toIso8601String(),
      userId: userId,
      amount: amount,
      description: description,
      tranSuccess: isTrasactionComplete,
      moneySent: false,
      dateTime: DateTime.now(),
      rewards: isTrasactionComplete ? rewards : 0.0,
    );
    _userTransaction.add(transaction);
    if (isTrasactionComplete) {
      _user.balance += amount;
      targetUser.balance -= amount;
      _user.balance += rewards;
    } else {
      throw 'Your Friend denied payment';
    }
    notifyListeners();
  }

  double calculateReward(double amount) {
    double reward = 0.0;
    if (amount > 500.0) {
      int percent = Random().nextInt(100);
      reward = amount * percent / 100;
    }
    return reward;
  }
}
