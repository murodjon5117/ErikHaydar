import 'package:flutter/material.dart';

class SavedOnesScreen extends StatefulWidget {
  const SavedOnesScreen({super.key});

  @override
  State<SavedOnesScreen> createState() => _SavedOnesScreenState();
}

class _SavedOnesScreenState extends State<SavedOnesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (p0, p1) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: p1.maxHeight,
              minWidth: p1.maxWidth,
            ),
            child: Column(),
          ),
        ),
      ),
    );
  }
}
