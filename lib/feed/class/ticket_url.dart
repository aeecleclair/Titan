class TicketUrl {
  late final String ticketUrl;
  TicketUrl({required this.ticketUrl});

  TicketUrl.fromJson(Map<String, dynamic> json) {
    ticketUrl = json['ticket_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ticket_url'] = ticketUrl;
    return data;
  }

  TicketUrl copyWith({String? ticketUrl}) {
    return TicketUrl(ticketUrl: ticketUrl ?? this.ticketUrl);
  }

  TicketUrl.empty() {
    ticketUrl = '';
  }

  @override
  String toString() {
    return 'TicketUrl{ticketUrl: $ticketUrl}';
  }
}
