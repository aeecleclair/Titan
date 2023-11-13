class Balance {
  late final String userId;
  late final String reimbursementId;
  late final double amount;
  late final double totalExpense;
  late final double totalPayment;

  Balance(
      {required this.userId,
      required this.reimbursementId,
      required this.amount,
      required this.totalExpense,
      required this.totalPayment});

  Balance.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    reimbursementId = json['reimbursement_id'];
    amount = json['amount'];
    totalExpense = json['total_expense'];
    totalPayment = json['total_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['reimbursement_id'] = reimbursementId;
    data['amount'] = amount;
    data['total_expense'] = totalExpense;
    data['total_payment'] = totalPayment;
    return data;
  }

  @override
  String toString() {
    return 'Balance{userId: $userId, reimbursementId: $reimbursementId, amount: $amount, totalExpense: $totalExpense, totalPayment: $totalPayment}';
  }

  Balance copyWith({
    String? userId,
    String? reimbursementId,
    double? amount,
    double? totalExpense,
    double? totalPayment,
  }) {
    return Balance(
      userId: userId ?? this.userId,
      reimbursementId: reimbursementId ?? this.reimbursementId,
      amount: amount ?? this.amount,
      totalExpense: totalExpense ?? this.totalExpense,
      totalPayment: totalPayment ?? this.totalPayment,
    );
  }

  Balance.empty()
      : this(
            userId: '',
            reimbursementId: '',
            amount: 0.0,
            totalExpense: 0.0,
            totalPayment: 0.0);
}
