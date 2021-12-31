import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hanbat/constants.dart';
import 'package:hanbat/models/base.dart';
import 'package:hanbat/screen/home.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class MapPage extends StatelessWidget {
  final DatabaseReference reference;
  final Base base;

  const MapPage({Key? key, required this.base, required this.reference}) : super(key: key); //

  @override
  Widget build(BuildContext context) {
    int id = Random().nextInt(100);
    return Scaffold(
      appBar: AppBar(
        title: Text(base.pstn_dsnf_plc_nm),
        centerTitle: true,
        backgroundColor: hPrimaryColor,
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 20.0,),
            Text(base.addr),
            const SizedBox(height: 10.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              // Icon(Icons.call),
              Text("tel: " + base.telno),
              // Text( "${Icons.call}" + base.telno), // '\u{1F4DE}  '
              FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: hPrimaryColor,
                onPressed: () {
                  reference
                      .push()
                      .set(
                    base.pstn_dsnf_plc_nm,
                  ).then((_) {
                    Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0,),
            MaterialButton(
              minWidth: 80,
              height: 40,
              color: hPrimaryColor,
              child: Text("추가하기",
                  textAlign: TextAlign.center,
                  style: style.copyWith(color: Colors.white)),
              onPressed: (){
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Search(base: base[index],)
                  ),
                );
              }
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              margin: const EdgeInsets.only(top: 30.0),
              child: NaverMap(
                mapType: MapType.Basic,
                initialCameraPosition: CameraPosition(
                  target: LatLng(base.lat, base.lot),
                  zoom: 17,
                ),
                markers: [Marker(
                    markerId: id.toString(),
                    position: LatLng(base.lat, base.lot)
                )],
                //onMapCreated: _onMapCreated,
                // onMapTap: _onMapTap,
                initLocationTrackingMode: LocationTrackingMode.NoFollow,
              ),
            )
          ],
        )
      ),
    );
  }
}
