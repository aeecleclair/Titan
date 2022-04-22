class Booking {
  final String title;
  final String date;
  int state; // 0 : en attente, 1 : confirmé, 2 : refusé

  Booking({required this.title, required this.date, required this.state});
}
