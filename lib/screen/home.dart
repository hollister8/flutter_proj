import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hanbat/constants.dart';
import 'package:hanbat/models/model.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    super.initState();
    streamData = firestore.collection('data').snapshots();
    readJson();
    print('readJson');
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
            .toList()
        ),
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

  Future <void> readJson() async {
    String jsonString  = await rootBundle.loadString('json/거점소독시설.json');
    final jsonResponse = jsonDecode(jsonString);
    var facility = SearchBase.fromJson(jsonResponse);
    print(facility);
  }

  @override
  Widget build(BuildContext context) {

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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    child: TextField(
                      style: const TextStyle(
                        fontSize: 13.0,
                      ),
                      onTap: () {

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
                                )
                            ),
                          )
                      );
                    }
                  )
                ],
              ),
            ),
            Center(
              child: Expanded(
                child: Container( // ListView.builder(itemBuilder: context) 추가
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.35,
                  margin: const EdgeInsets.only(top: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
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