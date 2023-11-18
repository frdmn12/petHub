import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pethub/pages/home_page.dart';
import './forum_page.dart';
import './map_page.dart';
import './profil_page.dart';

class Index extends StatefulWidget {
  const Index({super.key});
  @override
  IndexState createState() => IndexState();
}

class IndexState extends State<Index> {
  int pageIndex = 0;

  final pages = [
    const HomePage(),
    const ForumPage(),
    const MapPage(),
    const ProfilPage(),
  ];

  

  void changePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[pageIndex],
      bottomNavigationBar: buildNavBar(context, pageIndex, changePage),
    );
  }
}

Container buildNavBar(BuildContext context, int currentIndex, Function(int) onTap) {

  Color iconColor(int index) {
    return currentIndex == index ? Colors.orange : Colors.grey;
  }
  return Container(
    height: 60,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () => onTap(0),
          icon: Icon(
            Icons.home_outlined,
            color: iconColor(0),
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () => onTap(1),
          icon: Icon(
            Icons.message_outlined,
            color: iconColor(1),
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () => onTap(2),
          icon: Icon(
            Icons.location_on_outlined,
            color: iconColor(2),
            size: 30,
          ),
        ),
        IconButton(
          onPressed: () => onTap(3),
          icon: Icon(
            Icons.person_outline_rounded,
            color: iconColor(3),
            size: 30,
          ),
        ),
      ],
    ),
  );
}

