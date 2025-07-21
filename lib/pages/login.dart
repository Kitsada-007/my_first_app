import 'dart:developer';

import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login pages')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,

        child: Column(
          children: [
            InkWell(
              onTap: () => login('กดนะ', 'กดนะ'),
              child: Image.asset('assets/images/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("หมายเลขโทรศัพท์"),
                  TextField(
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
                        onPressed: () {},
                        child: const Text('ลงทะเบียนใหม่'),
                      ),
                      FilledButton(
                        onPressed: () => login('admin', '1234'),
                        child: const Text('เข้าสู้ระบบ'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(String user, String password) {
    log(user + " " + password);
  }
}
