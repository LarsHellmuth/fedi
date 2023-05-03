import 'package:app/widgets/modules/button/row.dart';
import 'package:app/widgets/modules/input.dart';
import 'package:app/widgets/modules/preview_files.dart';
import 'package:app/widgets/modules/topbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  //
  const Post({super.key});
  static String get route => '/post';

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  //
  @override
  Widget build(BuildContext context) => Scaffold(
        //
        appBar: const TopBar(),
        body: Form(
          child: Column(
            verticalDirection: VerticalDirection.up,
            children: const [
              Expanded(flex: 1, child: ButtonRow()),
              Expanded(flex: 1, child: Input.story()),
              Expanded(flex: 1, child: Input.title()),
              Expanded(flex: 1, child: PreviewFiles()),
            ],
          ),
        ),
      );
}

class PostCache with ChangeNotifier {
  //
  final _files = <PlatformFile>{};
  Set<PlatformFile>? get files => _files.isEmpty ? null : _files;

  void addFile() async {
    List<PlatformFile>? list = await openFiles;
    if (list != null) {
      _files.addAll({...list});
      notifyListeners();
    }
  }

  void delFileAt(int index) {
    delFile(_files.elementAt(index));
  }

  void delFile(PlatformFile? file) {
    if (file != null) {
      _files.remove(file);
      notifyListeners();
    }
  }

  final _titleController = TextEditingController();
  final _storyController = TextEditingController();

  TextEditingController? get titleController =>
      _titleController.text.isEmpty ? null : _titleController;

  TextEditingController? get storyController =>
      _storyController.text.isEmpty ? null : _storyController;

  TextEditingController? setTextEditingController({required String of}) {
    return <String, TextEditingController?>{
      'title': _titleController..addListener(() => notifyListeners()),
      'story': _storyController..addListener(() => notifyListeners()),
    }[of];
  }
}

/// https://pub.dev/packages/file_picker
Future<List<PlatformFile>?> get openFiles async => FilePicker.platform
    .pickFiles(allowCompression: true, allowMultiple: true)
    .then((result) => result?.files);
