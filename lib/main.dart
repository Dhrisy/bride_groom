import 'package:bride_groom/authentication/auth_service.dart';
import 'package:bride_groom/services/firebase_services.dart';
import 'package:bride_groom/splash_screen/splashscreen_widgets.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'authentication/provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print('Firebase initialization error: $e');
  }
  GetIt.I.registerLazySingleton(() => AuthSignUpService());
  GetIt.I.registerLazySingleton(() => AuthSignInService());
  GetIt.I.registerLazySingleton(() => FirebaseServicesWidget());

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
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
    return ScreenUtilInit(
    child: MaterialApp(
      home: SplashScreen(),
    ),

    );
  }
}


