import 'dart:async';
import 'dart:io';

import 'package:app/core/actor.dart';
import 'package:dart_ipify/dart_ipify.dart';

abstract class Federation {
  //
  static late final String _ipv64;
  static late final Actor _actor;

  static Future<Actor> join() async {
    //
    _ipv64 = await Ipify.ipv64();
    _actor = await Actor.init();

    return _actor
      ..insert(
        'INSERT OR IGNORE INTO federation'
        '(ipv64, relation) VALUES("$_ipv64", "me");',
      )
      ..query('SELECT ipv64 FROM federation').then(
        (List<Map<String, Object?>> federation) {
          for (Map<String, Object?> actor in federation) {
            Socket.connect(actor['ipv64'], 12358).then(
              (Socket socket) => socket
                ..write(_ipv64)
                ..close(),
            );
          }
        },
      );
  }

  static Future<Actor> leave() async {
    //
    return _actor
      ..delete(
        'DELETE FROM federation'
        ' WHERE relation = "me";',
      )
      ..query('SELECT ipv64 FROM federation').then(
        (List<Map<String, Object?>> federation) {
          for (Map<String, Object?> actor in federation) {
            Socket.connect(actor['ipv64'], 12358).then(
              (Socket socket) => socket
                ..write(_ipv64)
                ..close(),
            );
          }
        },
      );
  }
}
