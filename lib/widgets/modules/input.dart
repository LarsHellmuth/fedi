import 'package:app/widgets/routes/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Input extends StatefulWidget {
  ///
  const Input.title({super.key})
      : _labelText = 'title',
        _maxLength = 111,
        _maxLines = 3;

  const Input.story({super.key})
      : _labelText = 'story',
        _maxLength = 9999,
        _maxLines = 9999;

  final int _maxLines;
  final int _maxLength;
  final String _labelText;

  @override
  State<Input> createState() => _Input();
}

class _Input extends State<Input> {
  //
  PostCache get cache => context.watch<PostCache>();

  @override
  Widget build(BuildContext context) => TextFormField(
        //
        controller: cache.setTextEditingController(of: widget._labelText),
        textAlign: TextAlign.justify,
        maxLength: widget._maxLength,
        maxLines: widget._maxLines,
        minLines: 1,
        autocorrect: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20.0),
          labelText: widget._labelText,
          isDense: true,
        ),
      );
}
