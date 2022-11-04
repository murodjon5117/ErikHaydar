import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/images.dart';
import '../../../util/styles.dart';

class UserData {
  Widget padding(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        leading: SvgPicture.asset(Images.user_icon),
        title: const Text(
          'Salom ',
          style: textButtonTextStyle,
        ),
        subtitle: const Text(
          'Fakhriyor',
          style: staticWidgetsAppBarStyle,
        ),
        trailing: Wrap(
          children: [
            SvgPicture.asset(Images.notif_icon),
            const SizedBox(
              width: 30,
            ),
            SvgPicture.asset(Images.search_icon),
          ],
        ),
      ),
    );
  }
}
