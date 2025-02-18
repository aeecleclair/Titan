import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      child: const Row(children: [
        CircleAvatar(
          radius: 27,
          backgroundColor: Color(0xff017f80),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText("Maxime Roucher (Khurzs)",
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xff204550),
                    fontSize: 14,
                  ),),
              SizedBox(
                height: 5,
              ),
              Text("Bar - Rewass",
                  style: TextStyle(
                    color: Color(0xff204550),
                    fontSize: 12,
                  ),),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text("- 2,50€",
            style: TextStyle(
                color: Color(0xff204550),
                fontSize: 18,
                fontWeight: FontWeight.bold,),),
      ],),
    );
  }
}
