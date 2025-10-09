import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:titan/auth/providers/openid_provider.dart';
import 'package:titan/rplace/class/pixel.dart';
import 'package:titan/rplace/providers/pixels_providers.dart';
import 'package:titan/rplace/ui/canvas_viewer.dart';
import 'package:titan/tools/ui/widgets/top_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/rplace/router.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class rPlacePage extends HookConsumerWidget {
  const rPlacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(tokenProvider);

    Future<WebSocketChannel> connect() async {
      final channel = WebSocketChannel.connect(
        Uri.parse('wss://hyperion-2.dev.eclair.ec-lyon.fr/rplace/ws'),
      );
      channel.sink.add(jsonEncode({"token": token}));
      return channel;
    }

    connect().then((WebSocketChannel channel) {
      channel.stream.listen((event) {
        final decodedJson = jsonDecode(event);
        if (decodedJson["command"] != "NEW_PIXEL") {
          return;
        }
        final pixel = Pixel.fromJson(decodedJson["data"]);
        ref.read(pixelListProvider.notifier).updatePixel(pixel);
      });
    });
    return const SafeArea(
      child: Column(
        children: [
          TopBar(title: "rPlace", root: rPlaceRouter.root),
          Expanded(child: CanvasViewer()),
        ],
      ),
    );
  }
}
