import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:titan/feed/ui/feed.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/date_entry.dart';
import 'package:titan/tools/ui/styleguide/image_entry.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

class AddEventPage extends HookConsumerWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventTitleController = useTextEditingController();
    final eventDescriptionController = useTextEditingController();
    final eventLocationController = useTextEditingController();
    final shotgunDateController = useTextEditingController();
    final eventExternalLinkController = useTextEditingController();
    final eventStartDateController = useTextEditingController();
    final eventEndDateController = useTextEditingController();

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
                TextEntry(
                  label: "Description",
                  controller: eventDescriptionController,
                  maxLines: 5,
                  minLines: 3,
                ),
                DateEntry(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      final formattedDate =
                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                      eventStartDateController.text = formattedDate;
                    }
                  },
                  title: "Date de début",
                  subtitle: "Sélectionnez une date",
                ),
                DateEntry(
                  onTap: () async {
                    DateTime startDate = DateTime.now();
                    if (eventStartDateController.text.isNotEmpty) {
                      final parts = eventStartDateController.text.split('/');
                      startDate = DateTime(
                        int.parse(parts[2]),
                        int.parse(parts[1]),
                        int.parse(parts[0]),
                      );
                    }

                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: startDate,
                      firstDate: startDate,
                      lastDate: startDate.add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      final formattedDate =
                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                      eventEndDateController.text = formattedDate;
                    }
                  },
                  title: "Date de fin",
                  subtitle: "Sélectionnez une date",
                ),
                TextEntry(label: "Lieu", controller: eventLocationController),
                DateEntry(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (pickedDate != null) {
                      final formattedDate =
                          "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                      shotgunDateController.text = formattedDate;
                    }
                  },
                  title: "Date et heure du SG",
                  subtitle: "Sélectionnez une date",
                ),
                TextEntry(
                  label: "Lien externe pour le SG",
                  controller: eventExternalLinkController,
                  canBeEmpty: true,
                ),
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
                  onPressed: () {
                    if (eventTitleController.text.isEmpty ||
                        eventDescriptionController.text.isEmpty ||
                        eventStartDateController.text.isEmpty ||
                        eventEndDateController.text.isEmpty ||
                        eventLocationController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Veuillez remplir tous les champs obligatoires',
                          ),
                        ),
                      );
                      return;
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Événement créé avec succès'),
                      ),
                    );
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
