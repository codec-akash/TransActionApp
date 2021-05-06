class Transaction {
  final String transId;
  final String userId;
  final String amount;
  final String description;
  final DateTime dateTime;

  Transaction({
    this.transId,
    this.userId,
    this.amount,
    this.description,
    this.dateTime,
  });
}
