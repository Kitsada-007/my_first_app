import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login pages')),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Container(
          color: Colors.amber,
          child: Column(
            children: [
              SizedBox(
                child: Container(color: Colors.blue, width: 100, height: 100),
              ),
              Row(
                children: [
                  SizedBox(
                    child: Container(
                      color: Colors.green,
                      width: 200,
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      color: Colors.pink,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
