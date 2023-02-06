import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:erik_haydar/view/sceen/profile/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/base_ui.dart';

class ProfileButtons extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _summaFocus = FocusNode();
  final TextEditingController _summaCOntroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          BaseUI().buttonsType(TypeButton.filledIcon, context, () {
            _showPayDialog(context);
          }, getTranslated('pay', context)),
          const SizedBox(
            height: 24,
          ),
          BaseUI().buttonsType(TypeButton.downloaded, context, () {},
              getTranslated('downloads', context)),
          const SizedBox(
            height: 12,
          ),
          BaseUI().buttonsType(TypeButton.settings, context, () {
            pushNewScreen(context, screen: const SettingsScreen(), withNavBar: false);
          }, getTranslated('options', context)),
        ],
      ),
    );
  }

  _showPayDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Consumer<ProfileProvider>(
            builder: (context, value, child) => Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)), //this right here
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: SvgPicture.asset(Images.x))
                          ],
                        ),
                        Text(
                          getTranslated('pay', context),
                          style: boldTitle,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Text(
                          getTranslated('choose_pay', context),
                          style: titleTextField,
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: SizedBox(
                      height: 70,
                      child: Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: value.paymentList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              value.setSelected(value.paymentList[index].type);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: ColorResources.COLOR_WHITE,
                                  border: Border.all(
                                    color: value.paymentList[index].isSlected
                                        ? ColorResources.COLOR_PPIMARY
                                        : ColorResources.COLOR_E2E2E5,
                                    style: BorderStyle.solid,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 25),
                                child: SvgPicture.asset(
                                    value.paymentList[index].icon),
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                            width: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          CustomTextField(
                              title: getTranslated('set_summa', context),
                              hint: getTranslated('minimal_pay', context),
                              controller: _summaCOntroller,
                              focusNode: _summaFocus,
                              type: TextFieldType.summa),
                          const SizedBox(
                            height: 24,
                          ),
                          BaseUI().buttonsType(TypeButton.filled, context, () {
                            if (_formKey.currentState!.validate()) {
                              value.pay(_summaCOntroller.text).then((result) {
                                if (result.isNotEmpty) {
                                  launchUrlString(result);
                                }
                              });
                            }
                          }, getTranslated('switch_payment', context))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

enum PaymentType { payme, click, apelsin }
