import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:kakao_flutter_sdk/all.dart';

import 'package:hanbat/screen/login.dart';

void main() {
  KakaoContext.clientId = "69ad0d4c4f55a5590e678fe54aa4ef83";
  KakaoContext.javascriptClientId = "0e22ea5d9a9eca160726896acb768d6d";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FARM ONDA',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const LoginPage(),
    );
  }
}