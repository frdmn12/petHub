import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatelessWidget {
  final List<String> items = [
    'Perawatan Gigi untuk Anjing dan Kucing',
    'Mengenali Tanda Tanda Kesehatan',
    'Persentase Kematian Anjing dan Kucing',
    // Add more items as needed
  ];

  final List<Map<String, dynamic>> buttons = [
    {'name': 'Pet Store', 'icon': 'assets/images/Shopping bag.png'},
    {'name': 'Pet Food', 'icon': 'assets/images/Dog Food.png'},
    {'name': 'Health', 'icon': 'assets/images/Veterinary.png'},
    {'name': 'Adoption', 'icon': 'assets/images/Dog.png'},
    {'name': 'Event', 'icon': 'assets/images/World animal day.png'},
  ];

  Color getRandomColor() {
    List<Color> predefinedColors = [
      Color.fromARGB(255, 251, 240, 178),
      Color.fromARGB(255, 255, 199, 234),
      Color.fromARGB(255, 216, 180, 248),
      Color.fromARGB(255, 202, 237, 255),
      Color.fromARGB(255, 255, 85, 187),
      Color.fromARGB(255, 255, 211, 163),
      Color.fromARGB(255, 252, 255, 178),
      Color.fromARGB(255, 182, 234, 250),
    ];

    return predefinedColors[Random().nextInt(predefinedColors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, Adi',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Good Morning',
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    // Handle button tap (e.g., navigate to profile page)
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        AssetImage('assets/images/Profile Photo.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            Text(
              'Explorer',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return _buildExplorerItem(
                    context,
                    items[index],
                    getRandomColor(),
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Forum',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  return _buildButton(
                    buttons[index]['name'],
                    buttons[index]['icon'],
                  );
                },
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Tag Place',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  child: GoogleMap(
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(-6.1753924, 106.8249641),
                      zoom: 14.0,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExplorerItem(
      BuildContext context, String itemName, Color boxColor) {
    return Container(
      width: 210,
      height: 105,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle button press (e.g., navigate to a different page)
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 0, 0, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.black, width: 1.0),
                  ),
                  minimumSize: Size(60, 30),
                ),
                child: Text(
                  'Read More',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String buttonName, dynamic icon) {
    return Container(
      width: 65,
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 65,
            height: 50,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 221, 221, 221),
              borderRadius: BorderRadius.circular(8),
            ),
            child: InkWell(
              onTap: () {
                // Handle button press (e.g., navigate to a different page)
              },
              child: icon is IconData
                  ? IconButton(
                      onPressed: () {
                        // Handle button press for system icons
                      },
                      icon: Icon(
                        icon,
                        color: Colors.black,
                      ),
                    )
                  : Image.asset(
                      icon,
                      color: Colors.black,
                    ),
            ),
          ),
          SizedBox(height: 5),
          InkWell(
            onTap: () {
              // Handle button press (e.g., navigate to a different page)
            },
            child: Text(
              buttonName,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
