import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pethub/services/auth.dart';
import 'package:pethub/services/database.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateForumPage extends StatefulWidget {
  const CreateForumPage({super.key});

  @override
  State<CreateForumPage> createState() => _CreateForumPageState();
}

class _CreateForumPageState extends State<CreateForumPage> {
  // instance
  final DatabaseService _database = DatabaseService();

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _keywordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Forum"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _categoryController,
            decoration: InputDecoration(
              hintText: 'Input Category'
            ),
          ),
          TextFormField(
            controller: _contentController,
            decoration: InputDecoration(
              hintText: 'Input Content'
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                dynamic result = await _database.createForum(
                    content: _contentController.text,
                    category: _categoryController.text);
              },
              child: Text("Create")),
          Text(_keywordController.text),
          ElevatedButton(
              onPressed: () async {
                  // Ambil _Content
                  // Jalankan keyword
                  // getKeywordsFromText(_contentController.text);
              },
              child: Text("Generate keyword")),
            
        ],
      ),
    );
  }
}

// Future<List<String>> getKeywordsFromText(String text) async {
//   var apiKey = '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';
//   var endpoint = 'https://api.openai.com/v1/engines/your_engine/keywords';

//   var response = await http.post(
//     Uri.parse(endpoint),
//     headers: {
//       'Content-Type': 'application/json',
//       'Authorization': 'Bearer $apiKey',
//     },
//     body: jsonEncode({'text': text}),
//   );

//   if (response.statusCode == 200) {
//     Map<String, dynamic> data = jsonDecode(response.body);
//     List<String> keywords = List<String>.from(data['keywords']);
//     return keywords;
//   } else {
//     throw Exception('Failed to load keywords');
//   }
// }


