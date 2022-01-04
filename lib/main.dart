import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hanbat/src/authentication.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'dart:io';

import 'package:hanbat/screen/login.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  KakaoContext.clientId = "69ad0d4c4f55a5590e678fe54aa4ef83";
  KakaoContext.javascriptClientId = "0e22ea5d9a9eca160726896acb768d6d";
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context, _) => const MyApp(),
    )
  );
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
      home: Consumer<ApplicationState>(
        builder: (context, appState, _) => Authentication(
          email: appState.email,
          loginState: appState.loginState,
          startLoginFlow: appState.startLoginFlow,
          verifyEmail: appState.verifyEmail,
          signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
          registerAccount: appState.registerAccount,
          cancelRegistration: appState.cancelRegistration,
          signOut: appState.signOut,
        ),
      ),
    );
  }
}