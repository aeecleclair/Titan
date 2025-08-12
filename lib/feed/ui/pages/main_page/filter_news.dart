import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/providers/filter_state_provider.dart';
import 'package:titan/feed/providers/news_list_provider.dart';
import 'package:titan/tools/constants.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/item_chip.dart';

class FilterNewsModal extends HookWidget {
  final List<String> entities, modules;
  const FilterNewsModal({
    super.key,
    required this.entities,
    required this.modules,
  });

  @override
  Widget build(BuildContext context) {
    return HookConsumer(
      builder: (context, ref, child) {
        final newsListNotifier = ref.watch(newsListProvider.notifier);
        final filterState = ref.watch(filterStateProvider);
        final filterStateNotifier = ref.watch(filterStateProvider.notifier);
        return BottomModalTemplate(
          title: 'Filtrer',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Association'),
              SizedBox(height: 10),
              HorizontalListView(
                height: 50,
                children: entities
                    .map(
                      (entity) => ItemChip(
                        selected: filterState.selectedEntities.contains(entity),
                        onTap: () {
                          if (filterState.selectedEntities.contains(entity)) {
                            filterStateNotifier.setFilterState(
                              filterState.copyWith(
                                selectedEntities: filterState.selectedEntities
                                  ..remove(entity),
                              ),
                            );
                          } else {
                            filterStateNotifier.setFilterState(
                              filterState.copyWith(
                                selectedEntities: filterState.selectedEntities
                                  ..add(entity),
                              ),
                            );
                          }
                          if (filterState.selectedEntities.isEmpty &&
                              filterState.selectedModules.isEmpty) {
                            newsListNotifier.resetFilters();
                          } else {
                            newsListNotifier.filterNews(
                              filterState.selectedEntities,
                              filterState.selectedModules,
                            );
                          }
                          newsListNotifier.filterNews(
                            filterState.selectedEntities,
                            filterState.selectedModules,
                          );
                        },
                        child: Text(
                          entity,
                          style: TextStyle(
                            color: filterState.selectedEntities.contains(entity)
                                ? ColorConstants.background
                                : ColorConstants.onTertiary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 30),
              Text('Type d\'annonce'),
              SizedBox(height: 10),
              HorizontalListView(
                height: 50,
                children: modules
                    .map(
                      (module) => ItemChip(
                        selected: filterState.selectedModules.contains(module),
                        onTap: () {
                          if (filterState.selectedModules.contains(module)) {
                            filterStateNotifier.setFilterState(
                              filterState.copyWith(
                                selectedModules: filterState.selectedModules
                                  ..remove(module),
                              ),
                            );
                          } else {
                            filterStateNotifier.setFilterState(
                              filterState.copyWith(
                                selectedModules: filterState.selectedModules
                                  ..add(module),
                              ),
                            );
                          }
                          if (filterState.selectedEntities.isEmpty &&
                              filterState.selectedModules.isEmpty) {
                            newsListNotifier.resetFilters();
                          } else {
                            newsListNotifier.filterNews(
                              filterState.selectedEntities,
                              filterState.selectedModules,
                            );
                          }
                        },
                        child: Text(
                          module,
                          style: TextStyle(
                            color: filterState.selectedModules.contains(module)
                                ? ColorConstants.background
                                : ColorConstants.onTertiary,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 40),
              Button(
                text: 'Appliquer',
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
