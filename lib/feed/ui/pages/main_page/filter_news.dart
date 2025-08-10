import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/providers/news_list_provider.dart';
import 'package:titan/tools/ui/layouts/horizontal_list_view.dart';
import 'package:titan/tools/ui/layouts/item_chip.dart';
import 'package:titan/tools/ui/styleguide/bottom_modal_template.dart';
import 'package:titan/tools/ui/styleguide/button.dart';

class FilterNewsModal extends StatelessWidget {
  final List<String> entities, modules;
  const FilterNewsModal({
    super.key,
    required this.entities,
    required this.modules,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final newsListNotifier = ref.watch(newsListProvider.notifier);
        final selectedEntities = useState<List<String>>([]);
        final selectedModules = useState<List<String>>([]);
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
                        selected: selectedEntities.value.contains(entity),
                        onTap: () {
                          if (selectedEntities.value.contains(entity)) {
                            selectedEntities.value.remove(entity);
                          } else {
                            selectedEntities.value.add(entity);
                          }
                          if (selectedEntities.value.isEmpty &&
                              selectedModules.value.isEmpty) {
                            newsListNotifier.resetFilters();
                          } else {
                            newsListNotifier.filterNews(
                              selectedEntities.value,
                              selectedModules.value,
                            );
                          }
                          newsListNotifier.filterNews(
                            selectedEntities.value,
                            selectedModules.value,
                          );
                        },
                        child: Text(entity),
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
                        selected: selectedModules.value.contains(module),
                        onTap: () {
                          if (selectedModules.value.contains(module)) {
                            selectedModules.value.remove(module);
                          } else {
                            selectedModules.value.add(module);
                          }
                          if (selectedEntities.value.isEmpty &&
                              selectedModules.value.isEmpty) {
                            newsListNotifier.resetFilters();
                          } else {
                            newsListNotifier.filterNews(
                              selectedEntities.value,
                              selectedModules.value,
                            );
                          }
                        },
                        child: Text(module),
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
