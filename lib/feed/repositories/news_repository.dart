import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/tools/function.dart';
import 'package:titan/tools/repository/repository.dart';

class NewsRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = "feed/";

  Future<List<News>> getPublishedNews() async {
    return List<News>.from(
      (await getList(suffix: "news")).map((e) => News.fromJson(e)),
    );
    // return Future.value([
    //   News(
    //     id: '',
    //     title: 'Test',
    //     start: DateTime.now().subtract(const Duration(days: 1)),
    //     entity: 'BDE',
    //     module: 'post',
    //     moduleObjectId: '',
    //     status: NewsStatus.published,
    //   ),
    //   News(
    //     id: '',
    //     title: 'Vote',
    //     start: DateTime.now().subtract(const Duration(days: 2)),
    //     end: DateTime.now().add(const Duration(days: 2)),
    //     actionStart: DateTime.now().subtract(const Duration(days: 2)),
    //     entity: 'CAA',
    //     module: 'campagne',
    //     moduleObjectId: '',
    //     status: NewsStatus.published,
    //   ),
    //   News(
    //     id: '',
    //     title: 'Rewass',
    //     start: DateTime.now().add(const Duration(days: 3)),
    //     end: DateTime.now().add(const Duration(days: 7)),
    //     actionStart: DateTime.now().subtract(const Duration(days: 1)),
    //     entity: 'DBS',
    //     module: 'event',
    //     moduleObjectId: '',
    //     location: 'Foyer',
    //     status: NewsStatus.published,
    //   ),
    //   News(
    //     id: '',
    //     title: 'Test 4',
    //     start: DateTime.now().subtract(const Duration(days: 2)),
    //     end: DateTime.now().subtract(const Duration(days: 1)),
    //     actionStart: DateTime.now().subtract(const Duration(days: 3)),
    //     entity: 'DBS',
    //     module: 'event',
    //     moduleObjectId: '',
    //     status: NewsStatus.published,
    //   ),
    // ]);
  }

  Future<News> createNews(News news) async {
    return News.fromJson(await create(news.toJson(), suffix: "news"));
  }

  Future<List<News>> getAllNews() async {
    return List<News>.from(
      (await getList(suffix: "admin/news")).map((e) => News.fromJson(e)),
    );
    // return Future.value([
    //   News(
    //     id: '',
    //     title: 'Test',
    //     start: DateTime.now().subtract(const Duration(days: 1)),
    //     entity: 'BDE',
    //     module: 'post',
    //     moduleObjectId: '',
    //     status: NewsStatus.waitingApproval,
    //   ),
    //   News(
    //     id: '',
    //     title: 'Vote',
    //     start: DateTime.now().subtract(const Duration(days: 2)),
    //     end: DateTime.now().add(const Duration(days: 2)),
    //     actionStart: DateTime.now().subtract(const Duration(days: 2)),
    //     entity: 'CAA',
    //     module: 'campagne',
    //     moduleObjectId: '',
    //     status: NewsStatus.waitingApproval,
    //   ),
    //   News(
    //     id: '',
    //     title: 'Rewass',
    //     start: DateTime.now().add(const Duration(days: 3)),
    //     end: DateTime.now().add(const Duration(days: 7)),
    //     actionStart: DateTime.now().subtract(const Duration(days: 1)),
    //     entity: 'DBS',
    //     module: 'event',
    //     moduleObjectId: '',
    //     location: 'Foyer',
    //     status: NewsStatus.waitingApproval,
    //   ),
    //   News(
    //     id: '',
    //     title: 'Test 4',
    //     start: DateTime.now().subtract(const Duration(days: 2)),
    //     end: DateTime.now().subtract(const Duration(days: 1)),
    //     actionStart: DateTime.now().subtract(const Duration(days: 3)),
    //     entity: 'DBS',
    //     module: 'event',
    //     moduleObjectId: '',
    //     status: NewsStatus.waitingApproval,
    //   ),
    // ]);
  }

  Future<bool> approveNews(String id) async {
    return await create({}, suffix: "admin/news/$id/approve");
  }

  Future<bool> rejectNews(String id) async {
    return await create({}, suffix: "admin/news/$id/reject");
  }
}
