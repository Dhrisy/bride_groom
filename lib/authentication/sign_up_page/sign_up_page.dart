import 'dart:async';

import 'package:bride_groom/authentication/auth_service.dart';
import 'package:bride_groom/authentication/entry_page.dart';
import 'package:bride_groom/authentication/greeting_page.dart';
import 'package:bride_groom/authentication/login_page/login_page.dart';
import 'package:bride_groom/components/common_button.dart';
import 'package:bride_groom/components/error_text.dart';
import 'package:bride_groom/components/reusable_button.dart';
import 'package:bride_groom/home_page/home_page.dart';
import 'package:bride_groom/home_page/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/reusable_text_field.dart';
import '../../services/firebase_services.dart';
import 'provider.dart';

// ... (imports remain unchanged)

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  TextEditingController name_textEditingController = TextEditingController();
  TextEditingController email_textEditingController = TextEditingController();
  TextEditingController pw_textEditingController = TextEditingController();
  TextEditingController gender_textEditingController = TextEditingController();
  TextEditingController phn_textEditingController = TextEditingController();
  TextEditingController ph_textEditingController = TextEditingController();

  String selectedGender = 'Select';
  String userSelectedGender = 'Select';

  bool isLoading = false;
  bool error_message = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            width: double.infinity,
            child: Consumer<AppProvider>(
              builder: (context, loadingPrvider, child) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 15.w,
                          ),
                          InkWell(
                            onTap: () {
                              _clearFileds();
                              Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EntryPage()));
                              print('mmmm${userSelectedGender}');
                            },
                            child: Icon(
                              Icons.close,
                              size: 35.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            _signUp_text(context),
                            SizedBox(
                              height: 10.h,
                            ),
                            ReusabeTextField(
                              phn: false,
                              hint_text: 'Enter your name',
                              controller: name_textEditingController,
                              icon: Icon(Icons.person),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            ReusabeTextField(
                              phn: false,
                              hint_text: 'Enter your email address',
                              controller: email_textEditingController,
                              icon: Icon(Icons.email),
                              email: true,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ReusabeTextField(
                              phn: true,
                              hint_text: 'Enter your phone number',
                              controller: phn_textEditingController,
                              icon: Icon(Icons.phone),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            ReusabeTextField(
                              phn: false,
                              hint_text: 'Enter your password',
                              controller: pw_textEditingController,
                              icon: Icon(Icons.lock),
                              password: true,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            _dropDownGender(context),
                            SizedBox(
                              height: 5.h,
                            ),
                            if (loadingPrvider.errorMessage)
                              ErrorText(),
                            SizedBox(
                              height: 20.h,
                            ),
                            CommonButton(
                              callback: () async {
                                FirebaseServices firebaseService = GetIt.I<FirebaseServices>();

                                loadingPrvider.setLoading(true);
                                if (_formKey.currentState!.validate()) {
                                  // Form is valid, proceed with your logic
                                  print('Form is valid');
                                  loadingPrvider.setErrorMessage(false);
                                  // Get instance of AuthService using get_it
                                  AuthSignUpService authService = GetIt.I.get<AuthSignUpService>();
                                  String? user_id = await authService.getCurrentUserId();
                                  // Call the signUpWithEmailPassword method
                                  String? error = await authService
                                      .signUpWithEmailPassword(
                                    email_textEditingController.text,
                                    pw_textEditingController.text,
                                  );
                                  // Handle the sign-up result
                                  if (error == null) {
                                    print('aaaa');
                                    saveUserDataToSharedPreferences();
                                    await Future.delayed(
                                        Duration(seconds: 2));
                                    loadingPrvider.setLoading(false);
                                    String phone = "+91${phn_textEditingController.text}";
                                    //storing the data into the firebase
                                   try{
                                     await firebaseService.addUserToFirestore(
                                       name: name_textEditingController.text,
                                       email: email_textEditingController.text,
                                       phone: phone,
                                       password: pw_textEditingController.text,
                                       gender: userSelectedGender,
                                     );
                                   }catch(e){

                                     print('Exception : $e');
                                   }

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GreetingPage(
                                          name: name_textEditingController.text,
                                          email: email_textEditingController.text,
                                        ),
                                      ),
                                    );
                                  } else {
                                    Future.delayed(Duration(seconds: 2), () {
                                      loadingPrvider.setLoading(false);
                                      loadingPrvider.setErrorMessage(true);
                                    });
                                    print('signUp failed: $error');
                                  }
                                } else {
                                  // Form is invalid
                                  print('Form is invalid');
                                  loadingPrvider.setErrorMessage(false);
                                }
                              },
                              width: double.infinity,
                              isLoading: loadingPrvider.isLoading,
                              fillColor: Colors.purple,
                              borderColor: Colors.purple,
                              title: 'Sign up',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginPage()));
                                    },
                                    child: const Text(
                                      "Sign In",
                                      style: TextStyle(color: Colors.purple),
                                    ))
                              ],
                            ),




                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _clearFileds() {
    email_textEditingController.clear();
    pw_textEditingController.clear();
    name_textEditingController.clear();
    phn_textEditingController.clear();
    userSelectedGender = 'Select';
  }



  _signUp_text(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Create your account",
          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  _errorText(context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 10.w,
        ),
        Text(
          'Please enter this field',
          style: TextStyle(
              color: Colors.red[900],
              fontSize: 12.sp,
              fontWeight: FontWeight.normal),
        )
      ],
    );
  }

  _dropDownGender(context) {
    var genderProvider = Provider.of<AppProvider>(context);

    return Container(
      height: 55.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.purple.withOpacity(0.1),
      ),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              value:
                  (userSelectedGender == 'Select' || userSelectedGender == null)
                      ? userSelectedGender
                      : genderProvider.selectedGender,
              onChanged: (String? newValue) async{
                genderProvider.setGender(newValue!);
                userSelectedGender = newValue;
                await saveGender(newValue);
              },
              icon: Icon(Icons.arrow_drop_down),
              underline: Container(),
              isExpanded: true,
              // Set the dropdown button icon
              items: <String>['Select', 'Bride', 'Groom']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveGender(String gender)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', gender);


  }

  Future<void> saveUserDataToSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user data to shared preferences
    prefs.setString('name', name_textEditingController.text);
    prefs.setString('email', email_textEditingController.text);
    prefs.setString('phone', phn_textEditingController.text);
    prefs.setString('password', pw_textEditingController.text);
    // prefs.setString('user_id', pw_textEditingController.text);


    // Print shared preferences values
    print('Name: ${prefs.getString('name')}');
    print('Email: ${prefs.getString('email')}');
    print('Phone Number: ${prefs.getString('phone')}');
    print('Password: ${prefs.getString('password')}');
    // print('UserId: ${prefs.getString('user_id')}');


  }
}
