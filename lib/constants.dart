import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

const hPrimaryColor = Color(0xff5D5FEF);
const hTextColor = Color(0xff444444); // 0xff636363
const hBackgroundColor = Color(0xffECE8F4);

TextStyle style = const TextStyle(fontFamily: 'CupertinoIcons', fontSize: 13.0);

class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed});
  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Material(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(10.0),
      color: hPrimaryColor,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width,
      height: 50,
  onPressed: onPressed,
  child: child,
    ),
  );
}