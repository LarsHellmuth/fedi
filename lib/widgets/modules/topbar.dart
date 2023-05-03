import 'package:app/shared/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  final Size preferredSize = const Size.fromHeight(kTextTabBarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(0.0)),
        child: BackdropFilter(
          filter: blur,
          child: ShaderMask(
            blendMode: BlendMode.xor,
            shaderCallback: (rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(1.0),
                  Colors.black.withOpacity(0.1),
                ],
                stops: const [0.1, 1.0],
              ).createShader(rect);
            },
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
