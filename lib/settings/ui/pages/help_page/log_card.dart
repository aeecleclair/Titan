import 'package:f_logs/f_logs.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:myecl/settings/tools/constants.dart';
import 'package:myecl/tools/functions.dart';

class LogCard extends StatelessWidget {
  final Log log;
  const LogCard({Key? key, required this.log}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = log.logLevel == LogLevel.DEBUG
        ? [const Color(0xff00c3ff), const Color(0xff0077ff)]
        : log.logLevel == LogLevel.INFO
            ? [const Color(0xff549227), const Color(0xFF3E721A)]
            : log.logLevel == LogLevel.WARNING
                ? [const Color(0xfffc9a01), const Color(0xffee8300)]
                : log.logLevel == LogLevel.ERROR
                    ? [const Color(0xffc72c41), const Color(0xff801336)]
                    : [const Color(0xff222830), Colors.black];

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
            color: color.withOpacity(0.2),
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
                log.timestamp.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: log.text ?? ""));
                  displayToast(
                      context, TypeMsg.msg, SettingsTextConstants.copied);
                },
                child: const HeroIcon(
                  HeroIcons.clipboard,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            log.text ?? '',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
