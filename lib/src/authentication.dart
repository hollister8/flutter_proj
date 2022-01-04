import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hanbat/constants.dart';
import 'package:hanbat/screen/disinfection.dart';

import 'package:hanbat/screen/login.dart';
import 'package:hanbat/screen/signup.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  const Authentication({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  });

  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
      String email,
      void Function(Exception e) error,
      ) verifyEmail;
  final void Function(
      String email,
      String password,
      void Function(Exception e) error,
      ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
      String email,
      String displayName,
      String password,
      void Function(Exception e) error,
      ) registerAccount;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return LoginPage(login: (String email, String password) {  }, email: '',);
      case ApplicationLoginState.emailAddress:
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, '잘못된 이메일입니다.', e)));
      case ApplicationLoginState.password:
        return PasswordForm(
          email: email!,
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                    (e) => _showErrorDialog(context, '로그인에 실패하였습니다.', e));
          },
        );
      // case ApplicationLoginState.password:
      //   return VerifyForm(
      //       callback: (email) => verifyEmail(
      //         email, (e) => _showErrorDialog(context, '잘못된 이메일입니다!@@@@@', e)
      //       ),
      //       email: email!,
      //       login: (email, password) {
      //         signInWithEmailAndPassword(email, password,
      //             (e) => _showErrorDialog(context, '로그인에 실패!@@@@@', e));
      //       },
      //   );
      case ApplicationLoginState.register:
        return SignUpPage(
          email: email!,
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
              email,
              displayName,
              password,
              ) {
            registerAccount(
                email,
                displayName,
                password,
                    (e) =>
                    _showErrorDialog(context, '계정 생성에 실패하였습니다.', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        return Disinfection();
        //   Row(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.only(left: 24, bottom: 8),
        //       child: StyledButton(
        //         onPressed: () {
        //           signOut();
        //         },
        //         child: const Text('로그아웃'),
        //       ),
        //     ),
        //   ],
        // );
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }
  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            StyledButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                '확인',
                style: TextStyle(color: hPrimaryColor),
              ),
            ),
          ],
        );
      },
    );
  }
}

class VerifyForm extends StatefulWidget {
  const VerifyForm({
    required this.callback,
    required this.login,
    required this.email,
  });
  final String email;
  final void Function(String email, String password) login;
  final void Function(String email) callback;

  @override
  _VerifyFormState createState() => _VerifyFormState();
}

class _VerifyFormState extends State<VerifyForm> {
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage(login: (String email, String password) {  }, email: '',);
  }
}

// 이메일폼
class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback});
  final void Function(String email) callback;
  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LoginPage(login: (String email, String password) {  }, email: '',);
    //   Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Form(
    //         key: _formKey,
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Padding(
    //               padding: const EdgeInsets.symmetric(horizontal: 24),
    //               child: TextFormField(
    //                 controller: _controller,
    //                 decoration: const InputDecoration(
    //                   hintText: '이메일을 입력하세요',
    //                 ),
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return '계속하려면 이메일을 입력하세요~~~';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(
    //                       vertical: 16.0, horizontal: 30),
    //                   child: StyledButton(
    //                     onPressed: () async {
    //                       if (_formKey.currentState!.validate()) {
    //                         widget.callback(_controller.text);
    //                       }
    //                     },
    //                     child: const Text('다음'),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}

// class RegisterForm extends StatefulWidget {
//   const RegisterForm({
//     required this.registerAccount,
//     required this.cancel,
//     required this.email,
//   });
//   final String email;
//   final void Function(String email, String displayName, String password)
//   registerAccount;
//   final void Function() cancel;
//   @override
//   _RegisterFormState createState() => _RegisterFormState();
// }
//
// class _RegisterFormState extends State<RegisterForm> {
//   final _formKey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
//   final _mailCon = TextEditingController();
//   final _nameCon = TextEditingController();
//   final _pwCon = TextEditingController();
//
//   var registerAccount;
//
//   @override
//   void initState() {
//     super.initState();
//     _mailCon.text = widget.email;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SignUpPage(registerAccount: registerAccount);
//   }
// }

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    required this.login,
    required this.email,
  });
  final String email;
  final void Function(String email, String password) login;
  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return LoginPage(login: (String email, String password) {  }, email: '',);
  }
}

// 어플리케이션 상태
class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    await Firebase.initializeApp();

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void verifyEmail(
      String email,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      var methods =
      await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signInWithEmailAndPassword(
      String email,
      String password,
      void Function(FirebaseAuthException e) errorCallback,
      ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  void registerAccount(String email, String displayName, String password,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateProfile(displayName: displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
