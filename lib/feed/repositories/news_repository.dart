import 'package:titan/feed/class/news.dart';
import 'package:titan/tools/repository/repository.dart';

class NewsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "feed/";

  Future<List<News>> getPublishedNews() async {
    return List<News>.from(
      (await getList(suffix: "news")).map((e) => News.fromJson(e)),
    );
  }

  Future<News> createNews(News news) async {
    print(news.toJson());
    return News.fromJson(await create(news.toJson(), suffix: "news"));
  }

  Future<List<News>> getAllNews() async {
    return List<News>.from(
      (await getList(suffix: "admin/news")).map((e) => News.fromJson(e)),
    );
  }

  Future<bool> approveNews(String id) async {
    return await create({}, suffix: "admin/news/$id/approve");
  }

  Future<bool> rejectNews(String id) async {
    return await create({}, suffix: "admin/news/$id/reject");
  }
}
