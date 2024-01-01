import 'package:flutter/material.dart';
import 'package:pethub/pages/mainPages/Explorer/DeathPercentage.dart';
import 'package:pethub/pages/mainPages/Explorer/DentalCarePage.dart';
import 'package:pethub/pages/mainPages/Explorer/HealthySigns.dart';

class DetailPage extends StatelessWidget {
  final int index1;

  DetailPage({required this.index1});

  final pages = [
    DentalCarePage(),
    HealthySigns(),
    DeathPercentage(),
  ];

  @override
  Widget build(BuildContext context) {
    String pageTitle = index1 < pages.length
        ? pages[index1].toString()
        : 'Detail Page'; // Page title can be adjusted based on your requirements

    return Scaffold(
      body: IndexedStack(
        index: index1,
        children: pages,
      ),
    );
  }
}
