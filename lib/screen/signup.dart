import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hanbat/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {

    const signup = Text("회원가입",
      style: TextStyle(
        fontSize: 18.0,
        color: Color(0xff444444),
      ),
    );

    const user = Text("사용자 이름",
      style: TextStyle(
        fontSize: 13.0,
        color: Colors.black54,
      ),
    );

    final userName = TextField(
      style: style,
      decoration: InputDecoration(
        // enabledBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.black26),
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      ),
    );

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: hPrimaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        child: Text("회원가입",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white)
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
            child: ListView(
              children: <Widget>[
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20.0,),
                  signup,
                  const SizedBox(height: 30.0,),
                  user,
                  const SizedBox(height: 2.0,),
                  userName,
                  const SizedBox(height: 20.0,),
                  user,
                  const SizedBox(height: 2.0,),
                  userName,
                  const SizedBox(height: 20.0,),
                  user,
                  const SizedBox(height: 2.0,),
                  userName,
                  const SizedBox(height: 20.0,),
                  user,
                  const SizedBox(height: 2.0,),
                  userName,
                  const SizedBox(height: 20.0,),
                  user,
                  const SizedBox(height: 2.0,),
                  userName,
                  const SizedBox(height: 20.0,),
                  user,
                  const SizedBox(height: 2.0,),
                  userName,
                  const SizedBox(height: 20.0,),
                  signUpButton,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
