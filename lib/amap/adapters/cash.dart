import 'package:myecl/generated/openapi.models.swagger.dart';

extension $CashComplete on CashComplete {
  CashEdit toCashEdit() {
    return CashEdit(balance: balance);
  }
}
