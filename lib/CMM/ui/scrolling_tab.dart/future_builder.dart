import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Future<String> _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = fetchData();
  }

  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2)); // Simuler un délai
    return 'Données chargées !';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur : ${snapshot.error}');
        } else {
          return Text(snapshot.data!);
        }
      },
    );
  }
}
