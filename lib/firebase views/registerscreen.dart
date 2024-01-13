import 'package:flutter/material.dart';
import 'package:hivepractice/firebase%20views/homescree.dart';
import 'package:hivepractice/service/authservice.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    FireAuthService service = FireAuthService();

    return Scaffold(
      appBar: AppBar(
        title: Text('Register Screen'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: namecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Name'),
            ),
          ),
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
                final signin = service.signupWithEmail(emailcontroller.text,
                    passwordcontroller.text, namecontroller.text);

                if (signin != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homescreen(),
                      ));
                }
              },
              child: Center(
                child: Text('Register Now'),
              ))
        ],
      ),
    );
  }
}
