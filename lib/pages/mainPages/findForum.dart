import 'package:flutter/material.dart';
import 'package:pethub/models/forum.dart';
import 'package:pethub/services/database.dart';

class FindForumPage extends StatefulWidget {
  FindForumPage({Key? key}) : super(key: key);

  @override
  State<FindForumPage> createState() => _FindForumPageState();
}

class _FindForumPageState extends State<FindForumPage> {
  final TextEditingController _findContentController = TextEditingController();
  final DatabaseService _database = DatabaseService();

  List<Forum> forumList = []; // List Forum dari database
  List<Forum> filteredList = []; // List Forum yang difilter
  Forum? selectedForum;

  @override
  void initState() {
    super.initState();
    _findContentController.addListener(onSearchChanged);
    loadForumContent(); // Memuat data forum dari database
  }

  // Memuat data forum dari database
  void loadForumContent() {
    _database.getForumList().listen((List<Forum> forums) {
      setState(() {
        forumList = forums; // Mengisi list forum dengan data dari database
        filteredList =
            forumList; // Mengisi list yang difilter dengan seluruh list forum
      });
    });
  }

  void onSearchChanged() {
    setState(() {
      filteredList = forumList
          .where((forum) => forum.content
              .toLowerCase()
              .contains(_findContentController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Autocomplete<Forum>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return Iterable<Forum>.empty();
            }
            return filteredList.where((forum) => forum.content
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase()));
          },
          displayStringForOption: (forum) => forum.content,
          onSelected: (Forum? forum) {
            setState(() {
              selectedForum = forum; // Menyimpan forum yang dipilih
            });
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: selectedForum != null
                ? ForumPostWidget(
                    username: selectedForum!.name ?? 'Unknown',
                    category: selectedForum!.category ?? 'Uncategorized',
                    title: selectedForum!.category ?? 'Untitled',
                    content: selectedForum!.content,
                  )
                : StreamBuilder<List<Forum>>(
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
                            username: forum.name ?? 'Unknown',
                            category: forum.category ?? 'Uncategorized',
                            title: forum.category ?? 'Untitled',
                            content: forum.content,
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
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
                      onPressed: () {},
                    ),
                    Text('Like'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_down),
                      onPressed: () {},
                    ),
                    Text('Dislike'),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () {},
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
