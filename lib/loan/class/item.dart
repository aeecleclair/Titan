class Item {
  Item({
    required this.id,
    required this.name,
    required this.caution,
    required this.totalAmount,
    required this.loanedAmount,
    required this.suggestedLendingDuration,
  });
  late final String id;
  late final String name;
  late final int caution;
  late final int totalAmount;
  late final int loanedAmount;
  late final double suggestedLendingDuration;

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    caution = json['suggested_caution'];
    totalAmount = json['totalAmount'];
    loanedAmount = json['loanedAmount'];
    suggestedLendingDuration =
        json['suggested_lending_duration'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['suggested_caution'] = caution;
    data['totalAmount'] = totalAmount;
    data['loanedAmount'] = loanedAmount;
    data['suggested_lending_duration'] = suggestedLendingDuration;
    return data;
  }

  Item copyWith({id, name, caution, totalAmount,loanedAmount, suggestedLendingDuration}) {
    return Item(
        id: id ?? this.id,
        name: name ?? this.name,
        caution: caution ?? this.caution,
        totalAmount: totalAmount ?? this.totalAmount,
        loanedAmount: loanedAmount ?? this.loanedAmount,
        suggestedLendingDuration:
            suggestedLendingDuration ?? this.suggestedLendingDuration);
  }

  Item.empty() {
    id = '';
    name = '';
    caution = 0;
    totalAmount = 0;
    loanedAmount = 0;
    suggestedLendingDuration = 0;
  }

  @override
  String toString() {
    return 'Item(id: $id, name: $name, caution: $caution, totalAmount: $totalAmount,  loanedAmount: $loanedAmount, suggestedLendingDuration: $suggestedLendingDuration)';
  }
}
