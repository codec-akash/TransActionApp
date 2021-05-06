class Transaction {
  final String transId;
  final String userId;
  final double amount;
  final String description;
  final bool moneySent;
  final DateTime dateTime;

  Transaction({
    this.transId,
    this.userId,
    this.amount,
    this.description,
    this.moneySent,
    this.dateTime,
  });
}
