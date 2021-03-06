import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:hanbat/screen/disinfection.dart';
import 'package:hanbat/screen/signup.dart';
import 'package:hanbat/constants.dart';
import 'package:hanbat/src/authentication.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ // Key? key}) : super(key: key);

  required this.login,
  required this.email,
  });
  final String email;
  final void Function(String email, String password) login;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _mailCon = TextEditingController();
  final _nameCon = TextEditingController();
  final _pwCon = TextEditingController();

  var validateToken;

  _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);

      if (validateToken.refreshToken == null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(login: (String email, String password) {  }, email: '',), // 로그인 화면으로 다시 가야 함
            ));
      } else {
        /// 카카오 로그인 성공시 사용자 정보 print
        var kakaoUser = await UserApi.instance.me();

        print('> kakao id : ${kakaoUser.id.toString()}');
        print('> nickname : ${kakaoUser.properties!['nickname']}');
        print(
            '> thumbnail_image : ${kakaoUser.properties!['thumbnail_image']}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      await _issueAccessToken(code);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {

    const logo = Text("FARM ONDA",
      style: TextStyle(
        fontSize: 25.0,
      ),
    );

    final emailField = TextFormField(
      controller: _mailCon,
      style: style,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "이메일",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '계속하려면 이메일을 입력하세요.';
        }
        return null;
      },
    );

    final passwordField = TextFormField(
      controller: _pwCon,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
        hintText: "비밀번호",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '계속하려면 비밀번호를 입력하세요.';
        }
        return null;
      },
    );

    final signUp = TextButton(
      style: TextButton.styleFrom(
        textStyle: style,
        primary: hPrimaryColor,
      ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage(
              registerAccount: (String email, String displayName, String password) {
              }, cancel: () {  }, email: '',))
          );
        },
      child: const Text("회원가입"),
    );

    final findID = TextButton(
      style: TextButton.styleFrom(
        textStyle: style,
        primary: hPrimaryColor,
      ),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search())
        );
      },
      child: const Text("아이디/ 비밀번호 찾기"),
    );

    const lLine = BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.grey,
          hPrimaryColor,
        ],
        begin: FractionalOffset(0.0, 0.0),
        end: FractionalOffset(1.0, 1.0),
        stops: [0.5, 1.0],
        tileMode: TileMode.clamp
        ),
      );

    const social = Text("간편 로그인",
        style: TextStyle(
          fontSize: 13.0,
          color: hPrimaryColor,
        ),
    );

    const rLine = BoxDecoration(
      gradient: LinearGradient(
          colors: [
            Colors.grey,
            hPrimaryColor,
          ],
          begin: FractionalOffset(1.0, 1.0),
          end: FractionalOffset(0.0, 0.0),
          stops: [0.5, 1.0],
          tileMode: TileMode.clamp
      ),
    );

    final kakaoLogin = GestureDetector(
      onTap: () => {_loginWithKakao()},
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.all(23.0),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffFFE812)
        ),
      ),
    );

    final naverLogin = GestureDetector(
      onTap: () => {},
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.all(23.0),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff19CE60)
        ),
      ),
    );

    final googleLogin = GestureDetector(
      onTap: () => {},
      child: Container(
        margin: const EdgeInsets.only(top: 30.0),
        padding: const EdgeInsets.all(23.0),
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xffE73838)
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false, // 키보드 올라올 때 대응
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(height: 30.0,),
                    emailField,
                    const SizedBox(height: 30.0,),
                    passwordField,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(width: 1.0,),
                        signUp,
                        const SizedBox(width: 127.0,),
                        findID,
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(height: 30.0,),
                        StyledButton(
                          child: Text("로그인",
                              textAlign: TextAlign.center,
                              style: style.copyWith(
                                  color: Colors.white)
                          ),
                          onPressed: () {
                            // Navigator.push(
                            //     context, MaterialPageRoute(
                            //     builder: (context) => Disinfection())
                            // );
                            if (_formKey.currentState!.validate()) {
                              widget.login(
                                _mailCon.text,
                                _pwCon.text,
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          decoration: lLine,
                          width: 100.0,
                          height: 1.0,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          child: social,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50.0),
                          decoration: rLine,
                          width: 100.0,
                          height: 1.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        kakaoLogin,
                        naverLogin,
                        googleLogin,
                      ],
                    ),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
