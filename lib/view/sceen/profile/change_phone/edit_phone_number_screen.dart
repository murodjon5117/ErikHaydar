import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPhoneNumber extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final FocusNode _newPhoneFocus = FocusNode();
  final TextEditingController _newPhone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        appBar: BaseUI().appBar(context),
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 20,
              left: 20,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getTranslated('edit_phone_number', context),
                      style:
                          boldTitle.copyWith(fontSize: Dimensions.FONT_SIZE_24),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getTranslated('phone_number', context),
                          style: profileNumber.copyWith(
                              color: ColorResources.COLOR_BBB5B5),
                        ),
                        Text(
                          value.userInfo.username ?? '',
                          style: profileNumber,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    CustomTextField(
                        title: getTranslated('new_phone_number', context),
                        hint: getTranslated('new_phone_number', context),
                        controller: _newPhone,
                        focusNode: _newPhoneFocus,
                        type: TextFieldType.phone)
                  ],
                ),
              ),
            ),
            Positioned(
                left: 20,
                right: 20,
                bottom: 40,
                child: BaseUI().buttonsType(TypeButton.filled, context, () {},
                    getTranslated('confirm', context)))
          ],
        ),
      ),
    );
  }
}
