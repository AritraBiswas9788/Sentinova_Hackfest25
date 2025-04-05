import 'package:flutter/material.dart';
import 'package:sentinova/screens/community_screen.dart';
import 'package:sentinova/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoService.connect(); // Make sure to connect before using
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
