import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:myecl/CMM/class/cmm.dart';
import 'package:myecl/CMM/providers/cmm_list_provider.dart';
import 'package:myecl/CMM/ui/components/cmm_card.dart';
import 'package:myecl/admin/class/account_type.dart';
import 'package:myecl/tools/cache/cache_manager.dart';
import 'package:myecl/user/class/list_users.dart';

class CMMList extends ConsumerStatefulWidget {
  const CMMList({super.key});

  @override
  CMMListState createState() => CMMListState();
}

class CMM {
  CMM({
    required this.id,
    required this.user,
    required this.myVote,
    required this.voteScore,
    required this.status,
    required this.path,
  });
  late final String id;
  late final SimpleUser user;
  late final bool? myVote;
  late final int voteScore;
  late final String status;
  late String path;
}

class CMMListState extends ConsumerState<CMMList> {
  final cache = CacheManager();
  static const _pageSize = 2;

  final PagingController<int, CMM> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  List<CMM> getCMMImage(String id) {
    return [
      CMM(
        id: '1',
        user: SimpleUser(
          name: "Ñool",
          firstname: "Ñool",
          nickname: "Ñool",
          id: "A",
          accountType: AccountType(type: "Student"),
        ),
        path: "assets/images/cmm.jpg",
        myVote: true,
        voteScore: 300,
        status: "neutral",
      ),
    ];
  }

  Future<void> _fetchPage(int pageKey) async {
    final newItems = getCMMImage(pageKey.toString());
    final isLastPage = newItems.length < _pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(newItems);
    } else {
      final nextPageKey = pageKey;
      _pagingController.appendPage(newItems, nextPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, CMM>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<CMM>(
        itemBuilder: (context, cmm, index) {
          return CMMCard(
            path: cmm.path,
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
