// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:dotted_border/dotted_border.dart';

class Audio extends StatefulWidget {
  const Audio({
    Key? key,
    this.width,
    this.height,
    this.bcolor,
    required this.strokeWidth,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double strokeWidth;
  final Color? bcolor;

  @override
  _AudioState createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: DottedBorder(
        color: widget.bcolor ?? Colors.black, // Set the border color here
        strokeWidth: widget.strokeWidth,
        child: FlutterLogo(size: 148),
      ),
    );
  }
}
