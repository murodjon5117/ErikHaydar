import 'package:carousel_slider/carousel_slider.dart';
import 'package:erik_haydar/data/model/response/body/tarif_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/provider/user_data_provider.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/view/sceen/auth/login/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/base_ui.dart';

class Tarifs extends StatelessWidget {
  const Tarifs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            getTranslated('tariffs', context),
            style: boldTitle.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 18,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: 300.0,
              aspectRatio: 16 / 9,
              viewportFraction: 0.5,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
            ),
            items: value.tarifs.map((model) {
              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 15,
                        child: Container(
                            width: 219,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: ColorResources.COLOR_EBE9E9,
                                    blurRadius: 5.0,
                                    spreadRadius: 2.0,
                                    offset: Offset(2.0,
                                        2.0), // shadow direction: bottom right
                                  )
                                ],
                                color: ColorResources.COLOR_WHITE,
                                border: Border.all(
                                  color: ColorResources.COLOR_EBE9E9,
                                  style: BorderStyle.solid,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    Text(
                                      model.name ?? '',
                                      style: textButtonTextStyle.copyWith(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 20),
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount:
                                              model.activeItems?.length ?? 0,
                                          itemBuilder: (context, index) => Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(Images.check),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  model.activeItems?[index]
                                                          .name ??
                                                      '',
                                                  style: profileTitle.copyWith(
                                                      color: ColorResources
                                                          .COLOR_737373),
                                                ),
                                              ),
                                            ],
                                          ),
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
                                                  const SizedBox(
                                            height: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 10,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      child: BaseUI().buttonsType(
                                          model.activeTariffStatus == true
                                              ? TypeButton.tarifBorder
                                              : TypeButton.tarif,
                                          context, () {
                                        value.selectActiveTarif(model);
                                        _showBuyDialog(context, model);
                                      },
                                          getTranslated(
                                              model.activeTariffStatus == true
                                                  ? 'extension'
                                                  : 'purchase',
                                              context)),
                                    ))
                              ],
                            )),
                      ),
                      Positioned(
                          right: 0,
                          top: 5,
                          child: model.isPremium == 1
                              ? Container(
                                  width: 35,
                                  height: 35,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                          color: ColorResources.COLOR_EBE9E9,
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0,
                                          // shadow direction: bottom right
                                        )
                                      ],
                                      color: ColorResources.COLOR_WHITE,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Image.asset(Images.premium))
                              : const SizedBox())
                    ],
                  );
                },
              );
            }).toList(),
          ),
          const SizedBox(
            height: 42,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<UserDataProvider>(context, listen: false)
                  .deleteUserData();
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return const LoginScreen();
                  },
                ),
                (_) => false,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(Images.logout),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  getTranslated('exit', context),
                  style: textButtonTextStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(getTranslated('company_name', context), style: profileTitle),
              const SizedBox(
                width: 8,
              ),
              Text(
                'ITeach Soft',
                style:
                    titleTextField.copyWith(color: ColorResources.COLOR_BLACK),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }

  _showBuyDialog(BuildContext context, TarifModel model) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Consumer<ProfileProvider>(
            builder: (context, value, child) => Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.buyTarif),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          getTranslated('buy_tarif', context),
                          style: boldTitle.copyWith(
                              fontSize: Dimensions.FONT_SIZE_24),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          getTranslated('selectTarif', context),
                          style: titleTextField,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorResources.COLOR_WHITE,
                              border: Border.all(
                                color: ColorResources.COLOR_E2E2E5,
                                style: BorderStyle.solid,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 0),
                                  color: ColorResources.COLOR_F7F7F9,
                                  child: DropdownButton<String>(
                                    alignment: AlignmentDirectional.center,
                                    value: value.selectedActiveItem,
                                    icon: SvgPicture.asset(Images.prefix_icon),
                                    elevation: 16,
                                    style: profileNumber,
                                    underline: const SizedBox(),
                                    onChanged: (String? item) {
                                      value.selectActiveItemTarif(item ?? '');
                                    },
                                    items: value.activeItemString
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: profileNumber,
                                          textAlign: TextAlign.center,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const VerticalDivider(
                                color: ColorResources.COLOR_E2E2E5,
                                thickness: 1,
                              ),
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 10),
                                    child: Text(
                                      value.getPriceOfTarif(
                                          value.selectedActiveItem),
                                      style: profileNumber,
                                    ),
                                  ))),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: BaseUI().buttonsType(
                                    TypeButton.cancel, context, () {
                                  Navigator.pop(context);
                                }, getTranslated('exitt', context))),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                flex: 1,
                                child: BaseUI().buttonsType(
                                    TypeButton.filled, context, () {
                                  value.buyTarif().then((result) {
                                    if (result.status == 200) {
                                      _showSuccessDialog(context);
                                    }
                                  });
                                }, getTranslated('purchase', context))),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showSuccessDialog(BuildContext context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Consumer<ProfileProvider>(
            builder: (context, value, child) => Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.successDialog),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          getTranslated('conguratulation', context),
                          style: boldTitle.copyWith(
                              fontSize: Dimensions.FONT_SIZE_24),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(getTranslated('success_buyed', context)),
                        const SizedBox(
                          height: 24,
                        ),
                        BaseUI().buttonsType(TypeButton.filled, context, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        }, getTranslated('understand', context)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
