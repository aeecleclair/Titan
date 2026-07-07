// Injects a static `empty()` factory into every generated model class.
//
// swagger_dart_code_generator emits the models; this post-step adds, to each
// class, a constructor-filling `empty()` whose required fields get
// type-appropriate empties (recursively for nested models):
//
//   class X {
//     static X empty() => X(field: ...);
//     ...
//   }
//
// Call it as `X.empty()`. Run after build_runner (idempotent):
//
//   dart run tool/gen_empty_models.dart

import 'dart:io';

const _modelsPath = 'lib/generated/openapi.models.swagger.dart';
const _enumsPath = 'lib/generated/openapi.enums.swagger.dart';

void main() {
  final modelsSrc = File(_modelsPath).readAsStringSync();
  final enumsSrc = File(_enumsPath).readAsStringSync();

  final enumDefaults = _parseEnumDefaults(enumsSrc);
  final classes = _parseClasses(modelsSrc);
  final byName = {for (final c in classes) c.name: c};

  final lines = modelsSrc.split('\n');
  final out = StringBuffer();
  var injected = 0;

  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    out.writeln(line);

    final m = RegExp(r'^class (\w+) \{').firstMatch(line);
    if (m == null) continue;
    final c = byName[m.group(1)!];
    if (c == null) continue;

    // Idempotent: skip if the static was already injected on a prior run.
    // `dart format` (run by codegen.dart after this step) may wrap a long
    // signature so the return type and `empty()` land on separate lines, e.g.
    //   static VeryLongClassName
    //   empty() => VeryLongClassName(
    // so the next line reads just `static <ClassName>`. Match both forms.
    final next = i + 1 < lines.length ? lines[i + 1].trimLeft() : '';
    if (next.startsWith('static ${c.name} empty(') ||
        next == 'static ${c.name}') {
      continue;
    }

    if (c.requiredFields.isEmpty) {
      out.writeln('  static ${c.name} empty() => ${c.name}();');
    } else {
      out.writeln('  static ${c.name} empty() => ${c.name}(');
      for (final f in c.requiredFields) {
        out.writeln('    ${f.name}: ${_emptyFor(f.type, enumDefaults)},');
      }
      out.writeln('  );');
    }
    injected++;
  }

  File(_modelsPath).writeAsStringSync(out.toString());
  stdout.writeln('Injected empty() into $injected models -> $_modelsPath');
}

class _Field {
  _Field(this.name, this.type);
  final String name;
  final String type;
}

class _Class {
  _Class(this.name, this.requiredFields);
  final String name;
  final List<_Field> requiredFields;
}

/// Maps enum name -> first concrete value identifier (skips the
/// `swaggerGeneratedUnknown` sentinel).
Map<String, String> _parseEnumDefaults(String src) {
  final map = <String, String>{};
  final blocks = RegExp(r'enum (\w+) \{([\s\S]*?)\n\}').allMatches(src);
  for (final b in blocks) {
    final name = b.group(1)!;
    final body = b.group(2)!;
    final values = RegExp(r'^\s*(\$?\w+)\(', multiLine: true)
        .allMatches(body)
        .map((m) => m.group(1)!)
        .where((v) => v != 'swaggerGeneratedUnknown')
        .toList();
    if (values.isNotEmpty) map[name] = values.first;
  }
  return map;
}

List<_Class> _parseClasses(String src) {
  final lines = src.split('\n');
  final classes = <_Class>[];

  for (var i = 0; i < lines.length; i++) {
    final m = RegExp(r'^class (\w+) \{').firstMatch(lines[i]);
    if (m == null) continue;
    final name = m.group(1)!;

    // Collect the class block (closes at a line that is exactly `}`).
    var j = i + 1;
    final block = StringBuffer();
    while (j < lines.length && lines[j] != '}') {
      block.writeln(lines[j]);
      j++;
    }
    final body = block.toString();

    // Field name -> declared type, e.g. `final Map<String, dynamic> x;`.
    final fieldTypes = <String, String>{};
    for (final fm in RegExp(
      r'^  final (.+) (\w+);',
      multiLine: true,
    ).allMatches(body)) {
      fieldTypes[fm.group(2)!] = fm.group(1)!.trim();
    }

    // Required constructor params, in declaration order.
    final required = <_Field>[];
    final ctor = RegExp(
      'const $name'
      r'\(\{([\s\S]*?)\}\);',
    ).firstMatch(body);
    if (ctor != null) {
      for (final rm in RegExp(
        r'required this\.(\w+)',
      ).allMatches(ctor.group(1)!)) {
        final fname = rm.group(1)!;
        final type = fieldTypes[fname];
        if (type != null) required.add(_Field(fname, type));
      }
    }

    classes.add(_Class(name, required));
    i = j;
  }
  return classes;
}

String _emptyFor(String type, Map<String, String> enumDefaults) {
  final t = type.trim();
  if (t.endsWith('?')) return 'null'; // required but nullable
  switch (t) {
    case 'String':
      return "''";
    case 'int':
    case 'num':
      return '0';
    case 'double':
      return '0.0';
    case 'bool':
      return 'false';
    case 'DateTime':
      return 'DateTime(2000)';
    case 'dynamic':
      return 'null';
    case 'Object':
      return "''";
  }
  if (t.startsWith('List<')) return 'const []';
  if (t.startsWith('Map<')) return 'const {}';
  if (t.startsWith('enums.')) {
    // Enums are referenced through the `enums` prefix inside the models file.
    final e = t.substring('enums.'.length);
    final value = enumDefaults[e];
    return value == null ? '$t.values.first' : '$t.$value';
  }
  // Nested generated model -> recurse through its own static empty().
  return '$t.empty()';
}
