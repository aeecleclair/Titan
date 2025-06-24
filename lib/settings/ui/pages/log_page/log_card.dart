import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:titan/settings/tools/constants.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/logs/log.dart';

class LogCard extends StatelessWidget {
  final Log log;
  const LogCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    List<Color> colors = log.level == LogLevel.debug
        ? [const Color(0xff00c3ff), const Color(0xff0077ff)]
        : log.level == LogLevel.info
        ? [const Color(0xff549227), const Color(0xFF3E721A)]
        : log.level == LogLevel.warning
        ? [const Color(0xfffc9a01), const Color(0xffee8300)]
        : log.level == LogLevel.error
        ? [const Color(0xffc72c41), const Color(0xff801336)]
        : [
            const Color.fromARGB(255, 198, 190, 21),
            const Color.fromARGB(255, 187, 178, 14),
          ];

    Color color = colors[0];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: colors,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(3, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                log.time.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: log.message));
                  displayToast(
                    context,
                    TypeMsg.msg,
                    SettingsTextConstants.copied,
                  );
                },
                child: const HeroIcon(HeroIcons.clipboard, color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            log.message,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
