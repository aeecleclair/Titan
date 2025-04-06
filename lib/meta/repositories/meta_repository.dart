import 'package:myecl/meta/class/meta.dart';
import 'package:myecl/tools/repository/repository.dart';

abstract class MetaRepository<T extends Meta> extends Repository {
  Future<List<T>> getMetas({int limit = 30, String? after});
  Future<T> getMeta(String id);
  Future<T> addMeta(T meta);
  Future<bool> updateMeta(T meta);
  Future<bool> deleteMeta(String id);
}
