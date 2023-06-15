import 'package:flutter/material.dart';

import '../../Services/dbhelper.dart';


class ScoresPage extends StatefulWidget {
  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {
  late Future<List<Map<String, dynamic>>> _scores;

  @override
  void initState() {
    super.initState();
    _loadScores();
  }

  Future<void> _loadScores() async {
    final dbHelper = DatabaseHelper.instance;
    _scores = dbHelper.getScores();
  }
  Future<void> _clearScores() async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.clearScores();
    setState(() {
      _scores = dbHelper.getScores();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaydedilen Sonuçlar'),
        actions: [
          IconButton(onPressed: () {
            _clearScores();
          }, icon: Icon(Icons.delete_forever))
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _scores,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }

          final scores = snapshot.data ?? [];

          if (scores.isEmpty) {
            return Center(child: Text('Henüz kaydedilen sonuç bulunmuyor.'));
          }

          return ListView.builder(
            itemCount: scores.length,
            itemBuilder: (context, index) {
              final score = scores[index];
              final username = score['username'];
              final scoreValue = score['score'];

              return ListTile(
                title: Text(username,style: TextStyle(color: Colors.black),),
                subtitle: Text('Puan: $scoreValue'),
              );
            },
          );
        },
      ),
    );
  }
}