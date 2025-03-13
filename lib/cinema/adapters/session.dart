import 'package:myecl/generated/openapi.models.swagger.dart';

extension $CineSessionComplete on CineSessionComplete {
  CineSessionBase toCineSessionBase() {
    return CineSessionBase(
      start: start,
      duration: duration,
      name: name,
      overview: overview,
    );
  }

  CineSessionUpdate toCineSessionUpdate() {
    return CineSessionUpdate(
      name: name,
      start: start,
      duration: duration,
      overview: overview,
      genre: genre,
      tagline: tagline,
    );
  }
}
