import 'package:flutter/material.dart';

class DeathPercentage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Persentase Kematian Anjing dan Kucing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: ListView(
            children: [
              Text(
                'Persentase Kematian dari Hewan Peliharaan tergantung dari cara perawatan yang diberikan. '
                'Berikut beberapa penyebab yang sering mengakibatkan kematian pada Anjing dan Kucing:',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              _buildListItem('1. Penyakit Jantung',
                  'Penyebab utama dari kebanyakan kematian anjing adalah penyakit jantung. Biasanya penyakit ini kebanyakan berasal dari orang tua atau turunan. '),
              _buildListItem('2. Trauma dan Kecelakaan',
                  'Trauma dan kecelakaan seperti Cedera fisik, kecelakaan kendaraan, atau trauma lainnya dapat menyebabkan kematian mendadak apabila kita salah dalam merawat mereka. Sehingga kita perlu memberikan perhatian lebih atau khusus pada anabul yang baru saja mengalami sebuah kecelakaan atau trauma untuk membuat mereka terhindar dari traumatic tersebut.'),
              _buildListItem('3. Faktor Usia',
                  'Tidak daoat dipungkiri lagi bahwa kematian pada anabul juga kebanyakan disebabkan oleh faktor usia. Sehingga kita perlu untuk memastikan bahwa kita sudah melakukan treatment yang baik pada anabul kita.'),
              _buildListItem('4. Kanker',
                  'Kematian anabul juga kebanyakan disebabkan oleh penyakit kanker seperti, kanker kulit, tulang, dan kelenjar getah bening. Biasanya penyakit ini bermula dari pola makan atau makanan yang diberikan pada anabul yang tidak sesuai karena tidak semua makanan manusia baik untuk anabul.'),
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
          '$title:',
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
