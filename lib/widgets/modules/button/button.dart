import 'package:app/widgets/routes/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Button extends StatefulWidget {
  ///
  const Button.add({super.key})
      : _icon = const Icon(Icons.attach_file_rounded),
        _event = 'add';

  const Button.post({super.key})
      : _icon = const Icon(Icons.done_rounded),
        _event = 'post';

  const Button.close({super.key})
      : _icon = const Icon(Icons.close_rounded),
        _event = 'close';

  final Icon _icon;
  final String _event;

  @override
  State<Button> createState() => _Button();
}

class _Button extends State<Button> {
  //
  PostCache get cache => context.read<PostCache>();

  void checkForNull(Map<String, String?> row) {
    if (row.values.every((val) => val == null)) return;
    /* context.read<Outbox>().insert(row); */
  }

  @override
  Widget build(BuildContext context) => IconButton(
        //
        icon: widget._icon,
        onPressed: () {
          switch (widget._event) {
            case 'add':
              return cache.addFile();
            case 'post':
              null
                  /* checkForNull(
                {
                  'title': cache.titleController?.text,
                  'story': cache.storyController?.text,
                  'files': cache.files?.toString(),
                },
              ) */
                  ;
              return Navigator.pop(context);
            case 'close':
              return Navigator.pop(context);
            default:
              throw Exception('Missing button event!');
          }
        },
      );
}
