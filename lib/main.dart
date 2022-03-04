import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shell_hackathon_1/scanner.dart';
import 'package:vibration/vibration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Center(
              child: ElevatedButton(
                  onPressed: () async {
                    String code = await scanBarcode();
                    await Vibration.vibrate();
                    print("Code" + code);
                  },
                  child: Text("Scan Code")))),
    );
  }
}
