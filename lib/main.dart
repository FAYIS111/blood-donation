import 'package:flutter/material.dart';
import 'package:miracle_aqua_02/add.dart';
import 'package:miracle_aqua_02/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miracle_aqua_02/update.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "blood donation",
      routes: {
        "firstPage": (context) => const HomePage(),
        "/add": (context) => const AddUser(),
        "update": (context) => UpdateDonor(),
      },
      initialRoute: "firstPage",
    );
  }
}
