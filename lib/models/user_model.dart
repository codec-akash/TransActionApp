class UserModel {
  final String userId;
  final String userName;
  double balance;

  UserModel({
    this.userId,
    this.userName,
    this.balance = 5000.0,
  });
}
