import 'dart:io';

import 'package:app/widgets/routes/post.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewImage extends StatefulWidget {
  const PreviewImage(this.index, {super.key});

  final int index;

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  //
  PostCache get cache => context.read<PostCache>();
  PlatformFile? get file => cache.files?.elementAt(widget.index);

  @override
  Widget build(BuildContext context) => Stack(
        //
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image.file(
            File(file?.path ?? ''),
            fit: BoxFit.cover,
          ),
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => cache.delFile(file),
          ),
        ],
      );
}
