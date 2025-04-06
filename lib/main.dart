
import 'package:flutter/material.dart';
import 'package:sentinova/helper/data.dart';
import 'package:sentinova/helper/init_user.dart';
import 'package:sentinova/screens/community_screen.dart';
import 'package:sentinova/screens/profile_screen.dart';
import 'package:sentinova/services/apiservice.dart';
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
  ApiService.addUser(currUser!);
  runApp(Sentinova());
}

class Sentinova extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFF29000),
        brightness: Brightness.light,
        textTheme: const TextTheme(
          titleLarge: TextThemes.title,
          titleMedium: TextThemes.subtitle, // or bodyMedium
          bodyLarge: TextThemes.body1,
        ),
      ),
      home: const CommunityScreen(),
    );
  }
}
