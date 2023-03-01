import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:myecl/advert/class/advert.dart';
import 'package:myecl/advert/providers/advert_provider.dart';
import 'package:myecl/advert/providers/announcer_provider.dart';
import 'package:myecl/advert/tools/constants.dart';
import 'package:myecl/advert/ui/pages/admin_page/announcer_bar.dart';
import 'package:myecl/advert/ui/pages/form/text_entry.dart';
import 'package:myecl/tools/ui/shrink_button.dart';

class AddEditAdvertPage extends HookConsumerWidget {
  const AddEditAdvertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advert = ref.watch(advertProvider);
    final isEdit = advert.id != Advert.empty().id;
    final title = useTextEditingController(text: advert.title);
    final content = useTextEditingController(text: advert.content);

    final tags = advert.tags;
    var textTags = tags.join(', ');
    final textTagsController = useTextEditingController(text: textTags);
    
    final selected = ref.watch(announcerProvider);

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            TextEntry(
              minLines: 1,
              maxLines: 1,
              keyboardType: TextInputType.text,
              label: AdvertTextConstants.title,
              suffix: '',
              isInt: false,
              controller: title,
              onChanged: (value) {},
            ),
            TextEntry(
              minLines: 5,
              maxLines: 20,
              keyboardType: TextInputType.multiline,
              label: AdvertTextConstants.content,
              suffix: '',
              isInt: false,
              controller: content,
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 15,
            ),
            const AnnouncerBar(),
            TextEntry(
              minLines: 1,
              maxLines: 1,
              keyboardType: TextInputType.text,
              label: AdvertTextConstants.tags,
              suffix: '',
              isInt: false,
              controller: textTagsController,
              onChanged: (value) {},
            ),
            ShrinkButton(
              waitChild: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(3, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: const Center(
                  child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              onTap: () async {},
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset:
                            const Offset(3, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                      isEdit
                          ? AdvertTextConstants.edit
                          : AdvertTextConstants.add,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold))),
            )
          ],
        ),
      ),
    );
  }
}
