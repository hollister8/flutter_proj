import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MybaseList  {
  // final database = openDatabase(
  //   // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
  //   // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
  //   join(await getDatabasesPath(), 'mybase_database.db'),
  //   // 데이터베이스가 처음 생성될 때, mybase를 저장하기 위한 테이블을 생성합니다.
  //   onCreate: (db, version) {
  //     return db.execute(
  //       // "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
  //       "CREATE TABLE baselist("
  //           "id INTEGER PRIMARY KEY, pstn_dsnf_plc_nm TEXT, addr TEXT, telno TEXT, lat DOUBLE, lot DOUBLE"
  //           ")",
  //     );
  //   },
  //   // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
  //   // 수행하기 위한 경로를 제공합니다.
  //   version: 1,
  // );
  var database = null;
  Future<void> createMybase() async {
      database = openDatabase(
      // 데이터베이스 경로를 지정합니다. 참고: `path` 패키지의 `join` 함수를 사용하는 것이
      // 각 플랫폼 별로 경로가 제대로 생성됐는지 보장할 수 있는 가장 좋은 방법입니다.
      join(await getDatabasesPath(), 'mybase_database.db'),
      // 데이터베이스가 처음 생성될 때, mybase를 저장하기 위한 테이블을 생성합니다.
      onCreate: (db, version) {
        print("안녕하세요");
        return db.execute(
          // "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
          "CREATE TABLE baselist("
              "id INTEGER PRIMARY KEY, pstn_dsnf_plc_nm TEXT, addr TEXT, telno TEXT, lat DOUBLE, lot DOUBLE"
              ")",
        );
      },
      // 버전을 설정하세요. onCreate 함수에서 수행되며 데이터베이스 업그레이드와 다운그레이드를
      // 수행하기 위한 경로를 제공합니다.
      version: 1,
    );
  }

  Future<void> insertMybase(MyBase mybase) async {
    // 데이터베이스 reference를 얻습니다.
    final Database db = await database;

    // MyBase를 올바른 테이블에 추가하세요. 또한
    // `conflictAlgorithm`을 명시할 것입니다. 본 예제에서는
    // 만약 동일한 dog가 여러번 추가되면, 이전 데이터를 덮어쓸 것입니다.
    await db.insert(
      'baselist',
      mybase.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<MyBase>> baselist() async {
    // 데이터베이스 reference를 얻습니다.
    final Database db = await database;

    // 모든 MyBase를 얻기 위해 테이블에 질의합니다.
    final List<Map<String, dynamic>> maps = await db.query('baselist');

    // List<Map<String, dynamic>를 List<MyBase>으로 변환합니다.
    return List.generate(maps.length, (i) {
      return MyBase(
        id: maps[i]['id'],
        pstn_dsnf_plc_nm: maps[i]['pstn_dsnf_plc_nm'],
        addr: maps[i]['addr'],
        telno: maps[i]['telno'],
        lat: maps[i]['lat'],
        lot: maps[i]['lot']
      );
    });
  }

  Future<void> deleteMybase(int id) async {
    // 데이터베이스 reference를 얻습니다.
    final db = await database;

    // 데이터베이스에서 MyBase를 삭제합니다.
    await db.delete(
      'baselist',
      // 특정 base를 제거하기 위해 `where` 절을 사용하세요
      where: "id = ?",
      // MyBase의 id를 where의 인자로 넘겨 SQL injection을 방지합니다.
      whereArgs: [id],
    );
  }

  // var fido = MyBase(
  //   id: 0,
  //   pstn_dsnf_plc_nm: '한밭거점소독소',
  //   addr: '대전 동구',
  //   telno: '010-1234-5678',
  //   lat: 56.12,
  //   lot: 127.5363,
  // );
  //
  // // 데이터베이스에 dog를 추가합니다.
  // await insertMybase(fido);
  //
  // // dog 목록을 출력합니다. (지금은 Fido만 존재합니다.)
  // print(await baselist());
  //
  // // Fido를 데이터베이스에서 제거합니다.
  // // await deleteMybase(fido);
  //
  // // dog 목록을 출력합니다. (비어있습니다.)
  // //print(await baselist());
}

class MyBase {
  final int id;
  final String pstn_dsnf_plc_nm;
  final String addr;
  final String telno;
  final double lat;
  final double lot;

  MyBase({
    required this.id,
    required this.pstn_dsnf_plc_nm,
    required this.addr,
    required this.telno,
    required this.lat,
    required this.lot,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pstn_dsnf_plc_nm': pstn_dsnf_plc_nm,
      'addr': addr,
      'telno': telno,
      'lat': lat,
      'lot': lot,
    };
  }

  // 각 dog 정보를 보기 쉽도록 print 문을 사용하여 toString을 구현하세요
  @override
  String toString() {
    return 'MyBase{'
        'id: $id,'
        'pstn_dsnf_plc_nm: $pstn_dsnf_plc_nm, '
        'addr: $addr, '
        'telno: $telno'
        'lat: $lat'
        'lot: $lot'
        '}';
  }
}