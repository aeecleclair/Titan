import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/meme/providers/ban_user_list_provider.dart';
import 'package:myecl/meme/providers/meme_pictures_provider.dart';
import 'package:myecl/meme/providers/hidden_meme_list_provider.dart';
import 'package:myecl/meme/providers/is_meme_admin_provider.dart';
import 'package:myecl/phonebook/providers/profile_picture_provider.dart';
import 'package:myecl/tools/functions.dart';
import 'package:myecl/tools/ui/builders/auto_loader_child.dart';
import 'package:myecl/tools/ui/widgets/dialog.dart';

class MemeCard extends ConsumerWidget {
  final Meme meme;
  final Uint8List image;
  final PageType page;
  const MemeCard({
    super.key,
    required this.meme,
    required this.image,
    required this.page,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}
