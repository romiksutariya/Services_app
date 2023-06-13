import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/providers/connectivity_provider.dart';
import 'package:services_app/views/screens/home_page.dart';
import 'package:services_app/views/screens/splash_screen.dart';

void main() async {
  runApp(
    MultiProvider(

      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        )
      ],
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData.light(useMaterial3: true),
          darkTheme: ThemeData.dark(useMaterial3: true),
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => SplashScreen(),
            'home_page': (context) => HomePage(),
          },
        );
      },
    ),
  );
}