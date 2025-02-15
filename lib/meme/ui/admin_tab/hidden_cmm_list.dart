import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/meme/class/meme.dart';
import 'package:myecl/meme/class/utils.dart';
import 'package:myecl/meme/providers/meme_list_provider.dart';
import 'package:myecl/meme/providers/hidden_meme_list_provider.dart';
import 'package:myecl/meme/ui/components/meme_card.dart';

class CustomPageViewScrollPhysics extends ScrollPhysics {
  const CustomPageViewScrollPhysics({super.parent});

  @override
  CustomPageViewScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomPageViewScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 50,
        stiffness: 500,
        damping: 1,
      );
}

class HiddenMemeList extends ConsumerStatefulWidget {
  const HiddenMemeList({super.key});

  @override
  MemeListState createState() => MemeListState();
}

class MemeListState extends ConsumerState<HiddenMemeList> {
  final PageController _pageController = PageController();
  final List<Meme> _memeList = [];
  bool _isLoadingMore = false;
  int _pageKey = 1;

  @override
  void initState() {
    super.initState();
    _fetchMeme(); // Load the first page
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    if (_pageController.page == _memeList.length - 2 && !_isLoadingMore) {
      _fetchMeme();
    }
  }

  Future<void> _fetchMeme() async {
    setState(() => _isLoadingMore = true);
    final hiddenMemeListNotifier = ref.read(hiddenMemeProvider.notifier);

    final newCmmList = await hiddenMemeListNotifier.getHiddenMeme(_pageKey);

    newCmmList.when(
      data: (data) {
        setState(() {
          _memeList.addAll(data);
          _pageKey++;
          _isLoadingMore = false;
        });
      },
      loading: () {},
      error: (err, stack) {
        setState(() => _isLoadingMore = false);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      physics: CustomPageViewScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: _memeList.length,
      itemBuilder: (context, index) {
        final meme = _memeList[index];
        return FutureBuilder<Uint8List>(
          future: ref.read(memeListProvider.notifier).getMemeImage(meme.id),
          builder: (context, imageSnapshot) {
            if (!imageSnapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return MemeCard(
              meme: meme,
              image: imageSnapshot.data!,
              page: PageType.hidden,
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
