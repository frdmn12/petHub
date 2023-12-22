import 'package:flutter/material.dart';

class HealthySigns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mengenali Tanda Tanda Kesehatan Hewan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: ListView(
            children: [
              Text(
                'Tanda-tanda kesehatan pada anjing dan kucing sangat penting untuk diidentifikasi agar pemilik'
                ' dapat merespon dengan cepat dan mengambil tindakan yang diperlukan. Berikut adalah beberapa'
                ' tanda umum yang dapat menunjukkan kesehatan baik pada anjing maupun kucing:',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                'Anjing:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildListItem('1. Makan dan Minum',
                  'Anabul mamiliki nafsu makan yang baik dan minum air dengan cukup'),
              _buildListItem('2. Perilaku',
                  'Anabul terlihat aktif ketika bermain dan tidak terlihat lesu atau menunjukkan perubahan yang mendadak dari tingkah laku nya'),
              _buildListItem('3. Bulu dan Kulit',
                  'Bulu terlihat bersih dan berkilau, tidak terdapat area ruam dan kebotakan, terakhir, kulit elastis dan tidak kering'),
              _buildListItem('4. Kotoran dan Buang Air Kecil',
                  'Feses yang dikeluarkan normal tidak berlendir dan tidak terdapat kesulitan dalam buang air kecil'),
              _buildListItem('5. Mata dan Hidung',
                  'Mata terlihat bersih dan jernih tidak terdapat kotoran seperti bercak putih dan Hidung terlihat lembab dan bersih (tidak ada lendir)'),
              SizedBox(height: 16),
              Text(
                'Kucing:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              _buildListItem('1. Makan dan Minum',
                  'Kucing mamiliki nafsu makan yang baik dan minum air dengan cukup'),
              _buildListItem('2. Perilaku',
                  'Kucing terlihat aktif ketika bermain dan tidak terlihat lesu atau menunjukkan perubahan yang mendadak dari tingkah laku nya'),
              _buildListItem('3. Bulu dan Kulit',
                  'Bulu terlihat bersih dan berkilau, tidak terdapat area ruam dan kebotakan, terakhir, kulit elastis dan tidak kering'),
              _buildListItem('4. Kotoran dan Buang Air Kecil',
                  'Feses yang dikeluarkan normal tidak berlendir dan tidak terdapat kesulitan dalam buang air kecil'),
              _buildListItem('5. Mata dan Hidung',
                  'Mata terlihat bersih dan jernih tidak terdapat kotoran seperti bercak putih dan Hidung terlihat lembab dan bersih (tidak ada lendir)'),
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
