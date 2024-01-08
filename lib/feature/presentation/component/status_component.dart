import 'package:flutter/material.dart';
import 'package:resident/core/extension/size_extension.dart';

class StatusComponent extends StatefulWidget {
  final String label;
  final Color color;

  const StatusComponent({Key? key, required this.label, required this.color})
      : super(key: key);

  @override
  State<StatusComponent> createState() => _StatusComponentState();
}

class _StatusComponentState extends State<StatusComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: widget.color),
      child: Text(
        widget.label.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(fontSize: 10.sf(context), color: Colors.white),
      ),
    );
  }
}
