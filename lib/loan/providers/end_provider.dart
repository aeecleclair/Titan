import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:titan/generated/openapi.models.swagger.dart';
import 'package:titan/tools/functions.dart';

class EndNotifier extends Notifier<String> {
  @override
  String build() {
    return "";
  }

  void setEnd(String end) {
    state = end;
  }

  void setEndFromSelected(String start, List<Item> selected, String locale) {
    state = DateFormat.yMd(locale).format(
      DateTime.parse(processDateBack(start, locale)).add(
        Duration(
          days: selected
              .map((item) => item.suggestedLendingDuration)
              .reduce(min),
        ),
      ),
    );
  }
}

final endProvider = NotifierProvider<EndNotifier, String>(EndNotifier.new);
