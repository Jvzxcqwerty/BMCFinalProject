import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async { // 1. Make the 'main' function asynchronous

  // 2. Ensure Flutter is ready before calling native code
  WidgetsFlutterBinding.ensureInitialized();

  // 3. Initialize Firebase
  await Firebase.initializeApp(
    // 4. Use the options from our generated file
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 5. Run the app (this line is already here)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. MaterialApp is the root of your app
    return MaterialApp(
      // 2. This removes the "Debug" banner
      debugShowCheckedModeBanner: false,
      title: 'eCommerce App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      // 3. A simple placeholder for our home screen
      home: Scaffold(
        appBar: AppBar(
          title: Text('My E-Commerce App'),
        ),
        body: Center(
          child: Text('Firebase is Connected!'),
        ),
      ),
    );
  }
}
