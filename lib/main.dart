import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revision/Provider/profileProvider.dart';
import 'package:revision/Provider/todoProvider.dart';
import 'package:revision/modals/profileModal.dart';
import 'package:revision/views/getX/getXpage.dart';
import 'package:revision/views/taskScreen.dart';
import 'package:revision/views/updateProfile.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Todo()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      routes: {
        '/': (context) => UpdatePrfoileScreen(),
        '/TaskScreen':
            (context) => Taskscreen(
              // profile:
              //     ModalRoute.of(context)!.settings.arguments as ProfileModal,
            ),
        '/updateprofile': (context) => UpdatePrfoileScreen(),
        '/counter': (context) => CounterPage(),
      },
    );
  }
}
