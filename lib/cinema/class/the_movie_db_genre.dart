class TheMovieDBMovie {
  late final List<String> genres;
  late final String overview;
  late final String posterUrl;
  late final String title;
  late final int runtime;
  late final String tagline;

  TheMovieDBMovie({
    required this.genres,
    required this.overview,
    required this.posterUrl,
    required this.title,
    required this.runtime,
    required this.tagline,
  });

  TheMovieDBMovie.fromJson(Map<String, dynamic> json) {
    genres = json['genres'].cast<String>();
    overview = json['overview'] as String;
    posterUrl = json['poster_path'] != null
        ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
        : "https://image.tmdb.org/t/p/w500${json['backdrop_path']}";
    title = json['title'];
    runtime = json['runtime'] as int;
    tagline = json['tagline'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genres'] = genres;
    data['overview'] = overview;
    data['poster_path'] = posterUrl;
    data['title'] = title;
    data['runtime'] = runtime;
    data['tagline'] = tagline;
    return data;
  }
}
