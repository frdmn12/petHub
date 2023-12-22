import 'package:flutter/material.dart';

class DentalCarePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perawatan Gigi untuk Anjing dan Kucing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: ListView(
            children: [
              Text(
                'Perawatan gigi untuk anjing dan kucing sangat penting untuk menjaga kesehatan mereka secara'
                ' keseluruhan. Berikut adalah ringkasan mengenai perawatan gigi untuk hewan peliharaan:',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              _buildListItem('1. Pemeriksaan Rutin',
                  'Lakukan pemeriksaan gigi secara rutin oleh dokter hewan untuk mendeteksi masalah gigi atau gusi sejak dini.'),
              _buildListItem('2. Pembersihan Gigi',
                  'Berikan makanan khusus atau mainan yang dapat membantu membersihkan gigi alami hewan peliharaan. Gunakan sikat gigi khusus hewan peliharaan dan pasta gigi hewan untuk membersihkan gigi secara teratur.'),
              _buildListItem('3. Makanan Khusus',
                  'Pertimbangkan memberikan makanan kering atau makanan basah yang dirancang khusus untuk merawat gigi hewan peliharaan.'),
              _buildListItem('4. Mainan Pengunyah',
                  'Berikan mainan pengunyah yang dapat membantu membersihkan gigi dan merangsang gusi.'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 18,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
