import 'dart:io';
import 'dart:typed_data';

import 'package:app/core/node.dart';
import 'package:app/core/user.dart';
import 'package:flutter/material.dart';

class Actor with ChangeNotifier, Node, User {
  //

  Future<List<Map<String, Object?>>> get outbox {
    return query('SELECT * FROM feed WHERE type = "o";');
  }

  Future<List<Map<String, Object?>>> get inbox {
    return query('SELECT * FROM feed WHERE type = "i";');
  }

  Future<List<Map<String, Object?>>> get followers {
    return query('SELECT * FROM federation WHERE relation = "o";');
  }

  Future<List<Map<String, Object?>>> get following {
    return query('SELECT * FROM federation WHERE relation = "i";');
  }

  Future<List<Map<String, Object?>>> get self {
    return query('SELECT * FROM federation WHERE relation = "me";');
  }

  set binding(address) {
    insert('INSERT OR IGNORE INTO federation(ipv64) VALUES("$address");');
  }

  Actor._();
  static final _instance = Actor._();
  static Future<Actor> init() async {
    //
    await _instance.node();
    await ServerSocket.bind(InternetAddress.anyIPv6, 12358).then(
      //
      (server) => server.listen(
        (socket) => socket.listen(
          //
          (Uint8List data) async {
            switch (String.fromCharCodes(data)) {
              case 'outbox':
                socket.write(await _instance.outbox);
                break;
              case 'followers':
                socket.write(await _instance.followers);
                break;
              case 'following':
                socket.write(await _instance.following);
                break;
              default:
                _instance.binding = socket.remoteAddress;
                break;
            }
          },
          onError: (err) async {
            await socket.close();
          },
          onDone: () async {
            await socket.close();
          },
        ),
        onError: (err) async {
          await server.close();
        },
        onDone: () async {
          await server.close();
        },
      ),
    );
    return _instance;
  }
}
