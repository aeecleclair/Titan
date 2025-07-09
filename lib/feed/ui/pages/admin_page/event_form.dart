import 'package:flutter/material.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/image_entry.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/tools/ui/styleguide/date_entry.dart';

class EventForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController locationController;
  final TextEditingController shotgunDateController;
  final TextEditingController externalLinkController;

  const EventForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.startDateController,
    required this.endDateController,
    required this.locationController,
    required this.shotgunDateController,
    required this.externalLinkController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        key: const ValueKey('event_form'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextEntry(label: "Titre", controller: titleController),
          const SizedBox(height: 20),
          TextEntry(
            label: "Description",
            controller: descriptionController,
            maxLines: 5,
            minLines: 3,
          ),
          const SizedBox(height: 20),
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
                startDateController.text = formattedDate;
              }
            },
            title: "Date de début",
            subtitle: "Sélectionnez une date",
          ),
          const SizedBox(height: 20),
          DateEntry(
            onTap: () async {
              DateTime startDate = DateTime.now();
              if (startDateController.text.isNotEmpty) {
                final parts = startDateController.text.split('/');
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
                endDateController.text = formattedDate;
              }
            },
            title: "Date de fin",
            subtitle: "Sélectionnez une date",
          ),
          const SizedBox(height: 20),
          TextEntry(label: "Lieu", controller: locationController),
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          TextEntry(
            label: "Lien externe pour le SG",
            controller: externalLinkController,
            canBeEmpty: true,
          ),
          const SizedBox(height: 20),
          ImageEntry(
            title: "Image",
            subtitle: "Sélectionnez une image",
            onTap: () {
              // Logic to add an image
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Image ajoutée')));
            },
          ),
          const SizedBox(height: 40),
          Button(
            text: "Créer l'événement",
            onPressed: () {
              if (titleController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  startDateController.text.isEmpty ||
                  endDateController.text.isEmpty ||
                  locationController.text.isEmpty) {
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
                const SnackBar(content: Text('Événement créé avec succès')),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
