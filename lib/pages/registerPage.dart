import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_first_app/config/config.dart';
import 'package:my_first_app/model/request/customers_register_post_%20req.dart';
import 'package:my_first_app/model/response/customers_register_post_pes.dart';
import 'package:my_first_app/pages/login.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordChack = TextEditingController();

  String message = '';

  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ลงทะเบียนสมาชิกใหม่')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 50, left: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ชื่อ-นามสกุล'),
              TextField(
                controller: fullname,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ),
              Text('หมายเลขโทรศัพท์'),
              TextField(
                controller: phone,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ),
              Text('อีเมล์'),
              TextField(
                controller: email,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ),
              Text('รหัสผ่าน'),
              TextField(
                controller: password,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1)),
                ),
              ),
              Text('ยืนยันรหัสผ่าน'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordChack,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton(
                    onPressed: register,
                    child: const Text('สมัครสมาชิก'),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'หากมีบัญชีอยู่แล้ว?',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('เข้าสู่ระบบ'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (password.text == passwordChack.text) {
      CustomerRegisterPostRequest req = CustomerRegisterPostRequest(
        fullname: fullname.text,
        phone: phone.text,
        email: email.text,
        image:
            'http://202.28.34.197:8888/contents/4a00cead-afb3-45db-a37a-c8bebe08fe0d.png',
        password: password.text,
      );
      http
          .post(
            Uri.parse("$url/customers"),
            headers: {"Content-Type": "application/json; charset=utf-8"},
            body: customerRegisterPostRequestToJson(req),
          )
          .then((value) {
            CustomerRegisterPostResponse customerRegisterPostResponse =
                customerRegisterPostResponseFromJson(value.body);
            log(customerRegisterPostResponse.message);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    LoginPage(mes: customerRegisterPostResponse.message),
              ),
            );
          })
          .catchError((error) {
            log('Error $error');
          });
    } else {
      log('ยืนยันรหัสผ่านไห้ทูกต้อง');
    }
  }

  void Back() {
    Navigator.pop(context);
  }
}
