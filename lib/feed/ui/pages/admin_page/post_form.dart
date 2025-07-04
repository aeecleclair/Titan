import 'package:flutter/material.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/date_entry.dart';
import 'package:titan/tools/ui/styleguide/image_entry.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

class PostForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController startDateController;

  const PostForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.startDateController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        key: const ValueKey('post_form'),
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
            text: "Publier",
            onPressed: () {
              if (titleController.text.isEmpty ||
                  descriptionController.text.isEmpty) {
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
                const SnackBar(content: Text('Post créé avec succès')),
              );
            },
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
