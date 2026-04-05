import 'package:titan/ticketing/class/event.dart';
import 'package:titan/ticketing/class/category.dart';
import 'package:titan/tools/repository/repository.dart';

class CategoryRepository extends Repository {
  @override
  // ignore: overridden_fields
  final ext = 'ticketing/';

  Future<List<Category>> getAllCategory(String eventId) async {
    return Event.fromJson(await getOne('events/$eventId')).categories;
  }

  Future<Category> getCategory(String id) async {
    print("Fetching category with id: $id");
    return Category.fromJson(await getOne(id, suffix: 'categories'));
  }
}
