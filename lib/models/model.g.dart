// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchBase _$SearchBaseFromJson(Map<String, dynamic> json) => SearchBase(
      pstn_dsnf_plc_no: json['PSTN_DSNF_PLC_NO'] as int,
      pstn_dsnf_plc_nm: json['PSTN_DSNF_PLC_NM'] as String,
      addr: json['ADDR'] as String,
      telno: json['PIC_TELNO'] as String,
      lot: (json['LOT'] as num).toDouble(),
      lat: (json['LAT'] as num).toDouble(),
      reference: json['reference'],
    );

Map<String, dynamic> _$SearchBaseToJson(SearchBase instance) =>
    <String, dynamic>{
      'PSTN_DSNF_PLC_NO': instance.pstn_dsnf_plc_no,
      'PSTN_DSNF_PLC_NM': instance.pstn_dsnf_plc_nm,
      'ADDR': instance.addr,
      'PIC_TELNO': instance.telno,
      'LOT': instance.lot,
      'LAT': instance.lat,
      'reference': instance.reference,
    };
