import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  const Item(this.item, {super.key});

  final Map<String, Object?> item;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  //
  /* Outbox get table => context.read<Outbox>(); */

  @override
  Widget build(BuildContext context) => Container(
        //
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () => null /* table.delete(widget.item) */,
            ),
            Expanded(child: Text('${widget.item}')),
          ],
        ),
      );
}
