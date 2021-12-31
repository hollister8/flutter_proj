import 'package:firebase_database/firebase_database.dart';
import 'dart:core';

class Base {
  int pstn_dsnf_plc_no;
  String pstn_dsnf_plc_nm;
  String addr;
  late String telno;
  late double lot;
  late double lat;

  Base(
      this.pstn_dsnf_plc_no,
      this.pstn_dsnf_plc_nm,
      this.addr,
      this.telno,
      this.lot, // 경도
      this.lat, // 위도
      );

  Base.fromSnapshot(DataSnapshot snapshot)
      : pstn_dsnf_plc_no = (snapshot.value as Map)['PSTN_DSNF_PLC_NO'],
        pstn_dsnf_plc_nm = (snapshot.value as Map)['PSTN_DSNF_PLC_NM'],
        addr = (snapshot.value as Map)['ADDR'],
        telno = (snapshot.value as Map)['PIC_TELNO'],
        lot = (snapshot.value as Map)['LOT'],
        lat = (snapshot.value as Map)['LAT'];

  fromJson() {
    return {
      'PSTN_DSNF_PLC_NO' : pstn_dsnf_plc_no,
      'PSTN_DSNF_PLC_NM' : pstn_dsnf_plc_nm,
      'ADDR' : addr,
      'PIC_TELNO' : telno,
      'LOT' : lot,
      'LAT' : lat,
    };
  }
}