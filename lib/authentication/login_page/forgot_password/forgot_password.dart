import 'package:bride_groom/components/common_button.dart';
import 'package:bride_groom/components/reusable_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                      validator: (val){
                        if (forgot_pw_textEditingController.text.isEmpty ||
                            forgot_pw_textEditingController.text == '') {
                          return 'Please enter this field';
                        } else {
                          final emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                          if (!emailRegex.hasMatch(val!)) {
                            return 'Please enter a valid email address';
                          }
                        }
                      },
                        onChange: (val){},
                        phn: false,
                        email: true,
                        hint_text: 'Email address',
                        controller: forgot_pw_textEditingController,
                        icon: Icon(Icons.mail)
                    ),
                    SizedBox(
                      height: 15.h,
                    ),

                    CommonButton(
                        callback: () async{
                          if (_formKey.currentState!.validate()) {
                            // Form is valid, proceed with your login logic
                            print('Form is valid');
                           await  resetPassword(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                content: Container(
                                    width: double.infinity,
                                    height: 60.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                                      border: Border.all(
                                        color: Colors.purple, // Set the border color here
                                        width: 2.0, // Set the border width
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Icon(
                                          Icons.done,
                                          color: Colors.green,
                                        ),
                                        Expanded(
                                            child: Text(
                                              'Reset email sent successfully',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.green, fontSize: 14.sp),
                                            )),
                                      ],
                                    )),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pop(context);

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
   Future<void> resetPassword(BuildContext context) async {
     try {
       await FirebaseAuth.instance.sendPasswordResetEmail(
         email: forgot_pw_textEditingController.text,
       );
       // Show a success message or navigate to a success screen
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Password reset email sent.'),
         ),
       );
     } catch (e) {
       // Show an error message
       ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
           content: Text('Error: ${e.toString()}'),
         ),
       );
     }
   }
}
