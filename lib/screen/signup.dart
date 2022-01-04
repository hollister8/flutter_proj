import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hanbat/constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    required this.registerAccount,
    required this.cancel,
    required this.email,
  });
  final String email;
  final void Function(String email, String displayName, String password)
  registerAccount;
  final void Function() cancel;
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _mailCon = TextEditingController();
  final _nameCon = TextEditingController();
  final _pwCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mailCon.text = widget.email;
  }

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

    final userName = TextFormField(
      style: style,
      controller: _nameCon,
      decoration: InputDecoration(
        // enabledBorder: const OutlineInputBorder(
        //   borderSide: BorderSide(color: Colors.black26),
        //   borderRadius: BorderRadius.all(Radius.circular(10)),
        // ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: '이름',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '필수 항목입니다.';
        }
        return null;
      },
    );

    final email = TextFormField(
      style: style,
      controller: _mailCon,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: '이메일',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '필수 항목입니다.';
        }
        return null;
      },
    );

    final password = TextFormField(
      style: style,
      controller: _pwCon,
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: '비밀번호',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '필수 항목입니다.';
        }
        return null;
      },
    );

    final signUpButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: hPrimaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        height: 50,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            widget.registerAccount(
              _mailCon.text,
              _nameCon.text,
              _pwCon.text,
            );
            // Navigator.of(context).pop();
          }
        },
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
                Form(
                  key: _formKey,
                  child: Column(
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
                      const Text("이메일",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 2.0,),
                      email,
                      const SizedBox(height: 20.0,),
                      const Text("비밀번호",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 2.0,),
                      password,
                      const SizedBox(height: 20.0,),
                      signUpButton,
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
