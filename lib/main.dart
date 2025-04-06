
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sentinova/helper/init_user.dart';
import 'package:sentinova/screens/community_screen.dart';
import 'package:sentinova/screens/splash_screen.dart';
import 'package:sentinova/themes.dart';

//firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoService.connect(); // Make sure to connect before using
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  InitUser.initialize();
  SystemChrome.setPreferredOrientations([
    // Lock orientation to landscape
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp( Sentinova());
  });
}

class Sentinova extends StatelessWidget {
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     theme: ThemeData(
  //       primaryColor: const Color(0xFFF29000),
  //       brightness: Brightness.light,
  //       textTheme: const TextTheme(
  //         titleLarge: TextThemes.title,
  //         titleMedium: TextThemes.subtitle, // or bodyMedium
  //         bodyLarge: TextThemes.body1,
  //       ),
  //     ),
  //     home: const CommunityScreen(),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(), // Root route
        // Settings route
      },
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFEEEEEE),
        appBarTheme: const AppBarTheme(
          color: Color(0xFF111111),
        ),
      ),
    );
  }
}
