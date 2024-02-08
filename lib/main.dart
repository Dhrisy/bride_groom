import 'package:bride_groom/authentication/auth_service.dart';
import 'package:bride_groom/authentication/entry_page.dart';
import 'package:bride_groom/home_page/home_page.dart';
import 'package:bride_groom/services/firebase_services.dart';
import 'package:bride_groom/splash_screen/splashscreen_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'authentication/sign_up_page/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  GetIt.I.registerLazySingleton(() => AuthSignUpService());
  GetIt.I.registerLazySingleton(() => AuthSignInService());
  GetIt.I.registerLazySingleton(() => FirebaseServices());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
        // ChangeNotifierProvider(create: (context) => LoadingProvider()),
        // ChangeNotifierProvider(create: (context) => SearchProvider()),

      ],
      child: MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print('yyyyyy');
    return ScreenUtilInit(
    child: MaterialApp(
      home: SplashScreen(),
    ),

    );
  }
}


