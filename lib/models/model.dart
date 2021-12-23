import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class SearchBase {
  @JsonKey(name: 'PSTN_DSNF_PLC_NO')
  int pstn_dsnf_plc_no;
  @JsonKey(name: 'PSTN_DSNF_PLC_NM')
  String pstn_dsnf_plc_nm;
  @JsonKey(name: 'ADDR')
  String addr;
  @JsonKey(name: 'PIC_TELNO')
  late String telno;
  @JsonKey(name: 'LOT')
  late double lot;
  @JsonKey(name: 'LAT')
  late double lat;

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

  // factory SearchBase.fromJson(Map<String, dynamic> json) => _$SearchBaseFromJson(json);
  // Map<String, dynamic> toJson() => _$SearchBaseToJson(this);

  SearchBase.fromJson(Map<String, dynamic> json, {this.reference})
      : pstn_dsnf_plc_nm = json["pstn_dsnf_plc_nm"],
        pstn_dsnf_plc_no = json["pstn_dsnf_plc_no"],
        addr = json["addr"];

  SearchBase.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot.data() as Map<String, dynamic>, reference: snapshot.reference);

  @override
  String toString() => "Base<$pstn_dsnf_plc_nm>";
}