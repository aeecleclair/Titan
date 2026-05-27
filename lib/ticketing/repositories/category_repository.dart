import 'package:titan/ticketing/class/category.dart';
import 'package:titan/tools/repository/repository.dart';

class CategoryRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'ticketing/';

  Future<List<Category>> getAllCategory(String sessionId) async {
    return (await getList(
      suffix: 'sessions/$sessionId/categories',
    )).map((e) => Category.fromJson(e)).toList();
  }

  Future<Category> getCategory(String id) async {
    return Category.fromJson(await getOne(id, suffix: 'categories'));
  }
}
