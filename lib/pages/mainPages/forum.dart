import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pethub/models/forum.dart';
import 'package:pethub/pages/mainPages/createForum.dart';
import 'package:pethub/pages/mainPages/findForum.dart';
import 'package:pethub/services/auth.dart';
import 'package:pethub/services/database.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  List<bool> isSelected = List.generate(10, (index) => false);

  AuthService authService = AuthService();
  final DatabaseService _database = DatabaseService();

  TextEditingController titleController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController contentController = TextEditingController();

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Temukan Forum tentang Hewan Peliharaan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => {
                        Navigator.push(
                            context,
                            PageTransition(
                                child:  FindForumPage(),
                                type: PageTransitionType.leftToRight))
                      },
                  child: Icon(Icons.search)),
            ),
            // Container(
            //   width: double.infinity,
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: 'Search Forum...',
            //       prefixIcon: const Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(8),
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hot Topics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildCategoryBox('c/dogs', 0),
                buildCategoryBox('c/cats', 1),
                buildCategoryBox('c/snake', 2),
                buildCategoryBox('c/hamsters', 3),
                buildCategoryBox('c/lovebirds', 4),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<Forum>>(
                stream: _database.getForumList(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Forum>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Tidak ada data.'));
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Forum forum = snapshot.data![index];
                      return ForumPostWidget(
                        username: forum.name ?? '',
                        category: forum.category,
                        title: forum.category,
                        content: forum.content,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  child: const CreateForumPage(),
                  duration: const Duration(milliseconds: 400),
                  type: PageTransitionType.leftToRight));
        },
        child: Icon(Icons.add),
        tooltip: 'Buat Forum',
      ),
    );
  }

  Widget buildCategoryBox(String categoryName, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected[index] = !isSelected[index];
        });
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected[index] ? Colors.orange : Colors.grey,
        ),
        child: Text(
          categoryName,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
    );
  }
}

class ForumPostWidget extends StatelessWidget {
  final String username;
  final String category;
  final String title;
  final String content;

  ForumPostWidget({
    required this.username,
    required this.category,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage:
                      AssetImage('assets/images/Profile Photo.png'),
                ),
                SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username),
                    Text(category),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text(content),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up),
                      onPressed: () {
                        // Implement like functionality
                      },
                    ),
                    Text('Like'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_down),
                      onPressed: () {
                        // Implement dislike functionality
                      },
                    ),
                    Text('Dislike'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {
                        // Implement share functionality
                      },
                    ),
                    Text('Share'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
