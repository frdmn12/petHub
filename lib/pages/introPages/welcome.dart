import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'login.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/images/Dogpaw.png')),
            SizedBox(height: 20),
            Text(
              'Hello!',
              style: TextStyle(
                  fontSize: 60,
                  fontFamily: 'Rubik Bubbles',
                  color: Color(0xFFA96D25)),
            ),
            Text('We are happy to see you here!',
                style: TextStyle(fontSize: 25)),
            SizedBox(height: 75),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    duration: Duration(milliseconds: 1000),
                    child: LoginPage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xFFA96D25), // Warna latar belakang tombol
                onPrimary: Colors.white, // Warna teks tombol
                minimumSize: Size(150, 50), // Ukuran tombol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Border radius
                ),
              ),
              child: Text(
                'Get Started',
                style: TextStyle(fontFamily: 'Roboto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
