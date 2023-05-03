import 'package:app/core/actor.dart';
import 'package:app/widgets/modules/button/create_post.dart';
import 'package:app/widgets/modules/topbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  //
  const Home({super.key});
  static String get route => '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  Actor get _app => context.watch<Actor>();

  @override
  Widget build(BuildContext context) => Scaffold(
        //
        floatingActionButton: const PostButton(),
        extendBodyBehindAppBar: true,
        appBar: const TopBar(),
        body: AnimatedBuilder(
          animation: _app,
          builder: (context, Widget? child) => Center(
            child: FutureBuilder(
              future: null,
              builder: (context, snapshot) => Center(
                child: Text('${snapshot.data}'),
              ),
            ),
          ),
        ),
      );
}
