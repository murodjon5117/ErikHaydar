import 'package:erik_haydar/provider/register_provider.dart';
import 'package:erik_haydar/util/route.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:erik_haydar/view/sceen/auth/sms/sms_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/base_ui.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneNumberFocus = FocusNode();
  TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, value, child) => LayoutBuilder(
        builder: (p0, p1) => Scaffold(
          backgroundColor: ColorResources.COLOR_WHITE,
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                      width: double.infinity,
                      fit: BoxFit.contain,
                      Images.login_image),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 34,
                        ),
                        SizedBox(
                            width: double.infinity,
                            child: Text(
                              getTranslated('register', context),
                              style: boldTitle,
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(
                          height: 24,
                        ),
                        CustomTextField(
                            title: getTranslated('phone_number', context),
                            hint: getTranslated('hint_phone_number', context),
                            controller: _phoneNumberController,
                            focusNode: _phoneNumberFocus,
                            type: TextFieldType.phone),
                        const SizedBox(
                          height: 24,
                        ),
                        BaseUI().buttonsType(TypeButton.filled, context, () {
                          if (_formKey.currentState!.validate()) {
                            if (!mounted) return;
                            value
                                .enterPhone(
                              _phoneNumberController.text,
                            )
                                .then((result) {
                              if (result.status == 200) {
                                pushNewScreen(
                                  context,
                                  screen: SmsScreen(
                                    phoneNumber: _phoneNumberController.text,
                                  ),
                                );
                              }
                            });
                          }
                        }, getTranslated('register', context)),
                        const SizedBox(
                          height: 10,
                        ),
                        BaseUI().buttonsType(TypeButton.text, context, () {
                          Navigator.pop(context);
                        }, getTranslated('enter', context)),
                        const SizedBox(
                          height: 132,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
