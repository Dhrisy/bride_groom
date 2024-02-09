import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../authentication/sign_up_page/provider.dart';

class GenderDropDown extends StatefulWidget {
  const GenderDropDown({Key? key}) : super(key: key);

  @override
  State<GenderDropDown> createState() => _GenderDropDownState();
}

class _GenderDropDownState extends State<GenderDropDown> {
  String userSelectedGender = 'Select';

  Future<void> saveGender(String gender)async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('gender', gender);


  }


  @override
  Widget build(BuildContext context) {
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
}
