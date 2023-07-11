// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/providers/chat_screen_expanded_details.dart';
import 'package:flutter_application_2/providers/user_provider.dart';
import 'package:flutter_application_2/responsive/Responsive_Layou_Screent.dart';
import 'package:flutter_application_2/responsive/Web_Screen_Layout.dart';
import 'package:flutter_application_2/responsive/mobile_screen_layout.dart';
import 'package:flutter_application_2/screens/login_screen.dart';
import 'package:flutter_application_2/utils.dart/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // initialise app based on platform- web or mobile
  // if (kIsWeb) {
  //   await Firebase.initializeApp(
  //     options: const FirebaseOptions(
  //       apiKey: "AIzaSyCZ-xrXqD5D19Snauto-Fx_nLD7PLrBXGM",
  //       appId: "1:585119731880:web:eca6e4b3c42a755cee329d",
  //       messagingSenderId: "585119731880",
  //       projectId: "instagram-clone-4cea4",
  //       storageBucket: 'instagram-clone-4cea4.appspot.com'
  //     ),
  //   );
  // } else {
  //   await Firebase.initializeApp();
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        //add at 02:43
        providers: [
          ChangeNotifierProvider(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider(
            create: (_) => ChatScreenProvider(),
          ),
        ],
        child: MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ar', 'AE'), // English
              //Locale('en'), // English
              //Locale('es'), // Spanish
            ],
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    // Checking if the snapshot has any data or not
                    if (snapshot.hasData) {
                      // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                      return const ResponsiveLayout(
                        mobileScreenLayout: MobileScreenLayout(),
                        webScreenLayout: WebScreenLayout(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('${snapshot.error}'),
                      );
                    }
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }
                  return LoginScreen(); 
                }),),);
  }
}
