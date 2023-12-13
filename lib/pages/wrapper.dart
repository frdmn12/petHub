import "package:flutter/material.dart";
import "package:pethub/models/myuser.dart";
import "package:pethub/pages/introPages/login.dart";
import "package:pethub/pages/introPages/welcome.dart";
import "package:pethub/pages/mainPages/home.dart";
import "package:pethub/pages/mainPages/index.dart";
import "package:provider/provider.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);

  // Return Home atau Login
    // Sebagai penentu nanti login atau !login
    if (user == null) {
      return LoginPage();
    } else {
      return const Index();
    }
  }
}
