import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hanbat/constants.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

part 'home.g.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;
  @override
  void iniState() {
    super.initState();
    streamData = firestore.collection('data').snapshots();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildList(context, snapshot.data!.docs);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<DocumentSnapshot> searchResults = [];
    for (DocumentSnapshot i in snapshot) {
      if (i.data.toString().contains(_searchText)) {
        searchResults.add(i);
      }
    }
    return Expanded(
        child: ListView(
          padding: const EdgeInsets.all(3),
          children: searchResults
              .map((data) => _buildListItem(context, data))
              .toList()),
            // .map((data) => SearchBase(pstn_dsnf_plc_nm: snapshot.data.docs[index]['PSTN_DSNF_PLC_NM'],)
            // .toList()),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final base = SearchBase.fromSnapshot(data);
    return InkWell(
      //child: Container(padding: const EdgeInsets.all(3),),
      child: Text(base.pstn_dsnf_plc_nm),
      onTap: () {
        // 클릭하면 네이버 맵에 표시
        },
      );
  }

  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";
  // RenderBox renderBox = context.findRenderObject();
  // final size = renderBox.size;
  // final offset = renderBox.localToGlobal(Offset.zero);

  _searchState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

  _focusListen() {
    focusNode.addListener(() {
      if(focusNode.hasFocus) {
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.yellow,);
        // Widget build (BuildContext context) {
        //   return Scaffold(
        //     builder: (context)  => Positioned(
        //       left: offset.dx,
        //       top: offset.dy + size.height + 5.0,
        //       width: size.width,
        //       child: Material(
        //       elevation: 5,
        //         child: ListView(
        //           padding: EdgeInsets.zero,
        //           shrinkWrap: true,
        //         ),
        //     )
        //   )
        // );
        // }
      }
    });
   }

  Future<void> readJson() async {
    String jsonString = await rootBundle.loadString('json/거점소독시설.json');
    final jsonResponse = jsonDecode(jsonString);
  }

  @override
  Widget build(BuildContext context) {

    final search = Material(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)),
      child: const TextField(
        style: TextStyle(
          fontSize: 13.0,
        ),
        decoration: InputDecoration(
          filled: true,
          prefixIcon: Icon(Icons.search),
          hintText: "거점소독소를 검색하세요.",
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        ),
      ),
    );

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("거점소독시설목록"),
        centerTitle: true,
        backgroundColor: hPrimaryColor,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              margin: const EdgeInsets.only(top: 30.0),
              //child: search,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10)
              // ),
              child: Row(
                children: <Widget>[
                  Expanded(child:
                  Material(
                    elevation: 5,
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                      onTap: () {
                        _focusListen;
                        },
                      focusNode: focusNode,
                      controller: _filter,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.search, color: hPrimaryColor),
                        hintText: "거점소독소를 검색하세요.",
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                        ),
                        contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        suffixIcon: focusNode.hasFocus
                          ? IconButton(onPressed: () {
                              setState(() {
                                _filter.clear();
                                _searchText = "";
                                focusNode.unfocus();
                                });
                              } ,
                              icon: const Icon(
                                Icons.cancel,
                                size: 20,
                                color: hPrimaryColor,
                              ),
                            )
                          : Container(),
                      ),
                    ),
                  ),
                  ),
                const SizedBox(height: 10,),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('SearchBase').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return SizedBox(
                          height: 10,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (ctx, index) => Container(
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    _buildBody(context)
                                  ],
                                )),
                          ));
                    }
                )
                ],
              ),
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.35,
                margin: const EdgeInsets.only(top: 30.0),
                color: Colors.white,
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const SizedBox(
                    child: NaverMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(37.566570, 126.978442),
                        zoom: 17,
                      ),
                      //onMapCreated: _onMapCreated,
                      // onMapTap: _onMapTap,
                      // markers: _markers,
                      initLocationTrackingMode: LocationTrackingMode.NoFollow,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// void _onMapCreated(NaverMapController controller) {
//   _naverMapController.complte(controller);
// }
//
// void _naverMapController() {}
//
// void _onMapTap(LatLng latLng) {}

@JsonSerializable()
class SearchBase {
  @JsonKey(name: 'PSTN_DSNF_PLC_NO')
  int pstn_dsnf_plc_no;
  @JsonKey(name: 'PSTN_DSNF_PLC_NM')
  String pstn_dsnf_plc_nm;
  @JsonKey(name: 'ADDR')
  String addr;
  @JsonKey(name: 'PIC_TELNO')
  String telno;
  @JsonKey(name: 'LOT')
  double lot;
  @JsonKey(name: 'LAT')
  double lat;

  var reference;
  // final DocumentReference reference;

  SearchBase({
    required this.pstn_dsnf_plc_no,
    required this.pstn_dsnf_plc_nm,
    required this.addr,
    required this.telno,
    required this.lot,
    required this.lat,
    required this.reference,
  });

  // factory SearchBase.fromJson(Map<String, dynamic> json {this.reference}) => _$SearchBaseFromJson(json);
  // Map<String, dynamic> toJson() => _$SearchBaseToJson(this);

  SearchBase.fromJson(Map<String, dynamic> json, {this.reference})
    : pstn_dsnf_plc_nm = json['pstn_dsnf_plc_nm'],
      pstn_dsnf_plc_no = json['pstn_dsnf_plc_no'],
      addr = json['addr'];

  SearchBase.fromSnapshot(DocumentSnapshot snapshot)
    : this.fromJson(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Base<$pstn_dsnf_plc_nm>";
}
