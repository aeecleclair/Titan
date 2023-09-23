import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:myecl/tools/ui/widgets/align_left_text.dart';
import 'package:myecl/tricount/class/equilibrium_transaction.dart';
import 'package:myecl/tricount/ui/pages/main_page/equilibrium_card.dart';

class SharerGroupStats extends StatelessWidget {
  final List<EquilibriumTransaction> equilibriumTransactions;
  const SharerGroupStats({super.key, required this.equilibriumTransactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, -5))
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: Column(
        children: [
          const SizedBox(height: 20),
          const AlignLeftText(
            "Pour équilibrer",
            color: Color(0xff09263d),
            padding: EdgeInsets.only(left: 30),
          ),
          const SizedBox(height: 20),
          AnimationLimiter(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: equilibriumTransactions.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                            horizontalOffset: 50.0,
                            child: FadeInAnimation(
                                child: EquilibriumCard(
                                    equilibriumTransaction:
                                        equilibriumTransactions[index]))));
                  }))
        ],
      ),
    );
  }
}
