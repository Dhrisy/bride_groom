import 'package:bride_groom/components/error_text.dart';
import 'package:bride_groom/components/gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../authentication/auth_service.dart';
import '../../authentication/sign_up_page/provider.dart';
import '../../components/common_button.dart';
import '../../components/reusable_text_field.dart';
import '../../services/firebase_services.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({Key? key,
  required this.user_data,
  }) : super(key: key);
  final Map<String, dynamic>? user_data;


  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController edit_name_textEditingController = TextEditingController();
  TextEditingController edit_email_textEditingController = TextEditingController();
  TextEditingController edit_pw_textEditingController = TextEditingController();
  TextEditingController edit_gender_textEditingController = TextEditingController();
  TextEditingController edit_phn_textEditingController = TextEditingController();
  TextEditingController edit_ph_textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: (){Navigator.pop(context);
                },
              child: Icon(Icons.arrow_back_outlined)),
          title: Text(
            'Profile',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),

        ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15.w,
                        ),
                        widget.user_data!['image'] == '' ? Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/default_profile.jpg'), // Add your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        : Container(
                          height: 100.h,
                          width: 100.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(widget.user_data!['image']), // Add your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text('Edit picture'),

                        SizedBox(
                          height: 5.h,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // _signUp_text(context),
                              SizedBox(
                                height: 10.h,
                              ),
                              ReusabeTextField(
                                phn: false,
                                hint_text: 'Enter your name',
                                controller: edit_name_textEditingController,
                                icon: Icon(Icons.person),
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              ReusabeTextField(
                                phn: false,
                                hint_text: 'Enter your email address',
                                controller: edit_email_textEditingController,
                                icon: Icon(Icons.email),
                                email: true,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ReusabeTextField(
                                phn: true,
                                hint_text: 'Enter your phone number',
                                controller: edit_phn_textEditingController,
                                icon: Icon(Icons.phone),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              ReusabeTextField(
                                phn: false,
                                hint_text: 'Enter your password',
                                controller: edit_pw_textEditingController,
                                icon: Icon(Icons.lock),
                                password: true,
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              GenderDropDown(),
                              // _dropDownGender(context),
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
      ),
    );
  }
}
