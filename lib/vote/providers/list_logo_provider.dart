// import 'dart:typed_data';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:myecl/tools/providers/single_notifier.dart';
// import 'package:myecl/vote/providers/list_logos_provider.dart';
// import 'package:myecl/vote/repositories/list_logo_repository.dart';

// class ListLogoProvider extends SingleNotifier<Image> {
//   final ListLogoRepository listLogoRepository;
//   final ListLogoNotifier listLogosNotifier;
//   ListLogoProvider({
//     required this.listLogoRepository,
//     required this.listLogosNotifier,
//   }) : super(const AsyncValue.loading());

//   Future<Image> getLogo(String id) async {
//     return await listLogoRepository.getListLogo(id).then((image) {
//       listLogosNotifier.setTData(id, AsyncData([image]));
//       return image;
//     });
//   }

//   Future<Image> updateLogo(String id, Uint8List bytes) async {
//     final image = await listLogoRepository.addListLogo(bytes, id);
//     listLogosNotifier.setTData(id, AsyncData([image]));
//     return image;
//   }
// }

// final listLogoProvider =
//     StateNotifierProvider<ListLogoProvider, AsyncValue<Image>>((ref) {
//   final listLogoRepository = ref.watch(listLogoRepositoryProvider);
//   final listLogosNotifier = ref.watch(listLogosProvider.notifier);
//   return ListLogoProvider(
//     listLogoRepository: listLogoRepository,
//     listLogosNotifier: listLogosNotifier,
//   );
// });
