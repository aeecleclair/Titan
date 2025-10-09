class RaffleStats {
  late final int ticketsSold;
  late final double amountRaised;

  RaffleStats({required this.ticketsSold, required this.amountRaised});

  RaffleStats.fromJson(Map<String, dynamic> json) {
    ticketsSold = json['tickets_sold'];
    amountRaised = json['amount_raised'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tickets_sold'] = ticketsSold;
    data['amount_raised'] = amountRaised;
    return data;
  }

  RaffleStats copyWith({int? ticketsSold, double? amountRaised}) => RaffleStats(
    ticketsSold: ticketsSold ?? this.ticketsSold,
    amountRaised: amountRaised ?? this.amountRaised,
  );

  RaffleStats.empty() {
    ticketsSold = 0;
    amountRaised = 0.0;
  }

  @override
  String toString() {
    return 'RaffleStats(ticketsSold: $ticketsSold, amountRaised: $amountRaised)';
  }
}
