import 'package:flutter/material.dart';
import 'package:hivepractice/firebase%20views/registerscreen.dart';
import 'package:hivepractice/service/authservice.dart';

class Loginscreen extends StatelessWidget {
  Loginscreen({super.key});

  FireAuthService service = FireAuthService();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: passwordcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Password'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                service.signInWithEmail(
                    emailcontroller.text, passwordcontroller.text);
              },
              child: Center(
                child: Text('Login Now'),
              )),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(),
                    ));
              },
              child: Text('create account'))
        ],
      ),
    );
  }
}
