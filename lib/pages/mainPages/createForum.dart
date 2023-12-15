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


