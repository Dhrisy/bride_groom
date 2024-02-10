import 'package:bride_groom/authentication/login_page/verified_widget.dart';
import 'package:bride_groom/services/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:bride_groom/authentication/auth_service.dart';
import 'package:bride_groom/authentication/login_page/forgot_password/forgot_password.dart';
import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/authentication/sign_up_page/sign_up_page.dart';
import 'package:bride_groom/components/common_button.dart';
import 'package:bride_groom/components/reusable_button.dart';
import 'package:bride_groom/components/reusable_text_field.dart';
import 'package:bride_groom/home_page/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../forgot_pw/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  bool loginLoading = false;
  Map<String, dynamic>? user_data;


  String toSentenceCase(String input) {
    if (input.isEmpty) {
      return input;
    }

    // Split the input into sentences based on periods (.)
    List<String> sentences = input.split('.');

    // Capitalize the first letter of each sentence
    for (int i = 0; i < sentences.length; i++) {
      sentences[i] = sentences[i].trim();
      if (sentences[i].isNotEmpty) {
        sentences[i] = sentences[i][0].toUpperCase() + sentences[i].substring(1).toLowerCase();
      }
    }

    // Join the sentences back into a single string
    return sentences.join('. ');
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(24),
            child: Consumer<AppProvider>(
              builder: (context, provider, child) {
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
                        SizedBox(
                          height: 10.h,
                        ),
                        ReusabeTextField(
                          onChange: (val){},

                          phn: false,
                          hint_text: 'Enter your email address',
                          controller: emailController,
                          icon: Icon(Icons.email),
                          text: 'Email',
                          email: true,
                        ),

                        SizedBox(
                          height: 10.h,
                        ),
                        ReusabeTextField(
                          onChange: (val){},

                          phn: false,
                          hint_text: 'Enter your password',
                          controller: pwController,
                          icon: Icon(Icons.lock),
                          text: 'Password',
                          password: true,
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        if(provider.errorMessage == true)
                          _errorText(context),
                        _forgotPassword(context),
                        CommonButton(
                          callback: () async {
                            if (_formKey.currentState!.validate()) {
                              // Form is valid, proceed with your login logic
                              print('Form is valid');
                              provider.setErrorMessage(false);
                              provider.setLoading(true);
                              AuthSignInService authService = GetIt.I.get<AuthSignInService>();
                              FirebaseServices _firebase_services = GetIt.I.get<FirebaseServices>();

                              String? error = await authService.signInWithEmailPassword(
                                emailController.text,
                                pwController.text,
                              );

                              if (error == null) {

                                user_data = await _firebase_services.getUserDataByEmail(emailController.text);
                                provider.setEmail(emailController.text);

                                final full_name = toSentenceCase(user_data!['name']);
                                Future.delayed(Duration(seconds: 2), () {
                                  provider.setLoading(false);
                                  saveUserDataToSharedPreferences();
                                  provider.setErrorMessage(false);
                                });

                            // Successful login, navigate to animated greeting page
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => VerifiedCredential(
                                      email: emailController.text,
                                      fullname: full_name,
                                    ),
                                  ),
                                );
                              } else {
                                Future.delayed(Duration(seconds: 2), () {
                                  provider.setLoading(false);
                                  provider.setErrorMessage(true);
                                });
                                print('Login failed: $error');
                              }
                            } else {
                              // Form is invalid
                              print('Form is invalid');
                              provider.setErrorMessage(false);
                            }
                          },
                          isLoading: provider.isLoading,
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

  Future<void> saveUserDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user data to shared preferences
    prefs.setString('email', emailController.text);
    prefs.setString('pass_word', pwController.text);


    print('Email: ${prefs.getString('email')}');
    print('Password: ${prefs.getString('pass_word')}');

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
      Expanded(
        child: Text(
          'Sorry, your email or password was incorrect. Please double-check your password',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 12.sp, color: Colors.red[900]),
        ),
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
