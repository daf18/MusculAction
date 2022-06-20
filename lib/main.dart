import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './widgets/screens/categories_screen.dart';
import 'widgets/screens/exercice_category_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MusculAction',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.green,
        fontFamily: 'Anton',
      ),
      home: CategoryOverviewScreen(),
      routes: {
        ExerciceCategoryScreen.routeName: (context) => ExerciceCategoryScreen(),
        //AddExercice.routeName: (context) => AddExercice(),
        // ExerciceDetailsScreen.routeName: (context) => ExerciceDetailsScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MusculAction'),
      ),
      body: Center(
        child: Text('Let\'s work out!'),
      ),
    );
  }
}
