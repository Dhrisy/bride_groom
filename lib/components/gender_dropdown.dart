import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/sign_up_page/provider.dart';

class GenderDropDown extends StatefulWidget {
  const GenderDropDown({Key? key,
  this.user_data,
    this.gender,
  }) : super(key: key);
  final Map<String, dynamic>? user_data;
  final String? gender;


  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  String? userSelectedGender;
  String _gender = '';

  Future<void> savegender(String gender)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', gender);
    setState(() {
      _gender = prefs.getString('gender').toString();
    });
  }

  @override
  void initState() {
    super.initState();
    print('rrrrr${widget.user_data}');
  }


  @override
  Widget build(BuildContext context) {
    var genderProvider = Provider.of<AppProvider>(context);


    return Container(
      // color: Colors.green,
      height: 63.h,
      child: Stack(
        children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
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
                    value: _gender != '' ? _gender : widget.user_data!['gender'],
                    //genderProvider.selectedGender != '' ? genderProvider.selectedGender : 'Select',
                    // widget.user_data != null
                    //     ? widget.user_data!['gender']
                    //     : (userSelectedGender == 'Select' || userSelectedGender == null)
                    //     ? userSelectedGender
                    //     : genderProvider.selectedGender,

                    onChanged: (String? newValue) async{
                      genderProvider.setGender(newValue!);
                      userSelectedGender = newValue;
                      await savegender(newValue!);
                      print('${userSelectedGender}mmmmmmm');
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
                  Text('Gender'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
