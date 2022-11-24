import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_text_field.dart';

class ChangeUserPassword extends StatefulWidget {
  const ChangeUserPassword({super.key});

  @override
  State<ChangeUserPassword> createState() => _ChangeUserPasswordState();
}

class _ChangeUserPasswordState extends State<ChangeUserPassword> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _oldPasswordFocus = FocusNode();
  TextEditingController _oldPasswordController = TextEditingController();
  final FocusNode _newPasswordFocus = FocusNode();
  TextEditingController _newPasswordController = TextEditingController();
  final FocusNode _newRepeatPasswordFocus = FocusNode();
  TextEditingController _newRepeatPasswordController = TextEditingController();

  @override
  void initState() {
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _newRepeatPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _newRepeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        appBar: BaseUI().appBar(context),
        body: LayoutBuilder(
          builder: (p0, p1) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Positioned.fill(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: p1.maxHeight, minWidth: p1.maxWidth),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _title(),
                            const SizedBox(
                              height: 24,
                            ),
                            CustomTextField(
                                title: getTranslated(
                                    'input_old_password', context),
                                hint: getTranslated(
                                    'input_old_password', context),
                                controller: _oldPasswordController,
                                focusNode: _oldPasswordFocus,
                                type: TextFieldType.password),
                            CustomTextField(
                                title: getTranslated(
                                    'input_new_password', context),
                                hint: getTranslated(
                                    'input_new_password', context),
                                controller: _newPasswordController,
                                focusNode: _newPasswordFocus,
                                type: TextFieldType.password),
                            CustomTextField(
                                title: getTranslated(
                                    'input_new_password_repeat', context),
                                hint: getTranslated(
                                    'input_new_password_repeat', context),
                                controller: _newRepeatPasswordController,
                                focusNode: _newRepeatPasswordFocus,
                                type: TextFieldType.password),
                            const SizedBox(
                              height: 60,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: BaseUI().buttonsType(TypeButton.filled, context, () {
                    if (_formKey.currentState!.validate()) {
                      value
                          .updateUserPassword(
                              _oldPasswordController.text,
                              _newPasswordController.text,
                              _newRepeatPasswordController.text)
                          .then((result) {
                        if (result.status == 200) {
                          _showSuccessDialog(context);
                          value.getUserInfo();
                        }
                      });
                    }
                  }, getTranslated('save', context)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSuccessDialog(BuildContext context) {
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
                alignment: WrapAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.succesIcon),
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
                        Text(getTranslated('success_edit_password', context)),
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

  Widget _title() {
    return Text(
      getTranslated('edit_user_info', context),
      textAlign: TextAlign.start,
      style: boldTitlePhone.copyWith(
          fontSize: Dimensions.FONT_SIZE_24, height: 1.6),
    );
  }
}
