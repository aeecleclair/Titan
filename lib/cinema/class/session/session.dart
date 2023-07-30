import 'package:freezed_annotation/freezed_annotation.dart';

part 'session.freezed.dart';
part 'session.g.dart';

@freezed
class Session with _$Session {

  factory Session({
    required String id,
    required String name,
    required DateTime start,
    required int duration,
    required String? overview,
    required String? genre,
    required String? tagline,
  }) = _Session;

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

  factory Session.empty() {
    return Session(
      id: '',
      name: '',
      start: DateTime.now(),
      duration: 0,
      overview: '',
      genre: '',
      tagline: '',
    );
  }
}