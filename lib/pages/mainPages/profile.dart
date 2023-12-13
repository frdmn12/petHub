import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pethub/services/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // Mendapatkan informasi pengguna yang sedang masuk dari FirebaseAuth
    User? currentUser = FirebaseAuth.instance.currentUser;

    String? firstName = _auth.firstName;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage:
                          AssetImage('assets/images/Profile Photo.png'),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      firstName ?? 'Nama tidak tersedia',
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentUser?.email ?? 'Email tidak tersedia',
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
                child: ListView(
              children: [
                buildButtonRow(Icons.person, "My Profile"),
                buildButtonRow(Icons.settings, "Settings"),
                buildButtonRow(Icons.notifications, "Notifications"),
                buildButtonRow(Icons.help, "FAQ"),
                buildButtonRow(Icons.info, "About App"),
                const SizedBox(
                  height: 20,
                ),
                buildButtonRow(Icons.logout, "Logout")
              ],
            ))
          ],
        ),
      ),
    );
  }
}

Widget buildButtonRow(IconData icon, String label) {
  final AuthService auth = AuthService();

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: InkWell(
      onTap: () async {
        if (label == "Logout") {
          await auth.signOut();
        } else {
          print("Press Button Logout to Logout");
        }
      },
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}
