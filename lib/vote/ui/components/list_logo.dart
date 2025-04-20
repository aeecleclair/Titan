// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:myecl/generated/openapi.models.swagger.dart';
// import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
// import 'package:myecl/vote/providers/list_logo_provider.dart';
// import 'package:myecl/vote/providers/list_logos_provider.dart';

// class ListLogo extends HookConsumerWidget {
//   final ListReturn list;
//   const ListLogo(this.list, {super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final listLogos =
//         ref.watch(listLogosProvider.select((value) => value[list.id]));
//     final listLogosNotifier = ref.read(listLogosProvider.notifier);
//     final logoNotifier = ref.read(listLogoProvider.notifier);
//     return AutoLoaderChild(
//       group: listLogos,
//       notifier: listLogosNotifier,
//       mapKey: list.id,
//       loader: (listId) => logoNotifier.getLogo(list.id),
//       dataBuilder: (context, logo) => Container(
//         width: 40,
//         height: 40,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           image: DecorationImage(
//             image: logo.first.image,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
