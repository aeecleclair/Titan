import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:titan/tools/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class TextWithHyperLink extends StatelessWidget {
  const TextWithHyperLink(
    this.text, {
    super.key,
    this.style,
    this.linkStyle,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textKey,
    this.presetFontSizes,
    this.group,
    this.overflowReplacement,
    this.minFontSize = 12,
    this.maxFontSize = double.infinity,
    this.stepGranularity = 1,
    this.wrapWords = true,
  });

  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;
  final Key? textKey;
  final double minFontSize;
  final double maxFontSize;
  final double stepGranularity;
  final List<double>? presetFontSizes;
  final AutoSizeGroup? group;
  final bool wrapWords;
  final Widget? overflowReplacement;

  void openLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw '$unableToOpen $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hyperLinkStyle =
        linkStyle ??
        theme.textTheme.bodyMedium?.copyWith(
          color: ColorConstants.gradient1,
          decoration: TextDecoration.underline,
        );

    final words = text.split(' ');

    return AutoSizeText.rich(
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
      textKey: textKey,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      stepGranularity: stepGranularity,
      presetFontSizes: presetFontSizes,
      group: group,
      wrapWords: wrapWords,
      overflowReplacement: overflowReplacement,
      TextSpan(
        children: words.map((e) {
          final isLink = e.startsWith('https://');
          final recognizer = TapGestureRecognizer()
            ..onTap = () {
              openLink(e);
            };
          return TextSpan(
            text: '$e ',
            style: isLink ? hyperLinkStyle : style,
            recognizer: isLink ? recognizer : null,
          );
        }).toList(),
      ),
    );
  }
}
