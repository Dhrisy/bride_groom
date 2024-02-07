import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/components/common_button.dart';
import 'package:bride_groom/components/reusable_button.dart';
import 'package:bride_groom/components/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email_controller = TextEditingController();
  TextEditingController pw_controller = TextEditingController();

  bool login_loading = false;
  bool login_error_message = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(24),
            child: Consumer<LoadingProvider>(
              builder: (context, loadingProvider, child){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    _header(context),
                    ReusabeTextField(
                      hint_text: 'Enter your email address',
                      controller: email_controller,
                      icon: Icon(Icons.email),
                      text: 'Email',
                    ),
                    if(loadingProvider.error_message)
                      Text('empty'),
                    SizedBox(
                      height: 15.h,
                    ),
                    ReusabeTextField(
                      hint_text: 'Enter your password',
                      controller: pw_controller,
                      icon: Icon(Icons.lock),
                      text: 'Password',
                    ),
                    _forgotPassword(context),
                    // ReusableButton(text: 'Login'),
                    CommonButton(
                        callback: (){
                          if(email_controller.text.isEmpty || pw_controller.text.isEmpty){
                            loadingProvider.setErrorMessage(true);

                          }
                        },
                        width: double.infinity,
                        fillColor: Colors.purple,
                        borderColor: Colors.purple,
                        title: 'Login')
                  ],
                );
              },
            )
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


  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text("Forgot password?",
        style: TextStyle(color: Colors.purple),
      ),
    );
  }



  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
            },
            child: const Text("Sign Up", style: TextStyle(color: Colors.purple),)
        )
      ],
    );
  }
}
