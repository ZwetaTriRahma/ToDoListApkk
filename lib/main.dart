import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/task.dart';
import './screens/homepage.dart';

void main() {
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.blue[50],
          hintColor: Colors.white70,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue.shade600, width: 2),
            ),
          ),
          fontFamily: 'Lato',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleLarge: const TextStyle(
                  color: Colors.blue,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
                titleMedium: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                bodyLarge: TextStyle(
                  color: Colors.blue.shade700,
                ),
                bodyMedium: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.blue,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontFamily: 'Lato',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: 'To Do List',
        home: const Homepage(),
      ),
    );
  }
}
