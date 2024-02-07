import 'package:bride_groom/components/common_button.dart';
import 'package:bride_groom/components/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPassword extends StatelessWidget {
   ForgotPassword({Key? key}) : super(key: key);


  TextEditingController forgot_pw_textEditingController = TextEditingController();
   final _formKey = GlobalKey<FormState>();

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                key: _formKey,
                child: Column(

                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close,
                          size: 35.sp,),
                        )
                      ],
                    ),
                    Image.asset('assets/images/question_mark.jpg',
                    height: 100.h,
                    width: 100.w,),
                    Text("Trouble with logging in? It's okay!",
                    style: TextStyle(
                      fontSize: 18.sp
                    ),),
                    SizedBox(height: 10.h,),
                    Text("Enter your email address linked with your account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp,
                        color: Colors.black54
                      ),),
                    ReusabeTextField(
                      email: true,
                        hint_text: 'Email address',
                        controller: forgot_pw_textEditingController,
                        icon: Icon(Icons.mail)
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    CommonButton(
                        callback: (){
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, proceed with your login logic
                            print('Form is valid');
                            // loadingProvider.setErrorMessage(false);
                            // Now you can access the individual form field values
                          } else {
                            // Form is invalid
                            print('Form is invalid');
                            // loadingProvider.setErrorMessage(true);
                          }
                        },
                        height: 45.h,
                        width: double.infinity,
                        fillColor: Colors.purple,
                        borderColor: Colors.purple,
                        title: 'Continue')
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
