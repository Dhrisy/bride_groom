import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../authentication/provider/provider.dart';

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
    print('kkkkk${widget.user_data!['gender'] != ''}, \n ${(userSelectedGender != '' || userSelectedGender != null)}, '
        '\n ${widget.user_data!['gender'] == ''}\n ${(userSelectedGender == '' || userSelectedGender == null)}');


    print('/////${(widget.user_data!['gender'] == userSelectedGender)}\n'
        '${(widget.user_data!['gender'] != userSelectedGender)}');
  }


  @override
  Widget build(BuildContext context) {
    var genderProvider = Provider.of<AppProvider>(context);
    return Container(
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
                    value: _gender.isNotEmpty && (_gender == widget.user_data!['gender']) ? widget.user_data!['gender']
                    : _gender.isEmpty && (_gender != widget.user_data!['gender'])? widget.user_data!['gender']
                    :_gender.isNotEmpty ? _gender : widget.user_data!['gender'],


                    onChanged: (newValue) async{
                      genderProvider.setGender(newValue.toString());
                      userSelectedGender = newValue;
                      await savegender(newValue!);
                      print('${userSelectedGender},  ${newValue.toString()}bbb${genderProvider.Gender.isEmpty},,${widget.user_data!['gender'] != genderProvider.Gender}');
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
