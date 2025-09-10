import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/response/trip_get_res.dart';
import 'package:my_first_app/pages/Trip.dart';
import 'package:my_first_app/pages/profile.dart';

class Showtrippage extends StatefulWidget {
  int userId = 0;
  Showtrippage({super.key, required this.userId});

  @override
  State<Showtrippage> createState() => _ShowtrippageState();
}

class _ShowtrippageState extends State<Showtrippage> {
  String selectedCategory = 'ทั้งหมด';
  List<TripGetResponse> tripGetResponses = [];
  List<TripGetResponse> euroTrips = [];
  List<TripGetResponse> asiaTrips = [];
  List<TripGetResponse> setLoadData = [];
  String url = '';
  late Future<void> loadData;
  @override
  void initState() {
    super.initState();
    loadData = getTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("รายการทริป"),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              log(value);
              if (value == 'logout') {
                Navigator.of(context).popUntil((route) => route.isFirst);
              } else if (value == 'profile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(idx: widget.userId),
                  ),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('ข้อมูลส่วนตัว'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('ออกจากระบบ'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              children: [
                FilledButton(onPressed: getAll, child: const Text('ทั้งหมด')),
                FilledButton(onPressed: getAsia, child: const Text('เอเชีย')),
                FilledButton(onPressed: geteuro, child: const Text('ยุโรป')),
                FilledButton(
                  onPressed: geteArsin,
                  child: const Text('อาเซียน'),
                ),
                FilledButton(
                  onPressed: geteAsiaTai,
                  child: const Text('เอเชียตะวันออกเฉียงใต้'),
                ),
                FilledButton(
                  onPressed: geteThai,
                  child: const Text('ประเทศไทย'),
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          // Load data from API
          FutureBuilder(
            // future = Async function to load data
            future: loadData,
            builder: (context, snapshot) {
              // working => loading Indicator
              if (snapshot.connectionState != ConnectionState.done) {
                return CircularProgressIndicator();
              }
              // done => show data (Padding)
              return Expanded(
                child: ListView(
                  children: setLoadData
                      .map(
                        (trip) => Card(
                          margin: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    trip.coverimage,
                                    height: 150,
                                    width: 180,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        height: 150,
                                        width: 180,
                                        color: Colors.grey,
                                        child: Icon(Icons.broken_image),
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trip.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '${trip.name}\nราคา ${trip.price} บาท ID = ${trip.idx} \nระยะเวลา ${trip.duration}  \nโซนปลายทาง ${trip.destinationZone}',
                                      ),
                                      SizedBox(height: 8),
                                      FilledButton(
                                        onPressed: () => gotoTrip(trip.idx),
                                        child: Text('รายละเอียดเพิ่มเติม'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void gotoTrip(int idx) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripPage(idx: idx)),
    );
  }

  void getAsia() {
    setState(() {
      // เคลียร์ก่อนทุกครั้ง แล้ว filter ใหม่
      setLoadData = tripGetResponses
          .where((trip) => trip.destinationZone == 'เอเชีย')
          .toList();
    });
  }

  void geteuro() {
    setState(() {
      setLoadData = tripGetResponses
          .where((trip) => trip.destinationZone == 'ยุโรป')
          .toList();
    });
  }

  void geteArsin() {
    setState(() {
      setLoadData = tripGetResponses
          .where((trip) => trip.destinationZone == 'อาเซียน')
          .toList();
    });
  }

  void geteAsiaTai() {
    setState(() {
      setLoadData = tripGetResponses
          .where((trip) => trip.destinationZone == 'เอเชียตะวันออกเฉียงใต้')
          .toList();
    });
  }

  void geteThai() {
    setState(() {
      setLoadData = tripGetResponses
          .where((trip) => trip.destinationZone == 'ประเทศไทย')
          .toList();
    });
  }

  void getAll() {
    setState(() {
      setLoadData = tripGetResponses;
    });
  }

  Future<void> getTrips() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var res = await http.get(Uri.parse('$url/trips'));

    //setState(() {
    tripGetResponses = tripGetResponseFromJson(res.body);
    setLoadData = tripGetResponses;
    //});
    log(tripGetResponses.length.toString());
  }
}
