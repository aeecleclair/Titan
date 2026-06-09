class TicketChangeOverInvitation {
  TicketChangeOverInvitation({required this.ticketId, required this.email});

  final String ticketId;
  final String email;

  Map<String, dynamic> toJson() {
    return {'ticket_id': ticketId, 'email': email};
  }
}
