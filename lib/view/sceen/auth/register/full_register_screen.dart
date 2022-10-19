import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FullRegisterScreen extends StatefulWidget {
  @override
  State<FullRegisterScreen> createState() => _FullRegisterScreenState();
}

class _FullRegisterScreenState extends State<FullRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                getTranslated('enter_personal_data', context),
                style:
                    boldTitlePhone.copyWith(fontSize: Dimensions.FONT_SIZE_24,height: 1.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
