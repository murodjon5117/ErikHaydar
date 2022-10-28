import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/profile/widget/photo_popupmenu.dart';
import 'package:erik_haydar/view/sceen/profile/widget/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: ColorResources.COLOR_WHITE,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              profileProvider.getUserInfo(context);
            });
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PhotoAndPopupMenu(),
                    _userInfo(),
                    _tarif(),
                    _buttons(),
                    Carousel()
                  ],
                ),
                profileProvider.isLoading
                    ? Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: BaseUI().progressIndicator(),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _userInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'ID 12356',
            style: titleTextField,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Eshonov Fakhriyor',
            style: boldTitle.copyWith(fontSize: Dimensions.FONT_SIZE_24),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Telefon raqamingiz',
                style:
                    profileNumber.copyWith(color: ColorResources.COLOR_BBB5B5),
              ),
              Text(
                '+998 97 628 28 82',
                style: profileNumber,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _tarif() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_WHITE,
                      border: Border.all(
                        color: ColorResources.COLOR_EBE9E9,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        '100 000 UZS',
                        style:
                            profileNumber.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Sizning xisobingiz',
                        style: profileTitle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorResources.COLOR_WHITE,
                      border: Border.all(
                        color: ColorResources.COLOR_EBE9E9,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Premium',
                        style: profileNumber.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorResources.COLOR_PPIMARY),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Tarif',
                        style: profileTitle,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Muddati', style: profileTitle),
              SizedBox(
                width: 10,
              ),
              Text('10.10.2022 gacha'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          BaseUI().buttonsType(
              TypeButton.filledIcon, context, () {}, 'Hisobni to’ldirish'),
          const SizedBox(
            height: 24,
          ),
          BaseUI().buttonsType(
              TypeButton.downloaded, context, () {}, 'Yuklanganlar'),
          const SizedBox(
            height: 12,
          ),
          BaseUI()
              .buttonsType(TypeButton.settings, context, () {}, 'Sozlamalar'),
        ],
      ),
    );
  }
}
