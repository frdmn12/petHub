import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
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
                      "Adi Ageng",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text("adiageng@gmail.com", style: TextStyle(fontSize: 15),)
                  ],
                )
              ],
            ),
          SizedBox(height: 30),
          Expanded(child: ListView(
            children: [
              buildButtonRow(Icons.person, "My Profile"),
              buildButtonRow(Icons.settings, "Settings"),
              buildButtonRow(Icons.notifications, "Notifications"),
              buildButtonRow(Icons.help, "FAQ"),
              buildButtonRow(Icons.info, "About App"),
              const SizedBox(height: 20,),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // Handle Button
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


