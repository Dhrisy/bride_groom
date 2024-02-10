import 'dart:io';
import 'package:bride_groom/profile/profile_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'package:bride_groom/components/error_text.dart';
import 'package:bride_groom/components/gender_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/auth_service.dart';
import '../../authentication/sign_up_page/provider.dart';
import '../../components/common_button.dart';
import '../../components/reusable_text_field.dart';
import '../../custom_functions/custom_functions.dart';
import '../../custom_functions/image_upload.dart';
import '../../services/firebase_services.dart';
import 'package:http/http.dart' as http;

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({
    Key? key,
    required this.user_data,
  }) : super(key: key);
  final Map<String, dynamic>? user_data;

  @override
  State<EditProfileWidget> createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController edit_name_textEditingController =
      TextEditingController();
  TextEditingController edit_email_textEditingController =
      TextEditingController();
  TextEditingController edit_pw_textEditingController = TextEditingController();
  TextEditingController edit_gender_textEditingController =
      TextEditingController();
  TextEditingController edit_phn_textEditingController =
      TextEditingController();
  TextEditingController edit_ph_textEditingController = TextEditingController();
  TextEditingController edit_mother_tongue_textEditingController =
      TextEditingController();
  TextEditingController edit_religio_textEditingController =
      TextEditingController();
  TextEditingController edit_caste_textEditingController =
      TextEditingController();
  TextEditingController edit_address_textEditingController =
      TextEditingController();
  TextEditingController edit_pincode_textEditingController =
      TextEditingController();
  TextEditingController edit_country_textEditingController =
      TextEditingController();
  TextEditingController edit_state_textEditingController =
      TextEditingController();
  TextEditingController edit_hgt_textEditingController =
      TextEditingController();
  TextEditingController edit_wgt_textEditingController =
      TextEditingController();
  TextEditingController edit_edu_textEditingController =
      TextEditingController();
  TextEditingController edit_fam_textEditingController =
      TextEditingController();
  TextEditingController edit_texsib_tEditingController =
      TextEditingController();
  TextEditingController edit_job_textEditingController =
      TextEditingController();
  TextEditingController edit_addn_textEditingController =
      TextEditingController();

  List<Widget> textFields = [];
  DateTime? Dob;
  String phone_number = '';
  final _firestore = FirebaseFirestore.instance.collection('users');

  File? image_path;

  @override
  void initState() {
    super.initState();
    // _phnNumber();
    print(widget.user_data!['name']);
    String phoneNumber = widget.user_data!['phone'];

    // Extract the phone number without the country code
    setState(() {
      phone_number =
          phoneNumber.length >= 3 ? phoneNumber.substring(3) : phoneNumber;
    });
    print(
        'eeee${phone_number}ee${widget.user_data!['image']}, \n${image != null && image != ''}, \n ');
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  XFile? image;

  final ImagePicker _picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var provider = Provider.of<AppProvider>(context, listen: false);

    try {
      debugPrint('asdfg}');

      final XFile? pickedFile = await _picker.pickImage(
        source: media,
        maxWidth: 100,
        maxHeight: 100,
        // imageQuality: quality,
      );
      setState(() {
        image = pickedFile;
        provider.setPhoto((image?.path).toString());

        if (provider.Photo?.path == null || provider.Photo?.path == '') {
          print('PROVIDER IS NULL');
        } else {
          image_path = File(provider.Photo!.path);
          debugPrint('asdfg${image_path},     ${provider.Photo!.path}');
        }
        // _setImageFileListFromFile(pickedFile);
        print(',,,,,,,${provider.Photo},,,,,,}');
      });
    } catch (e) {
      print('kkjljkjhjhvghgafdhgfhfhafh$e');
      setState(() {});
    }
  }

  void showSnackbar(BuildContext context) {
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
                  'Saved successfully',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 14.sp),
                )),
              ],
            )),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void noSavingAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Edited details are not saved'),
            content: Container(
              // height: 100.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);

                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileWidget(
                      //   user_data: widget.user_data,
                      // )));
                    },
                    child: Row(
                      children: [
                        Text('Continue'),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Text('Cancel'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Consumer<AppProvider>(builder: (context, Provider, child) {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                noSavingAlert();
                // Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_outlined)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              InkWell(
                onTap: () async {
                  print('rrr${Provider.UserId}');

                  if (_formKey.currentState!.validate()) {
                    print('form valid');
                    if (widget.user_data!['name'] !=
                        edit_email_textEditingController) {
                      bool res = await doesEmailExist(
                          edit_email_textEditingController.text);
                      print('llll${res}');
                      if (res == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                                width: double.infinity,
                                height: 60.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.r)),
                                  border: Border.all(
                                    color: Colors
                                        .purple, // Set the border color here
                                    width: 2.0, // Set the border width
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'Email already exists',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 14.sp),
                                    )),
                                  ],
                                )),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {


                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var _gender = prefs.getString('gender');

                        // Prints 'file:///path/to/foo'
                        final userEditedData = {
                          'name': widget.user_data!['name'] ==
                                  edit_name_textEditingController.text
                              ? widget.user_data!['name']
                              : edit_name_textEditingController.text,
                          'email': widget.user_data!['email'] ==
                                  edit_email_textEditingController.text
                              ? widget.user_data!['email']
                              : edit_email_textEditingController.text,
                          'phone': widget.user_data!['phone'] ==
                                  edit_phn_textEditingController.text
                              ? widget.user_data!['phone']
                              : edit_phn_textEditingController.text,
                          'gender': widget.user_data!['gender'] ==
                              _gender
                              ? widget.user_data!['gender']
                              : _gender,
                          'date_of_birth':
                              widget.user_data!['date_of_birth'] == Provider.dob
                                  ? widget.user_data!['date_of_birth']
                                  : Provider.dob,
                          'mother_tongue': widget.user_data!['mother_tongue'] ==
                                  edit_mother_tongue_textEditingController.text
                              ? widget.user_data!['mother_tongue']
                              : edit_mother_tongue_textEditingController.text,
                          'religion': widget.user_data!['religion'] ==
                                  edit_religio_textEditingController.text
                              ? widget.user_data!['religion']
                              : edit_religio_textEditingController.text,
                          'caste': widget.user_data!['caste'] ==
                                  edit_caste_textEditingController.text
                              ? widget.user_data!['caste']
                              : edit_caste_textEditingController.text,
                          'location': widget.user_data!['location'] ==
                                  edit_address_textEditingController.text
                              ? widget.user_data!['location']
                              : edit_address_textEditingController.text,
                          'pincode': widget.user_data!['pincode'] ==
                                  edit_pincode_textEditingController.text
                              ? widget.user_data!['pincode']
                              : edit_pincode_textEditingController.text,
                          'state': widget.user_data!['state'] ==
                                  edit_state_textEditingController.text
                              ? widget.user_data!['state']
                              : edit_state_textEditingController.text,
                          'country': widget.user_data!['country'] ==
                                  edit_country_textEditingController.text
                              ? widget.user_data!['country']
                              : edit_country_textEditingController.text,
                          'height': widget.user_data!['height'] ==
                                  edit_hgt_textEditingController.text
                              ? widget.user_data!['height']
                              : edit_hgt_textEditingController.text,
                          'weight': widget.user_data!['weight'] ==
                                  edit_wgt_textEditingController.text
                              ? widget.user_data!['weight']
                              : edit_wgt_textEditingController.text,
                          'education': widget.user_data!['education'] ==
                                  edit_edu_textEditingController.text
                              ? widget.user_data!['education']
                              : edit_edu_textEditingController.text,
                          'image': widget.user_data!['image'] ==
                                  edit_edu_textEditingController.text
                              ? widget.user_data!['image']
                              : Provider.Photo!.path,
                        };

                        _firestore
                            .doc(widget.user_data!['user_id'])
                            .update(userEditedData)
                            .then((value) {
                          showSnackbar(context);
                          Navigator.pop(context);
                        });
                      }
                    }
                  } else {
                    print('invalid');
                  }

                  // updateData();

                  // showSnackbar(context);
                  print(
                      'dddddddddddd${Provider.dob == null},  ${Provider.dob != ''}');
                },
                child: Container(
                  height: 40.h,
                  width: 40.h,
                  decoration: BoxDecoration(
                      color: Colors.purple.withOpacity(0.1),
                      shape: BoxShape.circle),
                  child: Icon(Icons.done),
                ),
              )
            ],
          ),
        ),
        key: _scaffoldKey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 50,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 15.w,
                      ),
                      Provider.Photo == '' || Provider.Photo == null
                          ? Container(
                              height: 100.h,
                              width: 100.h,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/default_profile.jpg'), // Add your image path
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
                                  image: FileImage(File(Provider.Photo!.path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                      // widget.user_data!['image'] == '' &&
                      //     (image == null && image == '') &&
                      //     (Provider.Photo == '') && (Provider.Photo == null)
                      //     ? Container(
                      //   height: 100.h,
                      //   width: 100.h,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: AssetImage(
                      //           'assets/images/default_profile.jpg'), // Add your image path
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // )
                      //     : image != null && image != ''
                      //     ? Container(
                      //   height: 100.h,
                      //   width: 100.h,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: FileImage(File(image!.path)),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // )
                      //     : widget.user_data!['image'] != ''
                      //     ? Container(
                      //   height: 100.h,
                      //   width: 100.h,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: NetworkImage(widget
                      //           .user_data!['image']), // Add your image path
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // )
                      //     : Provider.Photo != ''
                      //     ? Container(
                      //   height: 100.h,
                      //   width: 100.h,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //       image: FileImage(File(Provider.Photo!.path)), // Add your image path
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // )
                      //     : Container(),
                      InkWell(
                          onTap: () {
                            myAlert();
                          },
                          child: Text('Edit picture')),
                      SizedBox(
                        height: 5.h,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 7.h,
                            ),
                            _basicInfo(context),
                            _personalDetailsCard(context),
                            SizedBox(
                              width: 5.w,
                            ),
                            _locationCard(context),
                            _physicalAttribute(context),
                            _educationInfo(context),
                            SizedBox(
                              height: 50.h,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }));
  }

  void removeTextField(int index) {
    setState(() {
      textFields.removeAt(index);
    });
  }

  String _formatDate(DateTime date) {
    print('wwwww${DateFormat('dd-MM-yyyy').format(date)}');
    return DateFormat('dd-MM-yyyy').format(date);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(), // Set last date to the current date
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _formatDate(selectedDate);
      });
    }
  }

  _dob(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return Container(
        height: 65.h,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 55.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.purple.withOpacity(0.1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10.w,
                          ),
                          if ((widget.user_data!['date_of_birth'] != null &&
                                  widget.user_data!['date_of_birth'] != '') &&
                              (provider.dob != null && provider.dob != '') &&
                              (widget.user_data!['date_of_birth'] !=
                                  provider.dob))
                            Text(
                              provider.dob.toString(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          // if (provider.dob != null && provider.dob != '')
                          //   Text(
                          //     provider.dob.toString(),
                          //     style: TextStyle(fontSize: 14.sp),
                          //   ),

                          if ((widget.user_data!['date_of_birth'] != null &&
                                  widget.user_data!['date_of_birth'] != '') &&
                              (provider.dob != null && provider.dob != '') &&
                              (widget.user_data!['date_of_birth'] ==
                                  provider.dob))
                            Text(
                              widget.user_data!['date_of_birth'],
                              style: TextStyle(fontSize: 14.sp),
                            ),

                          if ((provider.dob == null && provider.dob == '') ||
                              (widget.user_data!['date_of_birth'] == null &&
                                  widget.user_data!['date_of_birth'] == ''))
                            Text(
                              'dd-mm-yyyy',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                              onTap: () async {
                                DateTime selectedDate = DateTime.now();
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate,
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime
                                      .now(), // Set last date to the current date
                                );

                                if (picked != null && picked != selectedDate) {
                                  final date =
                                      DateFormat('dd-MM-yyyy').format(picked);
                                  // Dob = DateFormat('dd-MM-yyyy').format(picked) as DateTime?;

                                  _formatDate(picked);
                                  provider.setDob(date);
                                  print('Date od birth : ${provider.dob}');
                                }
                              },
                              child: Icon(Icons.calendar_month)),
                          SizedBox(
                            width: 10.w,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                // height: 55.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  // color: Colors.purple.withOpacity(0.1),
                ),
                child: Row(
                  children: [
                    Text('Date of birth'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  void _phnNumber() {
    String phoneNumber = widget.user_data!['phone'];

    // Extract the phone number without the country code
    String phoneNumberWithoutCountryCode = phoneNumber.substring(3);

    print('Phone Number without Country Code: $phoneNumberWithoutCountryCode');
  }

  _basicInfo(BuildContext context) {
    return Container(
        width: double.infinity,
        // color: Colrs.grey,
        child: Consumer<AppProvider>(
          builder: (context, provider, child) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Basic information',
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                ReusabeTextField(
                  onChange: (val) {},
                  label_text: 'Full name',
                  user_data: widget.user_data,
                  edit_profile: true,
                  phn: false,
                  hint_text: 'Enter your name',
                  controller: edit_name_textEditingController,
                  icon: Icon(Icons.person),
                  validator: (value) {
                    if (edit_name_textEditingController.text.isEmpty ||
                        edit_name_textEditingController.text == '') {
                      return 'Please enter this field';
                    }
                  },
                  initialValue: widget.user_data!['name'],
                ),
                SizedBox(
                  height: 7.h,
                ),
                ReusabeTextField(
                  onChange: (val) {},
                  email: true,
                  label_text: 'Email',
                  user_data: widget.user_data,
                  edit_profile: true,
                  phn: false,
                  hint_text: 'Enter your email address',
                  controller: edit_email_textEditingController,
                  icon: Icon(Icons.email),
                  // email: true,
                  validator: (value) {
                    if (edit_name_textEditingController.text.isEmpty ||
                        edit_name_textEditingController.text == '') {
                      return 'Please enter this field';
                    } else {
                      final emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegex.hasMatch(value!)) {
                        return 'Please enter a valid email address';
                      }
                    }
                  },

                  // initialValue: widget.user_data!['email'],
                ),
                SizedBox(
                  height: 7.h,
                ),
                ReusabeTextField(
                  onChange: (val) {},

                  user_data: widget.user_data,
                  edit_profile: true,
                  phn: true,
                  hint_text: 'Enter your phone number',
                  controller: edit_phn_textEditingController,
                  icon: Icon(Icons.phone),
                  validator: (value) {
                    if (value!.length < 10) {
                      return 'Phone number must be 10 characters';
                    }
                  },
                  // initialValue: widget.user_data!['phone'],
                ),

                SizedBox(
                  height: 7.h,
                ),
                GenderDropDown(
                  gender: widget.user_data!['gender'],
                  user_data: widget.user_data,
                ),

                SizedBox(
                  height: 7.h,
                ),
                // if (Provider.errorMessage) ErrorText(),
                SizedBox(
                  height: 7.h,
                ),
                _dob(context),
              ],
            );
          },
        ));
  }

  _personalDetailsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      // color: Colrs.grey,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Personal details',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              )
            ],
          ),
          ReusabeTextField(
            onChange: (val) {},

            language: true,
            label_text: 'Mother tongue',
            user_data: widget.user_data,
            edit_profile: true,
            phn: false,
            hint_text: 'Mother tongue',
            controller: edit_mother_tongue_textEditingController,
            // initialValue:  widget.user_data!['mother_tongue'],
          ),
          ReusabeTextField(
            onChange: (val) {},

            religion: true,
            label_text: 'Religion',
            user_data: widget.user_data,
            edit_profile: true,
            phn: false,
            hint_text: 'Religion',
            controller: edit_religio_textEditingController,
            // initialValue:  widget.user_data!['religion'] ,
          ),
          ReusabeTextField(
            onChange: (val) {},

            caste: true,
            label_text: 'Caste',
            user_data: widget.user_data,
            edit_profile: true,
            phn: false,
            hint_text: 'Caste',
            controller: edit_caste_textEditingController,
            // initialValue:  widget.user_data!['caste'] ,
          ),
        ],
      ),
    );
  }

  _locationCard(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Location',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
              )
            ],
          ),
          ReusabeTextField(
            onChange: (val) {},

            place: true,
            label_text: 'Place',
            user_data: widget.user_data,
            edit_profile: true,
            phn: false,
            hint_text: 'Place',
            controller: edit_address_textEditingController,
            // initialValue:  widget.user_data!['location'] ,
          ),
          ReusabeTextField(
            onChange: (val) {},
            pincode: true,
            label_text: 'Pincode',
            user_data: widget.user_data,
            edit_profile: true,
            phn: false,
            hint_text: 'Pincode',
            controller: edit_pincode_textEditingController,
            initialValue: widget.user_data!['pincode'],
            keyboardType: TextInputType.number,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ReusabeTextField(
                  onChange: (val) {},

                  state: true,
                  label_text: 'State',
                  user_data: widget.user_data,
                  edit_profile: true,
                  phn: false,
                  hint_text: 'State',
                  controller: edit_state_textEditingController,
                  // initialValue:  widget.user_data!['state'] ,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Expanded(
                child: ReusabeTextField(
                  onChange: (val) {},

                  country: true,
                  label_text: 'Country',
                  user_data: widget.user_data,
                  edit_profile: true,
                  phn: false,
                  hint_text: 'Country',
                  controller: edit_country_textEditingController,
                  // initialValue:  widget.user_data!['country'] ,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _educationInfo(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Text(
                  'Education',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                )
              ],
            ),
            ReusabeTextField(
              onChange: (val) {},

              education: true,
              label_text: 'Education',
              user_data: widget.user_data,
              edit_profile: true,
              phn: false,
              hint_text: 'Education',
              controller: edit_edu_textEditingController,
              // initialValue:  widget.user_data!['education'] ,
            ),
          ],
        ),
      ),
    );
  }

  _physicalAttribute(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: Colors.purple.withOpacity(0.1),
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Text(
                  'Physical attribute',
                  style:
                      TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                )
              ],
            ),
            ReusabeTextField(
              onChange: (val) {},

              hgt: true,
              label_text: 'Height',
              user_data: widget.user_data,
              edit_profile: true,
              phn: false,
              hint_text: 'Height',
              controller: edit_hgt_textEditingController,
              // initialValue:  widget.user_data!['height'] ,
            ),
            SizedBox(
              height: 7.h,
            ),
            ReusabeTextField(
              onChange: (val) {},

              wgt: true,
              label_text: 'Weight',
              user_data: widget.user_data,
              edit_profile: true,
              phn: false,
              hint_text: 'Weight',
              controller: edit_wgt_textEditingController,
              // initialValue:  widget.user_data!['weight'] ,
            ),
          ],
        ),
      ),
    );
  }
}
