import 'package:flutter/material.dart';
import 'package:project_hub_design/screens/home_screen.dart';
import 'package:project_hub_design/viewmodels/project_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ProjectViewModel(),
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomeScreen(),
      routes: {

      },
    );
  }
}


