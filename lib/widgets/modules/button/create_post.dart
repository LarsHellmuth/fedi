import 'package:app/core/user.dart';
import 'package:app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostButton extends StatelessWidget {
  const PostButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(99.99)),
      child: BackdropFilter(
        filter: blur,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => context.read<User>(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
