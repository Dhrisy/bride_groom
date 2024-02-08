import 'package:bride_groom/components/reusable_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../authentication/sign_up_page/provider.dart';

class OnFocusSearchAppBar extends StatefulWidget {
  const OnFocusSearchAppBar({Key? key}) : super(key: key);

  @override
  State<OnFocusSearchAppBar> createState() => _OnFocusSearchAppBarState();
}

class _OnFocusSearchAppBarState extends State<OnFocusSearchAppBar> {
  TextEditingController search_controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
        builder: (context, seachProvider, child) {
          return Row(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.all(Radius.circular(10.r))

                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue, // Set your desired border color
                          width: 2.0, // Set the border width
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Enter text',
                      labelText: 'Label',
                    ),
                  ),
                )
              ),
              TextButton(
                onPressed: () {
                  seachProvider.setSearching(false);

                },
                child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.withOpacity(0.1), // Set the desired color
                    ),
                    child: Icon(Icons.close)
                ),
              ),
            ],
          );
        });
  }
}
