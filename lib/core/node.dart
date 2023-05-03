import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

mixin Node on ChangeNotifier {
  //
  Future<int> delete(String query) {
    return _database.transaction((Transaction txn) {
      return txn.rawDelete(query).whenComplete(notifyListeners);
    });
  }

  Future<int> update(String query) {
    return _database.transaction((Transaction txn) {
      return txn.rawUpdate(query).whenComplete(notifyListeners);
    });
  }

  Future<int> insert(String query) {
    return _database.transaction((Transaction txn) {
      return txn.rawInsert(query).whenComplete(notifyListeners);
    });
  }

  Future<List<Map<String, Object?>>> query(String query) {
    return _database.transaction((Transaction txn) {
      return txn.rawQuery(query).whenComplete(notifyListeners);
    });
  }

  late final Database _database;

  /// asynchronous initializer
  Future<void> node() async {
    //
    if (Platform.isWindows || Platform.isLinux) {
      databaseFactory = databaseFactoryFfi;
      sqfliteFfiInit();
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'actor.db'),
      onCreate: (database, version) => database.execute(
        //
        'CREATE TABLE IF NOT EXISTS federation('
        /* 'uuid5      TEXT  PRIMARY KEY,' */
        'ipv64      TEXT  NOT NULL PRIMARY KEY,'
        'relation   TEXT  CHECK(relation IN ("me","i","o","io")),'
        'username   TEXT,'
        'password   TEXT'
        ') WITHOUT ROWID;'
        //
        'CREATE INDEX IF NOT EXISTS'
        ' relation ON federation(relation);'
        //
        'CREATE TABLE IF NOT EXISTS feed('
        'date   DATETIME  PRIMARY KEY   DEFAULT CURRENT_TIMESTAMP,'
        'type   TEXT      NOT NULL      CHECK(type IN ("i","o")),'
        'load   TEXT      NOT NULL'
        ') WITHOUT ROWID;'
        //
        'CREATE INDEX IF NOT EXISTS'
        ' type ON feed(type);',
      ),
      version: 1,
    );
  }
}
