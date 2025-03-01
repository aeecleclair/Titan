import 'package:myecl/generated/openapi.models.swagger.dart';

extension $PaperComplete on PaperComplete {
  PaperBase toPaperBase() {
    return PaperBase(
      name: name,
      releaseDate: releaseDate,
    );
  }
}