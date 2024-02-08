import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/home_page/widgets/onfocus_search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({Key? key}) : super(key: key);

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Colors.green,
      child: Consumer<AppProvider>(
        builder: (context, searchProvider, child){
          return Stack(
            children: [
              if(!searchProvider.isSearching)
                Row(
                  children: [
                    Icon(Icons.menu),

                  ],
                ),

              if(searchProvider.isSearching)
                OnFocusSearchAppBar()
            ],
          );
        },
      )
    );
  }
}
