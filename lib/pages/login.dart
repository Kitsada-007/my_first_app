import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_first_app/pages/ShowTripPage.dart';
import 'package:my_first_app/pages/registerPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  int count = 0;
  var phoneCtl = TextEditingController();
  var passWordCtl = TextEditingController();
  // TextEditingController phoneCtl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login pages')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,

        child: Column(
          children: [
            InkWell(
              onTap: () => login(),
              child: Image.asset('assets/images/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  Text("หมายเลขโทรศัพท์"),
                  TextField(
                    controller: phoneCtl,
                    keyboardType: TextInputType.phone,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  Text("รหัสผ่าน"),
                  TextField(
                    controller: passWordCtl,
                    keyboardType: TextInputType.phone,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: register,
                        child: const Text('ลงทะเบียนใหม่'),
                      ),
                      FilledButton(
                        onPressed: () => login(),
                        child: const Text('เข้าสู้ระบบ'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  void login() {
    // ignore: unrelated_type_equality_checks
    //if (phoneCtl.text == '0812345678' && passWordCtl.text == '1234') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Showtrippage()),
    );
    //} else {
    //   setState(() {
    //     text = 'รหัสผ่านไม่ถูกต้อง';
    //   });
    // }
  }

  void register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Registerpage()),
    );
  }
}
