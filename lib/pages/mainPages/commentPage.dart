import 'package:flutter/material.dart';
import 'package:pethub/models/comment.dart';
import 'package:pethub/models/forum.dart';
import 'package:pethub/services/auth.dart';
import 'package:pethub/services/database.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';

class CommentPage extends StatefulWidget {
  final String forumId;

  CommentPage({required this.forumId});

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController commentController = TextEditingController();
  final DatabaseService _database = DatabaseService();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: Column(
        children: [
          Container(
            constraints: BoxConstraints(
              minHeight: 75, // Set the desired minimum height
            ),
            child: StreamBuilder<Forum>(
              stream: _database.getForumById(widget.forumId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data == null) {
                  return Text('Forum details not available.');
                }

                Forum forum = snapshot.data!;
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          forum.name ?? 'No Name',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          forum.content ?? 'No Content',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Comment>>(
              stream: _database.getCommentsForForum(widget.forumId),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Comment>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('No comments yet.'),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Comments:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: snapshot.data!.map((comment) {
                          return Card(
                            margin: EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: ListTile(
                              title: Text(
                                'User :  ${comment.userId}',
                                style: TextStyle(fontSize: 16),
                              ),
                              subtitle: Text('CComment : ${comment.content} '),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      // Add a text field for new comments
      bottomNavigationBar: KeyboardAttachable(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  // Code when the button is clicked
                  String commentContent = commentController.text.trim();
                  if (commentContent.isNotEmpty) {
                    String userId = await _database.getCurrentUserId();
                    String? firstName = await _auth.firstName;

                    Comment newComment = Comment(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      userId: firstName ?? 'No Name',
                      content: commentContent,
                    );

                    await _database.addCommentToForum(
                      widget.forumId,
                      newComment,
                    );

                    commentController.clear();
                  }
                },
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.send,
                    size: 25,
                    color: Colors.orange[200],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
