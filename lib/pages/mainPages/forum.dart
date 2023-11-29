import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Temukan Forum tentang Hewan Peliharaan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
                height: 20), // Menambah ruang kosong antara teks dan search bar
            Container(
              width: double.infinity, // Menggunakan lebar penuh
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Forum...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hot Topics',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildCategoryBox('c/dogs'),
                buildCategoryBox('c/cats'),
                buildCategoryBox('c/snake'),
                buildCategoryBox('c/hamsters'),
                buildCategoryBox('c/lovebirds'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildCategoryBox('c/gecko'),
                buildCategoryBox('c/turtle'),
                buildCategoryBox('c/tortoise'),
                buildCategoryBox('c/kitten'),
                buildCategoryBox('c/iguana'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryBox(String categoryName) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey, // Warna latar belakang kotak
      ),
      child: Text(
        categoryName,
        style: TextStyle(
          color:
              const Color.fromARGB(255, 0, 0, 0), // Warna teks di dalam kotak
        ),
      ),
    );
  }
}
