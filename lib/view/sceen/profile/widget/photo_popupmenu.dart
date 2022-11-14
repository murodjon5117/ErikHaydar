import 'package:erik_haydar/data/model/response/body/info_model.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/profile/change_phone/edit_phone_number_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../util/images.dart';
import '../../../../util/route.dart';

class PhotoAndPopupMenu extends StatelessWidget {
  final UserInfoModelProfile userinfo;

  const PhotoAndPopupMenu({super.key, required this.userinfo});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: SizedBox(
        width: double.infinity,
        height: 110,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: SvgPicture.asset(Images.user_photo)
                  // : SizedBox(
                  //   height: 110,
                  //   width: 110,
                  //   child: CircleAvatar(
                  //       radius: 100,
                  //       child: BaseUI().imageNetwork(userinfo.img ?? '')),
                  // ),
            ),
            Positioned(
                right: 0,
                child: PopupMenuButton(
                  icon: SvgPicture.asset(Images.menu_image),
                  onSelected: (value) {
                    if (value == Options.phoneNumber.index) {
                      Navigator.of(
                        context,
                        rootNavigator: true,
                      ).push(createRoute(EditPhoneNumber()));
                    } else if (value == Options.userInfo.index) {
                    } else if (value == Options.password.index) {
                    } else {}
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    ),
                  ),
                  itemBuilder: (ctx) => [
                    _buildPopupMenuItem('Telefon raqamini tahrirlash',
                        Images.phone, Options.phoneNumber.index),
                    _buildPopupMenuItem('Shaxsiy ma’lumotlarni tahrirlash',
                        Images.edit, Options.userInfo.index),
                    _buildPopupMenuItem('Parolni almashtirish', Images.key,
                        Options.password.index),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, String image, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(image),
          const SizedBox(
            width: 12,
          ),
          Expanded(child: Text(title)),
        ],
      ),
    );
  }
}

enum Options { phoneNumber, userInfo, password }
