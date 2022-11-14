import 'package:erik_haydar/data/model/response/body/info_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/view/sceen/profile/widget/buttons.dart';
import 'package:erik_haydar/view/sceen/profile/widget/photo_popupmenu.dart';
import 'package:erik_haydar/view/sceen/profile/widget/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';
import '../../../util/styles.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
      Provider.of<ProfileProvider>(context, listen: false).getTarifs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {
                value.getUserInfo();
                value.getTarifs();
              });
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  PhotoAndPopupMenu(
                    userinfo: value.userInfo,
                  ),
                  _userInfo(value.userInfo),
                  _tarif(value.userInfo),
                  ProfileButtons(),
                  Carousel()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userInfo(UserInfoModelProfile userinfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Text(
            'ID ${userinfo.id}',
            style: titleTextField,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            '${userinfo.lastname} ${userinfo.firstname}',
            style: boldTitle.copyWith(fontSize: Dimensions.FONT_SIZE_24),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated('phone_number', context),
                style:
                    profileNumber.copyWith(color: ColorResources.COLOR_BBB5B5),
              ),
              Text(
                '${userinfo.username}',
                style: profileNumber,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _tarif(UserInfoModelProfile userinfo) {
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
                        userinfo.balance ?? '',
                        style:
                            profileNumber.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        getTranslated('your_balance', context),
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
                        userinfo.activeTariff ?? '',
                        style: profileNumber.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorResources.COLOR_PPIMARY),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        getTranslated('tarif', context),
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
              Text(getTranslated('expired_at', context), style: profileTitle),
              const SizedBox(
                width: 10,
              ),
              Text(userinfo.expiredAt ?? ''),
            ],
          )
        ],
      ),
    );
  }
}
