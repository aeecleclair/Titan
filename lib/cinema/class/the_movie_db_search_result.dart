class TheMovieDBSearchResult {
  late final String posterUrl;
  late final String overview;
  late final List<int> genreIds;
  late final List<String> genreNames;
  late final String id;
  late final String title;

  TheMovieDBSearchResult({
    required this.posterUrl,
    required this.overview,
    required this.genreIds,
    required this.genreNames,
    required this.id,
    required this.title,
  });

  TheMovieDBSearchResult.fromJson(Map<String, dynamic> json) {
    posterUrl = json['poster_path'] != null
        ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
        : "https://image.tmdb.org/t/p/w500${json['backdrop_path']}";
    overview = json['overview'] as String;
    genreIds = json['genre_ids'] as List<int>;
    genreNames = [];
    id = json['id'].toString();
    title = json['title'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['poster_path'] = posterUrl;
    data['overview'] = overview;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['title'] = title;
    return data;
  }

  static TheMovieDBSearchResult empty() {
    return TheMovieDBSearchResult(
      posterUrl: "",
      overview: "",
      genreIds: [],
      genreNames: [],
      id: "",
      title: "",
    );
  }

  @override
  String toString() {
    return 'TheMovieDBSearchResult(posterUrl: $posterUrl, overview: $overview, genreIds: $genreIds, genreNames: $genreNames, id: $id, title: $title)';
  }
}
