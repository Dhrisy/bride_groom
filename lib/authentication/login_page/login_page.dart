import 'package:bride_groom/authentication/login_page/forgot_password/forgot_password.dart';
import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/authentication/sign_up_page/sign_up_page.dart';
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
  final _formKey = GlobalKey<FormState>();

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
              builder: (context, loadingProvider, child) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
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
                          email: true,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        ReusabeTextField(
                          hint_text: 'Enter your password',
                          controller: pw_controller,
                          icon: Icon(Icons.lock),
                          text: 'Password',
                          password: true,
                        ),
                        _forgotPassword(context),
                        CommonButton(
                          callback: () {
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, proceed with your login logic
                              print('Form is valid');
                              loadingProvider.setErrorMessage(false);
                              // Now you can access the individual form field values
                            } else {
                              // Form is invalid
                              print('Form is invalid');
                              loadingProvider.setErrorMessage(true);
                            }
                          },
                          width: double.infinity,
                          fillColor: Colors.purple,
                          borderColor: Colors.purple,
                          title: 'Login',
                        ),
                        _signup(context),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
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
    onPressed: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ForgotPassword(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var curve = Curves.fastOutSlowIn;

            return FadeTransition(
              opacity: animation.drive(CurveTween(curve: curve)),
              child: child,
            );
          },
        ),
      );
    },
    child: const Text(
      "Forgot password?",
      style: TextStyle(color: Colors.purple),
    ),
  );
}



_errorText(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      Text(
        'This field is required',
        style: TextStyle(
            fontWeight: FontWeight.normal, fontSize: 12.sp, color: Colors.red),
      ),
    ],
  );
}

_signup(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text("Dont have an account? "),
      TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple),
          ))
    ],
  );
}
