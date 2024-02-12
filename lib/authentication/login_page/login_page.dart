import 'package:bride_groom/authentication/login_page/verified_widget.dart';
import 'package:bride_groom/authentication/provider/provider.dart';
import 'package:bride_groom/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:bride_groom/authentication/auth_service.dart';
import 'package:bride_groom/authentication/login_page/forgot_password/forgot_password.dart';
import 'package:bride_groom/authentication/sign_up_page/sign_up_page.dart';
import 'package:bride_groom/components/common_button.dart';
import 'package:bride_groom/components/reusable_text_field.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../custom_functions/custom_functions.dart';

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




  void fetUseData(String email) async{
    FirebaseServicesWidget _firebase_services = GetIt.I.get<FirebaseServicesWidget>();
    user_data = await _firebase_services.getUserDataByEmail(email);
    print('nnnnnnn${user_data}');
  }
@override
void initState() {
    super.initState();
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
                          onChange: (val) {},
                          phn: false,
                          hint_text: 'Enter your email address',
                          controller: emailController,
                          icon: Icon(Icons.email),
                          text: 'Email',
                          email: true,
                          validator: (val){
                            if (emailController.text.isEmpty ||
                                emailController.text == '') {
                              return 'Please enter this field';
                            } else {
                              final emailRegex = RegExp(
                                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                              if (!emailRegex.hasMatch(val!)) {
                                return 'Please enter a valid email address';
                              }
                            }
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ReusabeTextField(
                          onChange: (val) {},
                          phn: false,
                          hint_text: 'Enter your password',
                          controller: pwController,
                          icon: Icon(Icons.lock),
                          text: 'Password',
                          password: true,
                          validator: (val){
                            if(pwController.text.length < 6){
                              return 'Password must be contain atleast 6 number';
                            }
                          },
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        if (provider.errorMessage == true)
                          _errorText(context),
                        _forgotPassword(context),
                        CommonButton(
                          callback: () async {
                            if (_formKey.currentState!.validate()) {
                              print('Form is valid');
                              bool result = await CustomFunctions.emailExist(
                                  emailController.text);
                              print('ggggg${result}');
                              if (result == true) {
                                print('email exists');
                                provider.setLoading(true);
                                provider.setErrorMessage(false);
                                AuthSignInService authService =
                                    GetIt.I.get<AuthSignInService>();
                                FirebaseServicesWidget _firebase_services =
                                    GetIt.I.get<FirebaseServicesWidget>();

                                String? error =
                                    await authService.signInWithEmailPassword(
                                  emailController.text,
                                  pwController.text,
                                );

                                if (error == null) {
                                  print('valid');
                                  user_data = await _firebase_services
                                      .getUserDataByEmail(emailController.text);
                                  provider.setEmail(emailController.text);
                                  provider.setUserId(user_data!['user_id']);
                                  print('//////${provider.UserId}');


                                  final full_name =
                                      CustomFunctions.toSentenceCase(
                                          user_data!['name']);
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
                                  print('invalid');
                                  Future.delayed(Duration(seconds: 2), () {
                                    provider.setLoading(false);
                                    provider.setErrorMessage(true);
                                  });
                                  print('Login failed: $error');
                                }
                              } else {
                                provider.setErrorMessage(true);
                                print('email not exists');
                                // myAlert();
                              }
                            } else {
                              print('Form is invalid');
                              provider.setErrorMessage(false);
                            }

                            // if (_formKey.currentState!.validate()) {
                            //   // Form is valid, proceed with your login logic
                            //   print('Form is valid');
                            //   provider.setErrorMessage(false);
                            //   provider.setLoading(true);
                            //   AuthSignInService authService = GetIt.I.get<AuthSignInService>();
                            //   FirebaseServicesWidget _firebase_services = GetIt.I.get<FirebaseServicesWidget>();
                            //
                            //   String? error = await authService.signInWithEmailPassword(
                            //     emailController.text,
                            //     pwController.text,
                            //   );
                            //
                            //   if (error == null) {
                            //
                            //     user_data = await _firebase_services.getUserDataByEmail(emailController.text);
                            //     provider.setEmail(emailController.text);
                            //
                            //     final full_name = CustomFunctions.toSentenceCase(user_data!['name']);
                            //     Future.delayed(Duration(seconds: 2), () {
                            //       provider.setLoading(false);
                            //       saveUserDataToSharedPreferences();
                            //       provider.setErrorMessage(false);
                            //     });
                            //
                            // // Successful login, navigate to animated greeting page
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (context) => VerifiedCredential(
                            //           email: emailController.text,
                            //           fullname: full_name,
                            //         ),
                            //       ),
                            //     );
                            //   } else {
                            //     Future.delayed(Duration(seconds: 2), () {
                            //       provider.setLoading(false);
                            //       provider.setErrorMessage(true);
                            //     });
                            //     print('Login failed: $error');
                            //   }
                            // } else {
                            //   // Form is invalid
                            //   print('Form is invalid');
                            //   provider.setErrorMessage(false);
                            // }
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

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Email already exists'),
            content: Container(
              height: 55.h,
              child: ElevatedButton(
                //if user click this button. user can upload image from camera
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Ok'),
              ),
            ),
          );
        });
  }

  Future<void> saveUserDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user data to shared preferences
    prefs.setString('email', emailController.text);
    prefs.setString('pass_word', pwController.text);

// get data from shared preferences
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
          pageBuilder: (context, animation, secondaryAnimation) =>
              ForgotPassword(),
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
          'Sorry, your email or password was incorrect. Please double-check your password or email',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
              color: Colors.red[900]),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple),
          ))
    ],
  );
}
