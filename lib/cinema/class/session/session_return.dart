import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:myecl/cinema/class/session/session.dart';

part 'session_return.freezed.dart';
part 'session_return.g.dart';

@freezed
class SessionReturn with _$SessionReturn {

  factory SessionReturn({
    required String name,
    required DateTime start,
    required int duration,
    required String? overview,
    required String? genre,
    required String? tagline,
  }) = _SessionReturn;

  factory SessionReturn.fromJson(Map<String, dynamic> json) => _$SessionReturnFromJson(json);

  factory SessionReturn.fromSession(Session session) {
    return SessionReturn(
      name: session.name,
      start: session.start,
      duration: session.duration,
      overview: session.overview,
      genre: session.genre,
      tagline: session.tagline,
    );
  }
}