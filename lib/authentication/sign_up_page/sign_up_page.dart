import 'package:bride_groom/authentication/entry_page.dart';
import 'package:bride_groom/components/common_button.dart';
import 'package:bride_groom/components/reusable_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../components/reusable_text_field.dart';
import 'provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name_textEditingController = TextEditingController();
  TextEditingController email_textEditingController = TextEditingController();
  TextEditingController pw_textEditingController = TextEditingController();
  TextEditingController gender_textEditingController = TextEditingController();
  TextEditingController phn_textEditingController = TextEditingController();

  String selectedGender = 'Select';
  String? userSelectedGendr;

  bool isLoading = false;
  bool error_message = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: Consumer<LoadingProvider>(
                  builder: (context, loadingPrvider, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        // InkWell(
                        //   onTap: (){
                        //    try{
                        //      Navigator.push(context, MaterialPageRoute(builder: (context) => EntryPage()));
                        //      print('ppppp');
                        //    }catch(e){
                        //      print('ppppp$e');
                        //    }
                        //   },
                        //     child: Icon(Icons.arrow_back_outlined)),
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
                                  // text: 'Full name',
                                  hint_text: 'Enter your name',
                                  controller: name_textEditingController,
                                  icon: Icon(Icons.person)),
                              if (loadingPrvider.error_message)
                                _errorText(context),

                              SizedBox(
                                height: 8.h,
                              ),
                              ReusabeTextField(
                                  // text: 'Email',
                                  hint_text: 'Enter your email address',
                                  controller: email_textEditingController,
                                  icon: Icon(Icons.email)),
                              if (loadingPrvider.error_message) _errorText(context),
                              SizedBox(
                                height: 10.h,
                              ),
                              ReusabeTextField(
                                  // text: 'Password',
                                  hint_text: 'Enter your phone number',
                                  controller: phn_textEditingController,
                                  icon: Icon(Icons.phone)),
                              if (loadingPrvider.error_message) _errorText(context),
                              SizedBox(
                                height: 10.h,
                              ),
                              ReusabeTextField(
                                  // text: 'Password',
                                  hint_text: 'Enter your password',
                                  controller: pw_textEditingController,
                                  icon: Icon(Icons.lock)),
                              if (loadingPrvider.error_message) _errorText(context),
                              SizedBox(
                                height: 20.h,
                              ),
                              _dropDownGender(context),
                              if (loadingPrvider.error_message) _errorText(context),
                              SizedBox(
                                height: 20.h,
                              ),
                              // ReusableButton(
                              //
                              //     text: 'Sign up',
                              //     sign_up: true,
                              //     fullname: name_textEditingController.text,
                              //     email: email_textEditingController.text,
                              //     password: pw_textEditingController.text,
                              //     gender: userSelectedGendr == null || userSelectedGendr == 'Select'
                              //         ? 'Not selected'
                              //         : userSelectedGendr.toString(),
                              //   isLoading: isLoading,
                              //   onPressed: _handleSignUp,
                              // ),
                              CommonButton(
                                  callback: () async {
                                    if ((name_textEditingController.text.isEmpty) ||
                                        (email_textEditingController.text.isEmpty) ||
                                        (pw_textEditingController.text.isEmpty) ||
                                        (userSelectedGendr == null)) {
                                      // isLoading = true;
                                      loadingPrvider.setLoading(false);
                                      loadingPrvider.setErrorMessage(true);
                                      // await  Future.delayed(Duration(seconds: 5));
                                      //  loadingPrvider.setLoading(false, false);
                                      print(
                                          'kkkk${loadingPrvider.isLoading}, ${loadingPrvider.error_message}');
                                    } else {}
                                  },
                                  width: double.infinity,
                                  isLoading: loadingPrvider.isLoading,
                                  fillColor: Colors.purple,
                                  borderColor: Colors.purple,
                                  title: 'Sign up'),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                )),
          ),
        ),
      ),
    );
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
        Text(
          'Please enter this field',
          style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.normal),
        )
      ],
    );
  }

  _dropDownGender(context) {
    var genderProvider = Provider.of<GenderProvider>(context);

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
              value: genderProvider.selectedGender,
              onChanged: (String? newValue) {
                genderProvider.setGender(newValue!);
                userSelectedGendr = newValue;
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
}
