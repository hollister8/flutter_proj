import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hanbat/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:intl/intl.dart';

class Disinfection extends StatefulWidget {
  const Disinfection({Key? key}) : super(key: key);

  @override
  _DisinfectionState createState() => _DisinfectionState();
}

class _DisinfectionState extends State<Disinfection> {
  final TextStyle _textStyle = const TextStyle(color: Color(0xff6b6b6b), fontSize: 11.0);
  final SizedBox _sizedBox = const SizedBox(height: 10.0,);

  GlobalKey globalKey = GlobalKey();
  String _dataString = "QR 체크인";

  @override
  Widget build(BuildContext context) {

    getCurrentDate() {
      return DateFormat('yyyy.MM.dd kk:mm').format(DateTime.now());
    }

    final confirmButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(10.0),
      color: hPrimaryColor,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("확인",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white)
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("전자소독필증"),
        centerTitle: true,
        backgroundColor: hPrimaryColor,
      ),
      body: Center(
        child: ListView(
          children: [
            Column(
              children: <Widget>[
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(top: 50.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    width: 190.0,
                    height: 190.0,
                        // key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        QrImage(
                          version: 3,
                          data: "https://www.naver.com/",
                          size: 170.0,
                        ),
                      ],
                    )
                  ),
                ),
                Card(
                  elevation: 5.0,
                  color: const Color(0xffECE8F4),
                  margin: const EdgeInsets.only(top: 30.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 80.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("발급일자"),
                        Text(getCurrentDate()),
                      ],
                    )
                  ),
                ),
                Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.only(top: 30.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.fromLTRB(36.0, 20.0, 36.0, 20.0),
                    height: 340.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("기본정보",),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("운전자명", style: _textStyle,),
                                  _sizedBox,
                                  Text("차량번호", style: _textStyle,),
                                  _sizedBox,
                                  Text("차량뷴류", style: _textStyle,),
                                  _sizedBox,
                                  Text("차종명", style: _textStyle,),
                                  _sizedBox,
                                  Text("최대적재량", style: _textStyle,),
                                  _sizedBox,
                                  ],
                                ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _sizedBox,
                                  Text("홍길동", style: _textStyle,),
                                  _sizedBox,
                                  Text("25마 3245", style: _textStyle,),
                                  _sizedBox,
                                  Text("축산차량", style: _textStyle,),
                                  _sizedBox,
                                  Text("car", style: _textStyle,),
                                  _sizedBox,
                                  Text("0톤", style: _textStyle,),
                                  _sizedBox,
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Text("추가정보"),
                        Container(
                          margin: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _sizedBox,
                                  Text("출발지", style: _textStyle,),
                                  _sizedBox,
                                  Text("도착지", style: _textStyle,),
                                  _sizedBox,
                                  Text("방문목적", style: _textStyle,),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("청주", style: _textStyle,),
                                  _sizedBox,
                                  Text("청주", style: _textStyle,),
                                  _sizedBox,
                                  Text("계란운반", style: _textStyle,),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(30.0),
                  padding: const EdgeInsets.only(bottom: 50.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: confirmButton,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
