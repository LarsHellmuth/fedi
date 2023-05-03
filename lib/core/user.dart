import 'package:app/core/node.dart';

mixin User on Node {
  //
  Future<bool> get isSigned {
    return query(
      'SELECT username, password FROM federation WHERE relation = "me"'
      ' AND username IS NOT NULL'
      ' AND password IS NOT NULL;',
    ).then((query) => query.isNotEmpty);
  }

  Future<int> login({
    required String username,
    required String password,
  }) async {
    return update(
      'UPDATE federation SET'
      ' username = "$username",'
      ' password = "$password" '
      'WHERE relation = "me";',
    );
  }

  Future<int> logout() {
    return update(
      'UPDATE federation SET'
      ' username = NULL,'
      ' password = NULL '
      'WHERE relation = "me";',
    );
  }
}
