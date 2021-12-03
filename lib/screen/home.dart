import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hanbat/constants.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
          prefixIcon: Icon(Icons.search),
          hintText: "거점소독소를 검색하세요.",
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
              child: search,
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