import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/response/user_id_get_res.dart';
import 'package:my_first_app/pages/ShowTripPage.dart';
import 'package:my_first_app/pages/Trip.dart';
import 'package:my_first_app/pages/login.dart';

class ProfilePage extends StatefulWidget {
  int idx = 0;
  ProfilePage({super.key, required this.idx});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String url = '';
  late Future<void> loadData;
  late UserIdGetResponse userIdGetResponse;
  TextEditingController nameCtl = TextEditingController();
  TextEditingController phoneCtl = TextEditingController();
  TextEditingController emailCtl = TextEditingController();
  TextEditingController imageCtl = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ข้อมูลส่วนตัว"),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              log(value);
              if (value == 'delete') {
                showDialog(
                  context: context,
                  builder: (context) => SimpleDialog(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'ยืนยันการยกเลิกสมาชิก?',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('ปิด'),
                          ),
                          FilledButton(
                            onPressed: delete,
                            child: const Text('ยืนยัน'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('ยกเลิกสมาชิก'),
              ),
              const PopupMenuItem<String>(
                child: Text("กลับหน้าเดิม"),
                value: "black",
              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                    child: Image.network(
                      userIdGetResponse.image ?? '',
                      width: 150,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.broken_image, size: 150),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('ชื่อ-นามสกุล'),
                        TextField(controller: nameCtl),
                        const Text('ชื่อ-นามสกุล'),
                        TextField(controller: phoneCtl),
                        const Text('ชื่อ-นามสกุล'),
                        TextField(controller: emailCtl),
                        const Text('ชื่อ-นามสกุล'),
                        TextField(controller: imageCtl),
                      ],
                    ),
                  ),
                  Center(
                    child: FilledButton(
                      onPressed: update,
                      child: const Text('บันทึกข้อมูล'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void delete() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var res = await http.delete(Uri.parse('$url/customers/${widget.idx}'));
    log(res.statusCode.toString());
    if (res.statusCode == 200) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('สำเร็จ'),
          content: Text('ลบข้อมูลสำเร็จ'),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('ปิด'),
            ),
          ],
        ),
      ).then((s) {
        Navigator.popUntil(context, (route) => route.isFirst);
      });
    } else {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: Text('ลบข้อมูลไม่สำเร็จ'),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ปิด'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> getUser() async {
    var config = await Configuration.getConfig();
    url = config['apiEndpoint'];

    var res = await http.get(Uri.parse('$url/customers/${widget.idx}'));
    log(res.body);

    userIdGetResponse = userIdGetResponseFromJson(res.body);
    log(jsonEncode(userIdGetResponse));
    nameCtl.text = userIdGetResponse.fullname;
    phoneCtl.text = userIdGetResponse.phone;
    emailCtl.text = userIdGetResponse.email;
    imageCtl.text = userIdGetResponse.image;
    print(userIdGetResponse.image);
  }

  void update() async {
    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    var json = {
      "fullname": nameCtl.text,
      "phone": phoneCtl.text,
      "email": emailCtl.text,
      "image": imageCtl.text,
    };
    // Not using the model, use jsonEncode() and jsonDecode()
    try {
      var res = await http.put(
        Uri.parse('$url/customers/${widget.idx}'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(json),
      );
      log(res.body);
      var result = jsonDecode(res.body);
      // Need to know json's property by reading from API Tester
      log(result['message']);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('สำเร็จ'),
          content: const Text('บันทึกข้อมูลเรียบร้อย'),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ปิด'),
            ),
          ],
        ),
      );
    } catch (err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: Text('บันทึกข้อมูลไม่สำเร็จ ' + err.toString()),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ปิด'),
            ),
          ],
        ),
      );
    }
  }
}
