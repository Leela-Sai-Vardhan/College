import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the Provider package

import 'models/user_model.dart'; // Import your UserModel class
import 'role_selection_page.dart'; // Import your RoleSelectionPage

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserModel(), // Provide UserModel to the widget tree
      child: MaterialApp(
        title: 'VRSEC Admin',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: RoleSelectionPage(), // Your app's starting page
      ),
    );
  }
}
