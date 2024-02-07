import 'package:bride_groom/authentication/login_page/reusable_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController username_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
             ReusabeTextField(
               hint_text: 'Enter your email address',
               controller: username_controller,
               icon: Icon(Icons.person),
               text: 'Email',
             ),
              ReusabeTextField(
                hint_text: 'User name',
                controller: username_controller,
                icon: Icon(Icons.person),
                text: 'Password',
              ),
              // _forgotPassword(context),
              // _signup(context),
            ],
          ),
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }
}
