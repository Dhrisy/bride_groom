import 'package:bride_groom/custom_functions/custom_functions.dart';
import 'package:bride_groom/profile/widgets/grid_view_images.dart';
import 'package:bride_groom/profile/widgets/option_card_widget.dart';
import 'package:bride_groom/profile/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';





class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key,
    required this.user_data,}) : super(key: key);

  final Map<String, dynamic>? user_data;


  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> with TickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(
      vsync: this,
      length: 2,
    );

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'User profile',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20,),
          child: Column(
            children: [
              UserCard(
                user_data: widget.user_data,
              ),
              // userCard(context),
              // tabBar(context),
              SizedBox(height: 20.h,),
              OptionCardWidget(
                user_data: widget.user_data,
                index: 1,
                icon: Icons.person,
                title: 'View profile',
              ),
              SizedBox(height: 15.h,),
              OptionCardWidget(
                index: 2,
                icon:Icons.image,
                title: 'Photos uploaded',
              ),
              SizedBox(height: 15.h,),
              OptionCardWidget(
                index: 3,
                icon: Icons.star,
                title: 'Starred profile',
              ),
              SizedBox(height: 15.h,),
              OptionCardWidget(
                index: 4,
                icon: Icons.settings,
                title: 'Settings',
              ),
              SizedBox(height: 15.h,),
              OptionCardWidget(
                index: 5,
                icon: Icons.logout_rounded,
                logout: true,
                title: 'Logout',
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget tabBar(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.purple,
            unselectedLabelColor: Colors.purple
                .withOpacity(0.3),
            controller: tabBarController,
            dividerHeight: 1,
            indicator: UnderlineTabIndicator(

              borderSide: BorderSide(width: 2.0, color: Colors.purple), // Customize the indicator color and thickness
            ),

            tabs: [
              Tab(
                text: 'Photos',
              ),
              Tab(
                text: 'About',
              ),

            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabBarController,
              children: [

                Center(
                  child: GridViewImages()
                ),
                Center(
                  child: Text(
                    'Tab View 3',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


}
