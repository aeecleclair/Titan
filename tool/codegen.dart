// One-shot codegen: runs build_runner, then injects `static empty()` into every
// generated model.
//
//   dart run tool/codegen.dart
//
// build_runner can't run the second step itself (it mutates build_runner's own
// output — see tool/gen_empty_models.dart), so use this instead of a bare
// `build_runner build`. Extra args are forwarded to build_runner, e.g.:
//
//   dart run tool/codegen.dart --build-filter=lib/generated/**

import 'dart:io';

Future<void> main(List<String> args) async {
  await _run('dart', [
    'run',
    'build_runner',
    'build',
    '--delete-conflicting-outputs',
    ...args,
  ]);
  await _run('dart', ['run', 'tool/gen_empty_models.dart']);
  // Re-format the models file: gen_empty_models injects raw source lines.
  await _run('dart', ['format', 'lib/generated/openapi.models.swagger.dart']);
}

Future<void> _run(String exe, List<String> args) async {
  stdout.writeln('\$ $exe ${args.join(' ')}');
  final process = await Process.start(
    exe,
    args,
    mode: ProcessStartMode.inheritStdio,
  );
  final code = await process.exitCode;
  if (code != 0) exit(code);
}
