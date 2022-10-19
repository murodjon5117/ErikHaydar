import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/styles.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '+998 (##) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_F4F4F4,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
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
                        padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                  getTranslated('login', context),
                                  style: boldTitle,
                                  textAlign: TextAlign.center,
                                )),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              getTranslated('phone_number', context),
                              style: titleTextField,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              inputFormatters: [maskFormatter],
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length != 19) {
                                  return getTranslated('phone_number', context);
                                }
                                return null;
                              },
                  
                              controller: _phoneNumberController,
                              focusNode: _phoneNumberFocus,
                              keyboardType: TextInputType.number,
                              cursorColor: ColorResources.COLOR_PPIMARY,
                              decoration: InputDecoration(
                                filled: true,
                                hoverColor: ColorResources.COLOR_BLACK_GREY,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorResources.COLOR_PPIMARY,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorResources.COLOR_F4F4F4,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                    color: ColorResources.COLOR_BLACK_GREY),
                                errorStyle: errorTextStyle,
                                hintText: '+998 (',
                                fillColor: ColorResources.COLOR_F4F4F4,
                                alignLabelWithHint: true,
                                isDense: true,
                              ),
                              textInputAction: TextInputAction.next, //
                            ),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              getTranslated('password', context),
                              style: titleTextField,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.isEmpty) {
                                  return getTranslated('password', context);
                                }
                                return null;
                              },
                  
                              controller: _passwordController,
                              focusNode: _passwordFocus,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              cursorColor: ColorResources.COLOR_PPIMARY,
                              decoration: InputDecoration(
                                filled: true,
                                hoverColor: ColorResources.COLOR_BLACK_GREY,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorResources.COLOR_PPIMARY,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: ColorResources.COLOR_F4F4F4,
                                  ),
                                ),
                                hintStyle: const TextStyle(
                                    color: ColorResources.COLOR_BLACK_GREY),
                                errorStyle: errorTextStyle,
                                fillColor: ColorResources.COLOR_F4F4F4,
                                alignLabelWithHint: true,
                                isDense: true,
                              ),
                              textInputAction: TextInputAction.next, //
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            BaseUI().buttonsType(
                                TypeButton.filled, context, () {
                                  if(_formKey.currentState!.validate()){
                  
                                  }
                                }, getTranslated('enter', context)),
                            const SizedBox(
                              height: 10,
                            ),
                            BaseUI().buttonsType(TypeButton.text, context, () {},
                                getTranslated('register', context)),
                            const SizedBox(
                              height: 34,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
