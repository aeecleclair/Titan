import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/vote/providers/result_provider.dart';
import 'package:myecl/vote/providers/sections_pretendance_provider.dart';
import 'package:myecl/vote/providers/sections_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:universal_html/html.dart';

void openExcel(WidgetRef ref) {
  final sectionsPretendance = ref.watch(sectionPretendanceProvider);
  final sections = ref.watch(sectionsProvider);
  final results = ref.watch(resultProvider);
  List<String> sectionNames = [];
  Map<String, int> voteValue = {};
  results.whenData(
    (votes) {
      for (var i = 0; i < votes.length; i++) {
        voteValue[votes[i].id] = votes[i].count;
      }
    },
  );

  final Map<int, String> sectionIds = {};
  int total = 0;
  final Workbook workbook = Workbook();
  final Worksheet sheet = workbook.worksheets[0];
  int j = 1;
  sections.whenData((value) {
    for (final section in value) {
      sectionsPretendance.whenData((data) {
        if (data[section] != null) {
          data[section]!.whenData((data) {
            sectionNames = data.map((e) => e.name).toList();
            sectionIds.addAll({for (var e in data) data.indexOf(e): e.id});
            total = data.map((e) => voteValue[e.id]).reduce(
                    (value, element) => (value ?? 0) + (element ?? 0)) ??
                0;
          });
          sheet.getRangeByName('A1').setText('Section');
          sheet.getRangeByName('B1').setText('Votes');
          sheet.getRangeByName('C1').setText('Percentage');
          sheet.getRangeByName('D1').setText('Total');
          sheet.getRangeByName('D${j + 1}')
          .setNumber(total.toDouble());
          for (var i = 0; i < sectionNames.length; i++) {
            sheet.getRangeByName('A${j + i + 2}').setText(sectionNames[i]);
            sheet.getRangeByName('B${j + i + 2}').setNumber(voteValue[sectionIds[i]] != null ? voteValue[sectionIds[i]]!.toDouble() : 0);
            sheet.getRangeByName('C${j + i + 2}').setFormula(
                '=B${i + 2}/D2');
          }
          j += sectionNames.length + 1;
        }
      });
    }
  });
    final List<int> bytes = workbook.saveAsStream();
  workbook.dispose();
  const String fileName = 'vote.xlsx';
  const String mimeType =
      'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
  final String base64 = base64Encode(bytes);
  final String href = 'data:$mimeType;base64,$base64';
  final AnchorElement downloadAnchor = AnchorElement(href: href);
  downloadAnchor.download = fileName;
  downloadAnchor.click();
}
