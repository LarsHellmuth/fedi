import 'package:app/widgets/modules/preview_image.dart';
import 'package:app/widgets/routes/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewFiles extends StatefulWidget {
  const PreviewFiles({super.key});

  @override
  State<PreviewFiles> createState() => _PreviewFilesState();
}

class _PreviewFilesState extends State<PreviewFiles> {
  //
  PostCache get cache => context.watch<PostCache>();

  @override
  Widget build(BuildContext context) => ListView.builder(
        //
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: cache.files?.length ?? 0,
        itemBuilder: (context, index) => PreviewImage(index),
      );
}
