import 'package:app/widgets/modules/button/button.dart';
import 'package:flutter/material.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) => Padding(
        //
        padding: const EdgeInsets.all(20),
        child: Row(
          children: const [
            Button.add(),
            Button.close(),
            Button.post(),
          ],
        ),
      );
}
