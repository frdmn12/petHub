import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pethub/models/comment.dart';
import 'package:pethub/models/forum.dart';
import 'package:pethub/services/auth.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// create forum
  Future createForum({
    required String content,
    required String category,
  }) async {
    String? uid = _auth.currentUser?.uid;
    String? name = _authService.firstName;
    String? email = _auth.currentUser?.email;

    final docForum = FirebaseFirestore.instance.collection('forum').doc();

    final forum = Forum(
      id: docForum.id,
      name: name,
      email: email,
      category: category,
      content: content,
      uid: uid ?? '',
      comments: [],
    );

    await docForum.set(forum.toMap());
  }

  // getter for Forum List from collection
  Stream<List<Forum>> getForumList() {
    return FirebaseFirestore.instance.collection('forum').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Forum.fromJson(doc.data())).toList());
  }

  Future<void> addCommentToForum(String forumId, Comment comment) async {
    await _firestore
        .collection('forums')
        .doc(forumId)
        .collection('comments')
        .doc(comment.id)
        .set(comment.toMap());
  }

  Stream<List<Comment>> getCommentsForForum(String forumId) {
    return _firestore
        .collection('forums')
        .doc(forumId)
        .collection('comments')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Comment.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<String> getCurrentUserId() async {
    User? user = _auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      throw Exception('User not found!');
    }
  }

  Stream<Forum> getForumById(String forumId) {
    return _firestore
        .collection('forum') // <-- 'forums' collection
        .doc(forumId)
        .snapshots()
        .map((snapshot) => Forum.fromMap(snapshot.data() ?? {}));
  }
}
