import 'package:flutter/material.dart';

class Showtrippage extends StatefulWidget {
  const Showtrippage({super.key});

  @override
  State<Showtrippage> createState() => _ShowtrippageState();
}

class _ShowtrippageState extends State<Showtrippage> {
  String selectedCategory = 'ทั้งหมด';

  final List<Map<String, String>> trips = [
    {
      'title': 'อันซีนสวิตเซอร์แลนด์',
      'country': 'ประเทศสวิตเซอร์แลนด์',
      'duration': 'ระยะเวลา 10 วัน',
      'price': '119900',
      'image': 'assets/images/logo.png',
    },
    {
      'title': 'สิงคโปร์ SENTOSA ยูนิเวอร์แซล',
      'country': 'ประเทศสิงคโปร์',
      'duration': 'ระยะเวลา 4 วัน',
      'price': '22999',
      'image': 'assets/images/logo.png',
    },
    {
      'title': 'ดานัง ฮอยอัน เว้ พักบนบานาฮิลล์',
      'country': 'ประเทศเวียดนาม',
      'duration': 'ระยะเวลา 4 วัน',
      'price': '13899',
      'image': 'assets/images/logo.png',
    },
    {
      'title': 'ดานัง ฮอยอัน เว้ พักบนบานาฮิลล์',
      'country': 'ประเทศเวียดนาม',
      'duration': 'ระยะเวลา 4 วัน',
      'price': '13899',
      'image': 'assets/images/logo.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("รายการทริป")),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section: หมวดหมู่
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'ปลายทาง',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ['ทั้งหมด', 'เอเชีย', 'ยุโรป', 'อาเซียน', 'อเมริกา']
                    .map((category) {
                      final isSelected = selectedCategory == category;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: ChoiceChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() => selectedCategory = category);
                          },
                          selectedColor: Colors.deepPurple,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      );
                    })
                    .toList(),
              ),
            ),

            SizedBox(height: 10),

            // Section: รายการทริป
            ...trips.map((trip) => buildTripCard(trip)),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildTripCard(Map<String, String> trip) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                trip['image']!,
                height: 150,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip['title']!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${trip['country']!}\n${trip['duration']!}\nราคา ${trip['price']} บาท',
                  ),
                  SizedBox(height: 8),
                  FilledButton(
                    onPressed: () {},
                    child: Text('รายละเอียดเพิ่มเติม'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
