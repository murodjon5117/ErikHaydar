import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  final String? title;

  final String? description;

  final String? imageAsset;

  final TextStyle? textStyle;

  final Color headerBgColor;

  final EdgeInsets headerPadding;

  final Widget? header;

  int? _pageIndex;

  IntroScreen({
    super.key,
    required String this.title,
    this.headerPadding = const EdgeInsets.all(12),
    required String this.description,
    this.header,
    this.headerBgColor = Colors.white,
    this.textStyle,
    this.imageAsset,
  });

  set index(val) => _pageIndex = val;

  @override
  Widget build(BuildContext context) {
    //var screenSize = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Image.asset(
          imageAsset!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 440,
        )
      ],
    );
  }
}
