import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pethub/services/auth.dart';
import 'package:pethub/services/database.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';

class CreateForumPage extends StatefulWidget {
  const CreateForumPage({super.key});

  @override
  State<CreateForumPage> createState() => _CreateForumPageState();
}

class _CreateForumPageState extends State<CreateForumPage> {
  // instance
  final DatabaseService _database = DatabaseService();
  final ChatGpt chatGpt =
      ChatGpt(apiKey: "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");

  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _keywordController =
      TextEditingController(text: "Find Keyword");

  // Future generateKeywords() async {
  //   try {
  //     final Uri uri =
  //         Uri.parse('https://api.openai.com/v1/engines/davinci/completions');

  //     final http.Response response = await http.post(
  //       uri,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer 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',
  //       },
  //       body: jsonEncode({
  //         'prompt':
  //             'Generate keywords from this content: ${_contentController.text}',
  //         'max_tokens': 60,
  //         // 'model': 'davinci',
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final Map<String, dynamic> data = jsonDecode(response.body);
  //       final String keywords = data['choices'][0]['text'].toString();

  //       setState(() {
  //         _keywordController.text = keywords;
  //       });
  //     } else {
  //       print(response.body.toString());
  //       throw Exception('Failed to generate keywords');
  //     }
  //   } catch (e) {
  //     print('Error generating keywords: $e');
  //   }
  // }

  Future generateKeywords(String sentence) async {
    try {
      final url = Uri.parse('http://10.0.2.2:8000/forum/extract');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, dynamic>{'sentence': sentence}),
      );

      if (response.statusCode == 200) {
        final List<String> keywords =
            List<String>.from(jsonDecode(response.body));
        setState(() {
          _keywordController.text = keywords.join(', ');
        });
        print(keywords);
      } else {
        print('Response body: ${response.body}');
        throw Exception('Failed to generate keywords');
      }
    } catch (e) {
      print('Error generating keywords: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buat Forum"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(hintText: 'Input Content'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  // Ini untuk generate keywords pake openai
                  // generateKeywords();

                  // Ini untuk generate keywords pake express
                  generateKeywords(_contentController.text.toString());
                },
                child: const Text("Generate keyword")),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                _keywordController.text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(hintText: 'Input Category'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                dynamic result = await _database.createForum(
                    content: _contentController.text,
                    category: _categoryController.text);

                if (result != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Success'),
                        content: Text('Forum successfully created'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text("Create"),
            ),
          ],
        ),
      ),
    );
  }
}
