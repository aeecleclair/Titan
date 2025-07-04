import 'package:flutter/material.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';
import 'package:titan/tools/ui/widgets/date_entry.dart';

class EventForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final TextEditingController locationController;
  final TextEditingController placesController;
  final TextEditingController externalLinkController;

  const EventForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.startDateController,
    required this.endDateController,
    required this.locationController,
    required this.placesController,
    required this.externalLinkController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Add padding at the bottom for the navbar
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        key: const ValueKey('event_form'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Event Form - Event with more details including dates
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
            controller: startDateController,
            label: "Date de début",
          ),
          const SizedBox(height: 20),
          DateEntry(
            onTap: () async {
              // Parse start date if available
              DateTime startDate = DateTime.now();
              if (startDateController.text.isNotEmpty) {
                try {
                  final parts = startDateController.text.split('/');
                  startDate = DateTime(
                    int.parse(parts[2]), // year
                    int.parse(parts[1]), // month
                    int.parse(parts[0]), // day
                  );
                } catch (e) {
                  // Use current date as fallback
                }
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
            controller: endDateController,
            label: "Date de fin",
          ),
          const SizedBox(height: 20),
          TextEntry(label: "Lieu", controller: locationController),
          const SizedBox(height: 20),
          TextEntry(
            label: "Nombre de places",
            controller: placesController,
            keyboardType: TextInputType.number,
            isInt: true,
          ),
          const SizedBox(height: 20),
          TextEntry(
            label: "Lien externe",
            controller: externalLinkController,
            canBeEmpty: true,
          ),
          const SizedBox(height: 40),
          Button(
            text: "Créer l'événement",
            onPressed: () {
              // Validate required fields
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

              // TODO: Implement event submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Événement créé avec succès')),
              );
            },
          ),
          // Add extra bottom padding for navbar
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
