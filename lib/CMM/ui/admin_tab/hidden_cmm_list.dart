import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/class/utils.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/CMM/providers/hidden_cmm_list_provider.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';

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

class HiddenCMMList extends ConsumerStatefulWidget {
  const HiddenCMMList({super.key});

  @override
  CMMListState createState() => CMMListState();
}

class CMMListState extends ConsumerState<HiddenCMMList> {
  final PageController _pageController = PageController();
  final List<CMM> _cmmList = [];
  bool _isLoadingMore = false;
  int _pageKey = 1;

  @override
  void initState() {
    super.initState();
    _fetchCMM(); // Load the first page
    _pageController.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    if (_pageController.page == _cmmList.length - 2 && !_isLoadingMore) {
      _fetchCMM();
    }
  }

  Future<void> _fetchCMM() async {
    setState(() => _isLoadingMore = true);
    final hiddenCMMListNotifier = ref.read(hiddenCMMProvider.notifier);

    final newCmmList = await hiddenCMMListNotifier.getHiddenCMM(_pageKey);

    newCmmList.when(
      data: (data) {
        setState(() {
          _cmmList.addAll(data);
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
      itemCount: _cmmList.length,
      itemBuilder: (context, index) {
        final cmm = _cmmList[index];
        return FutureBuilder<Uint8List>(
          future: ref.read(cmmListProvider.notifier).getCMMImage(cmm.id),
          builder: (context, imageSnapshot) {
            if (!imageSnapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return CMMCard(
              cmm: cmm,
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
