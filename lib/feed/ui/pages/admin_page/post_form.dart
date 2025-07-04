import 'package:flutter/material.dart';
import 'package:titan/tools/ui/styleguide/button.dart';
import 'package:titan/tools/ui/styleguide/text_entry.dart';

class PostForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const PostForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Add padding at the bottom for the navbar
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
      child: Column(
        key: const ValueKey('post_form'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Post Form - Simple post with title and description
          TextEntry(label: "Titre", controller: titleController),
          const SizedBox(height: 20),
          TextEntry(
            label: "Description",
            controller: descriptionController,
            maxLines: 5,
            minLines: 3,
          ),
          const SizedBox(height: 40),
          Button(
            text: "Publier",
            onPressed: () {
              // Validate required fields
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

              // TODO: Implement post submission
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post créé avec succès')),
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
