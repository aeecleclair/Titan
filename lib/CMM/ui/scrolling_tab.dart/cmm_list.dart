import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';

class CMMList extends ConsumerStatefulWidget {
  const CMMList({super.key});

  @override
  CMMListState createState() => CMMListState();
}

class CMMListState extends ConsumerState<CMMList> {
  static const _pageSize = 5;

  final PagingController<int, CMM> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    final cmmListNotifier = ref.watch(cmmListProvider.notifier);

    final asyncValue = await cmmListNotifier.getCMM(pageKey);

    asyncValue.when(
      data: (newItems) {
        final isLastPage = newItems.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newItems, nextPageKey);
        }
      },
      loading: () {},
      error: (error, stack) {
        _pagingController.error = error;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cmmListNotifier = ref.watch(cmmListProvider.notifier);
    return PagedListView<int, CMM>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<CMM>(
        itemBuilder: (context, cmm, index) {
          return FutureBuilder<Uint8List>(
            future: cmmListNotifier.getCMMImage(cmm.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text("Erreur lors du chargement de l'image");
              } else if (snapshot.hasData) {
                return CMMCard(
                  cmm: cmm,
                  image: snapshot.data!,
                );
              } else {
                return const Text("Aucune donnée disponible");
              }
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
