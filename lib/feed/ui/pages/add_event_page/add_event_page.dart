import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/class/news.dart';
import 'package:titan/feed/providers/admin_news_list_provider.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/tools/functions.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/date_entry.dart';
import 'package:titan/tools/ui/styleguide/icon_button.dart';
import 'package:titan/tools/ui/styleguide/image_entry.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

class AddEventPage extends HookConsumerWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventTitleController = useTextEditingController();
    final eventLocationController = useTextEditingController();
    final shotgunDateController = useTextEditingController();
    final eventExternalLinkController = useTextEditingController();
    final eventStartDateController = useTextEditingController();
    final eventEndDateController = useTextEditingController();

    final adminNewsListNotifier = ref.watch(adminNewsListProvider.notifier);

    void displayToastWithContext(TypeMsg type, String msg) {
      displayToast(context, type, msg);
    }

    return FeedTemplate(
      child: Expanded(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              key: const ValueKey('event_form'),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextEntry(label: "Titre", controller: eventTitleController),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextEntry(
                        label: "Date de début ",
                        controller: eventStartDateController,
                        enabled: false,
                      ),
                    ),
                    CustomIconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          eventStartDateController.text =
                              "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextEntry(
                        label: "Date de fin ",
                        controller: eventEndDateController,
                        enabled: false,
                      ),
                    ),
                    CustomIconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          eventEndDateController.text =
                              "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextEntry(label: "Lieu", controller: eventLocationController),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextEntry(
                        label: "Date du SG ",
                        controller: shotgunDateController,
                        enabled: false,
                      ),
                    ),
                    CustomIconButton(
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                      ),
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        );
                        if (date != null) {
                          shotgunDateController.text =
                              "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10),
                TextEntry(
                  label: "Lien externe pour le SG",
                  controller: eventExternalLinkController,
                  canBeEmpty: true,
                ),
                const SizedBox(height: 10),
                ImageEntry(
                  title: "Image",
                  subtitle: "Sélectionnez une image",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Image ajoutée')),
                    );
                  },
                ),
                const SizedBox(height: 40),
                Button(
                  text: "Créer l'événement",
                  onPressed: () async {
                    if (eventTitleController.text.isEmpty ||
                        eventStartDateController.text.isEmpty ||
                        eventEndDateController.text.isEmpty ||
                        eventLocationController.text.isEmpty) {
                      displayToastWithContext(
                        TypeMsg.error,
                        "Veuillez remplir tous les champs obligatoires.",
                      );
                      return;
                    }
                    final newNews = News.empty().copyWith(
                      title: eventTitleController.text,
                      start: DateTime.parse(
                        processDateBack(eventStartDateController.text),
                      ),
                      end: DateTime.parse(
                        processDateBack(eventEndDateController.text),
                      ),
                      location: eventLocationController.text,
                      actionStart: DateTime.parse(
                        processDateBack(shotgunDateController.text),
                      ),
                      // externalLink: eventExternalLinkController.text,
                    );
                    final value = await adminNewsListNotifier.addNews(newNews);
                    if (value) {
                      displayToastWithContext(
                        TypeMsg.msg,
                        "Événement créé avec succès !",
                      );
                    } else {
                      displayToastWithContext(
                        TypeMsg.error,
                        "Échec de la création de l'événement.",
                      );
                    }
                  },
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
