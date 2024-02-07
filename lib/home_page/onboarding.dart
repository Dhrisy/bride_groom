// import 'package:flutter/material.dart';
//
//
// class NumberVerifiedSuccefully extends StatefulWidget {
//   NumberVerifiedSuccefully(
//       {Key? key, required this.pageController, this.isLogin = true})
//       : super(key: key);
//
//   final PageController pageController;
//   final bool isLogin;
//
//   @override
//   State<NumberVerifiedSuccefully> createState() =>
//       _NumberVerifiedSuccefullyState();
// }
//
// class _NumberVerifiedSuccefullyState extends State<NumberVerifiedSuccefully> {
//   final animationsMap = {
//     'textOnPageLoadAnimation': AnimationInfo(
//       trigger: AnimationTrigger.onPageLoad,
//       effects: [
//         FadeEffect(
//           curve: Curves.easeInOut,
//           delay: 0.ms,
//           duration: 600.ms,
//           begin: 0,
//           end: 1,
//         ),
//         // FadeEffect(
//         //   curve: Curves.easeInOut,
//         //   delay: 1500.ms,
//         //   duration: 600.ms,
//         //   begin: 1,
//         //   end: 0,
//         // ),
//       ],
//     ),
//   };
//
//   @override
//   void initState() {
//     super.initState();
//     logFirebaseEvent("number_verified_successfullly");
//
//     Future.delayed(Duration(milliseconds: 600)).then((value) {
//       verifyUser();
//       // setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 30.0.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//                 height: 133.r,
//                 width: 133.r,
//                 child:
//                 SvgPicture.asset('assets/images/number_verified_new.svg')),
//             SizedBox(
//               height: 22.h,
//             ),
//             Text(
//               // 'Number verified successfully',
//               FFLocalizations.of(context).getText("9e3vs9"),
//
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   fontFamily: CommonTheme.poppins,
//                   fontWeight: TextCustomTheme.semibold_fontweight,
//                   fontSize: TextCustomTheme.large_title_fontsize.sp,
//                   color: CommonTheme.textColor4),
//             ).animateOnPageLoad(animationsMap['textOnPageLoadAnimation']!),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void verifyUser() async {
//     // if (currentUserDisplayName.isNotEmpty)
//     // {
//     //   final userCollection = FirebaseFirestore.instance.collection('user');
//     //   String? fcmToken = await NotificationService.messaging.getToken();
//     //   await userCollection.doc(currentUserUid).update({
//     //     'fcm_token': fcmToken,
//     //   });
//     //   debugPrint(" updatin token $fcmToken");
//     //   // setState(() {
//     //   //   widget.pageController.jumpToPage(3);
//     //   // });
//     //   // context.pushNamedAuth(
//     //   //   HomeScreenNew.routeName,
//     //   //   mounted,
//     //   //   extra: <String, dynamic>{
//     //   //     kTransitionInfoKey: TransitionInfo(
//     //   //       hasTransition: true,
//     //   //       transitionType: PageTransitionType.fade,
//     //   //       duration: Duration(milliseconds: 0),
//     //   //     ),
//     //   //   },
//     //   // );
//     //
//     //   Navigator.push(
//     //     context,
//     //     MaterialPageRoute(
//     //       builder: (context) => HomeScreenLatest(),
//     //     ),
//     //   );
//     // }
//     // else
//     // {
//     //   logFirebaseEvent('Button_navigate_to');
//     //
//     //
//     //
//     //   // _pageController.jumpToPage(2);
//     //   setState(() {
//     //     widget.pageController.jumpToPage(3);
//     //   });
//     // }
//
//     if (currentUserDisplayName.isNotEmpty) {
//       final userCollection = FirebaseFirestore.instance.collection('user');
//       try {
//         String? fcmToken = await NotificationService.messaging.getToken();
//         await userCollection.doc(currentUserUid).update({
//           'fcm_token': fcmToken,
//         });
//         debugPrint(" updatin token $fcmToken");
//       } catch (e) {
//         debugPrint('fcm token Error: $e');
//       }
//       await userCollection.doc(currentUserUid).update({
//         'language': FFLocalizations.of(context).getVariableText(
//             enText: 'English',
//             hiText: 'Hindi',
//             mrText: 'Marathi',
//             mlText: 'Malayalam',
//             bnText: 'Bengali')
//       });
//       // getChatDocsCount();
//
//       Box<ChatModel> chatsBox = await Hive.openBox('chats');
//       await ApiServices.getChatHistory(chatsBox);
//       FFAppState().isChatHistoryDataLoaded= true;
//       Box<SystemConfigAndReferralModel> systemConfigBox =
//       Hive.box('system_config_box');
//       await ApiServices.getSystemConfigData(systemConfigBox: systemConfigBox)
//           .then((value) async {
//         // await PushNotificationUpdateApi.call(url: value.fcmTokenUrl!);
//       });
//       FFAppState().selectedCarousalIndex = 0;
//       FFAppState().selectedHomeIndex = 0;
//       FFAppState().allClicked = await ApiServices.getNotificationReadStatus();
//
//       Navigator.of(context).pushNamed(AppRoutes.homeScreen);
//     } else {
//       // _pageController.jumpToPage(2);
//       setState(() {
//         widget.pageController.jumpToPage(3);
//       });
//     }
//   }
// }