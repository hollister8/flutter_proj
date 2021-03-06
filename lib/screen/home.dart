import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hanbat/constants.dart';
import 'package:hanbat/models/base.dart';
import 'package:hanbat/models/model.dart';
import 'package:hanbat/models/mybase_list.dart';
import 'package:hanbat/screen/map.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  // final List<Base> base;
  // final MyBase mybase;

  const Search({Key? key}) : super(key: key); // , required this.base // , required this.mybase

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FirebaseDatabase? _database;
  DatabaseReference? reference;
  final String _databaseURL = 'https://farmonda-437d5-default-rtdb.firebaseio.com/';
  List<Base> bases = List.empty(growable: true);
  List<MyBase> baselist = List.empty(growable: true);

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> streamData;
  final GlobalKey _searchBarKey = GlobalKey();
  final LayerLink _searchBarLink = LayerLink();

  void initState() {
    super.initState();
    streamData = firestore.collection('data').snapshots();

    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('data');

    reference!.onChildAdded.listen((event) {
      // print(event.snapshot.value.toString());
      setState(() {
        bases.add(Base.fromSnapshot(event.snapshot));
      });
    });
    //reference.once().then((DataSnapshot dataSnapshot) => dataSnapshot.value)
  }

  // Offset _getOverlayEntryPosition() {
  //   RenderBox renderBox =
  //   _searchBarKey.currentContext!.findRenderObject()! as RenderBox;
  //   return Offset(renderBox.localToGlobal(Offset.zero).dx,
  //       renderBox.localToGlobal(Offset.zero).dy + renderBox.size.height
  //   );
  // }
  //
  // Size _getOverlayEntrySize() {
  //   RenderBox renderBox =
  //   _searchBarKey.currentContext!.findRenderObject()! as RenderBox;
  //   return renderBox.size;
  // }

  void _showOverlay(BuildContext context) async {
    // Offset position = _getOverlayEntryPosition();
    // Size size = _getOverlayEntrySize();
    OverlayState? overlayState = Overlay.of(context);
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context){
      return Positioned(
        // left: position.dx,
        // top: position.dy,
        left: MediaQuery.of(context).size.width * 0.1,
        top: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.9,
        child: CompositedTransformFollower(
          link: _searchBarLink,
          showWhenUnlinked: false,
          // offset: Offset(0, size.height),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))
            ),
            child: ListView.builder(
              itemCount: bases.length,
              itemBuilder: (context, index) {
                return Material(
                  child: InkWell(
                    child: ListTile(
                      title: Text(bases[index].pstn_dsnf_plc_nm),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MapPage(base: bases[index])) // , reference: reference!
                        );
                      },
                    ),
                  )
                );
              }
            ),
          ),
        )
      );
    });
    overlayState?.insert(overlayEntry);

    await Future.delayed(const Duration(seconds: 10));

    overlayEntry.remove();
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: streamData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const LinearProgressIndicator();
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
        // ???????????? ????????? ?????? ??????
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
        _showOverlay(context);
      } else {
        '';
      }
    });
   }

  Future <void> readJson() async {
    String jsonString  = await rootBundle.loadString('json/??????????????????.json');
    final jsonResponse = jsonDecode(jsonString);
    var facility = SearchBase.fromJson(jsonResponse);
    print(facility);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("????????????????????????"),
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
                    child: CompositedTransformTarget(
                      link: _searchBarLink,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 13.0,
                        ),
                        onTap: () {
                          //_showOverlay(context);
                          _focusListen();
                          },
                        focusNode: focusNode,
                        controller: _filter,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.search, color: hPrimaryColor),
                          hintText: "?????????????????? ???????????????.",
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
                  ),
                const SizedBox(height: 10,),
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('asdf').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return SizedBox(
                          height: 30,
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
              child: baselist.length == 0
                ? Text("????????? ?????????????????? ????????????.",
                    style: TextStyle(color: Colors.black45),
                  )
                : Expanded(
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                        itemCount: baselist.length,
                        itemBuilder: (context, position) {
                          return Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.only(bottom: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.height * 0.25,
                              margin: const EdgeInsets.only(bottom: 60.0),
                              child: NaverMap(
                                mapType: MapType.Basic,
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
                          );
                        }
                    ),
              ))
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