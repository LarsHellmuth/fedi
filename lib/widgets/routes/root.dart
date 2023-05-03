import 'package:app/core/actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Root extends StatefulWidget {
  //
  const Root({super.key});
  static String get route => '/';

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  //
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Actor get _actor => context.read<Actor>();

  @override
  Widget build(BuildContext context) => Scaffold(
        //
        body: FutureBuilder(
          future: _actor.isSigned,
          builder: (context, snapshot) => snapshot.data == false
              //
              ? Column(
                  children: <Widget>[
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'username',
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'password',
                      ),
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _actor.login(
                            username: _usernameController.text,
                            password: _passwordController.text,
                          );
                        });
                      },
                      child: const Text('access'),
                    ),
                  ],
                )
              //
              : Center(
                  child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _actor.logout();
                    });
                  },
                  child: const Text('leave'),
                )),
        ),
      );
}
