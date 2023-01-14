class TheMovieDBGenre {
  late final int id;
  late final String name;

  TheMovieDBGenre({required this.id, required this.name});

  TheMovieDBGenre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
