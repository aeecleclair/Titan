import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/repositories/cmm_repository.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';

class CMMList extends StatefulWidget {
  const CMMList({super.key});

  @override
  CMMListState createState() => CMMListState();
}

class CMMListState extends State<CMMList> {
  static const _pageSize = 3;

  final PagingController<int, CMM> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  final cmmRepo = CMMRepository();
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await cmmRepo.getCMM(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = (pageKey + newItems.length).toInt();
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) =>
      // Don't worry about displaying progress or error indicators on screen; the
      // package takes care of that. If you want to customize them, use the
      // [PagedChildBuilderDelegate] properties.
      PagedListView<int, CMM>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CMM>(
          itemBuilder: (context, cmm, index) => CMMCard(
            string: cmm.path,
            user: cmm.user,
            vote: cmm.vote,
            score: cmm.score,
          ),
        ),
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
