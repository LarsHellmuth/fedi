import 'package:app/core/actor.dart';
import 'package:app/core/federation.dart';
import 'package:app/shared/style.dart';
import 'package:app/widgets/routes/home.dart';
import 'package:app/widgets/routes/post.dart';
import 'package:app/widgets/routes/root.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

main() async {
  //
  Actor actor = await Federation.join();

  runApp(
    //
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Actor>(
          create: (context) => actor,
        ),
      ],
      child: MaterialApp(
        home: const Root(),
        routes: {
          Home.route: (context) => const Home(),
          Post.route: (context) => const Post(),
        },
        theme: appTheme,
      ),
    ),
  );
}
