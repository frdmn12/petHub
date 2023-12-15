import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pethub/models/forum.dart';
import 'package:pethub/services/auth.dart';

class DatabaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();

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
    );

    await docForum.set(forum.toMap());
  }

  // getter for Forum List from collection
  Stream<List<Forum>> getForumList() {
    return FirebaseFirestore.instance.collection('forum')
    .snapshots()
    .map((snapshot) => snapshot.docs.map((doc) => Forum.fromJson(doc.data())).toList());
  }
}
