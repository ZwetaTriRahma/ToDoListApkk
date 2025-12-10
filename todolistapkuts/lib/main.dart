import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/task.dart';
import './screens/homepage.dart';

void main() => runApp(ToDoListApp());

class ToDoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.purple,
          hintColor: Colors.yellow[700],
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: TextStyle(
                  color: Colors.purple,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
                titleMedium: TextStyle(
                  color: Colors.purple,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.purple,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: 'To Do List',
        home: Homepage(),
      ),
    );
  }
}
