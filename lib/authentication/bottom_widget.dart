import 'package:bride_groom/authentication/login_page/login_page.dart';
import 'package:bride_groom/authentication/sign_up_page/provider.dart';
import 'package:bride_groom/authentication/sign_up_page/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BottomWidget extends StatelessWidget {
  const BottomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.purple.withOpacity(0.1), //Color(0x080838),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      child: Consumer<LoadingProvider>(
        builder: (context, loadingProvider, child){
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  loadingProvider.setErrorMessage(false);
                  loadingProvider.setLoading(false);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Container(
                  width: 200.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.sp,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  loadingProvider.setErrorMessage(false);
                  loadingProvider.setLoading(false);
                  Navigator.push(context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) => SignUpPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var curve = Curves.fastOutSlowIn;

                        return FadeTransition(
                          opacity: animation.drive(CurveTween(curve: curve)),
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: 200.w,
                  height: 45.h,
                  decoration: BoxDecoration(
                    // color: Colors.purple[400],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      border: Border.all(color: Colors.purple, width: 2.w)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 20.sp,
                            color: Colors.purple),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      )
    );
  }
}
