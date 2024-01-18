// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
// import 'package:myecl/tools/ui/widgets/align_left_text.dart';
// import 'package:myecl/tricount/class/balance.dart';
// import 'package:myecl/tricount/ui/pages/components/equilibrium_card.dart';
// import 'package:myecl/user/class/list_users.dart';

// class SharerGroupStats extends StatelessWidget {
//   final List<Balance> balances;
//   final List<SimpleUser> members;
//   const SharerGroupStats(
//       {super.key, required this.balances, required this.members});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: max(
//           MediaQuery.of(context).size.height - 380, balances.length * 85 + 80),
//       width: double.infinity,
//       decoration: BoxDecoration(
//           gradient: const LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [Color(0xff1C4668), Color(0xff09263D)]),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xff09263D).withOpacity(0.2),
//               blurRadius: 10,
//               offset: const Offset(0, -5),
//             ),
//           ],
//           borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30), topRight: Radius.circular(30))),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 30),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             const AlignLeftText(
//               "Pour équilibrer",
//               color: Colors.white,
//             ),
//             const SizedBox(height: 20),
//             AnimationLimiter(
//                 key: ValueKey(balances),
//                 child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemCount: balances.length,
//                     itemBuilder: (context, index) {
//                       return AnimationConfiguration.staggeredList(
//                           position: index,
//                           duration: const Duration(milliseconds: 375),
//                           child: SlideAnimation(
//                               horizontalOffset: 50.0,
//                               child: FadeInAnimation(
//                                   child: EquilibriumCard(
//                                 balance: balances[index],
//                                 members: members,
//                               ))));
//                     }))
//           ],
//         ),
//       ),
//     );
//   }
// }
