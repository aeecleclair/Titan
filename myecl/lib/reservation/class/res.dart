class Reservation {
  final String title;
  final String date;
  int state; // 0 : en attente, 1 : confirmé, 2 : refusé

  Reservation({required this.title, required this.date, required this.state});
}
