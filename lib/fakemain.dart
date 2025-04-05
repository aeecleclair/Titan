import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AnnouncementScreen(),
    );
  }
}

class AnnouncementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Annonce'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section des icônes
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIcon('Bazar', Icons.shopping_bag),
                  _buildIcon('WEI', Icons.festival),
                  _buildIcon('Eclair', Icons.flash_on),
                  _buildIcon('BDS', Icons.nightlife),
                ],
              ),
            ),
            // Onglets
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Text('Épinglés'),
                  SizedBox(width: 16),
                  Text('Associations'),
                ],
              ),
            ),
            // Onglet "Tous"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Tous'),
            ),
            // Liste des annonces
            _buildAnnouncementCard(
              date: '21 Déc.',
              title: 'Rewass de Noël',
              category: 'Rewass',
              description:
                  'Lorem ipsum is simply dummy text of the printing and typesetting industry...',
              user: 'Baroc',
              publishDate: '20 décembre 2024',
            ),
            _buildAnnouncementCard(
              date: '21 Déc.',
              title: 'Rewass de Noël',
              category: 'Rewass',
              description:
                  'Lorem ipsum is simply dummy text of the printing and typesetting industry...',
              user: 'Baroc',
              publishDate: '20 décembre 2024',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 40),
        Text(label),
      ],
    );
  }

  Widget _buildAnnouncementCard({
    required String date,
    required String title,
    required String category,
    required String description,
    required String user,
    required String publishDate,
  }) {
    return Card(
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(date),
                Text(
                  category,
                  style: TextStyle(backgroundColor: Colors.grey[300]),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(description),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 4),
                    Text(user),
                  ],
                ),
                Text(publishDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
