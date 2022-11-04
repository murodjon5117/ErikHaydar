import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (p0, p1) => Scaffold(
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: p1.maxHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getTranslated('category', context),
                    style: boldTitlePhone.copyWith(
                        fontSize: Dimensions.FONT_SIZE_24),
                  ),
                  // DefaultTabController(length: 2, child: child)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
