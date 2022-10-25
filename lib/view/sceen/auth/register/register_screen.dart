import 'package:erik_haydar/provider/register_provider.dart';
import 'package:erik_haydar/util/route.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:erik_haydar/view/sceen/auth/sms/sms_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
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
    return 
    Consumer<RegisterProvider>(
      builder: (context, value, child) => LayoutBuilder(
        builder: (p0, p1) => Scaffold(
          backgroundColor: ColorResources.COLOR_F4F4F4,
          body: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: AbsorbPointer(
              absorbing: value.isLoading,
              child: Stack(
                children: [
                  Positioned(
                    top: 100,
                    child: Stack(
                      children: [
                        Text('Elmurod Haqnazarov'),
                        Text('Elmurod Haqnazarov'),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Wrap(
                      children: [
                        Form(
                          key: _formKey,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorResources.COLOR_WHITE,
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
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
                                      title: getTranslated(
                                          'phone_number', context),
                                      hint: getTranslated(
                                          'hint_phone_number', context),
                                      controller: _phoneNumberController,
                                      focusNode: _phoneNumberFocus,
                                      type: TextFieldType.phone),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  BaseUI().buttonsType(
                                      TypeButton.filled, context, () {
                                    if (_formKey.currentState!.validate()) {
                                      if (!mounted) return;
                                      value
                                          .enterPhone(
                                              _phoneNumberController.text,
                                              context)
                                          .then((result) {
                                        if (result.status == 200) {
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).push(createRoute(SmsScreen(phoneNumber: _phoneNumberController.text,)));
                                        }
                                      });
                                    }
                                  }, getTranslated('register', context)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  BaseUI().buttonsType(TypeButton.text, context,
                                      () {
                                    Navigator.pop(context);
                                  }, getTranslated('enter', context)),
                                  const SizedBox(
                                    height: 132,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  value.isLoading
                      ? BaseUI().progressIndicator()
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  
  }
}
