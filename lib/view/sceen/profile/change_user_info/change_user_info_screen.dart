import 'dart:io';

import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_text_field.dart';

class ChangeUserInfo extends StatefulWidget {
  const ChangeUserInfo({super.key});

  @override
  State<ChangeUserInfo> createState() => _ChangeUserInfoState();
}

class _ChangeUserInfoState extends State<ChangeUserInfo> {
  final _formKey = GlobalKey<FormState>();

  final FocusNode _nameFocus = FocusNode();
  TextEditingController _nameController = TextEditingController();
  final FocusNode _surNameFocus = FocusNode();
  TextEditingController _surNameController = TextEditingController();

  @override
  void initState() {
    _nameController = TextEditingController();
    _surNameController = TextEditingController();
    _nameController.text = Provider.of<ProfileProvider>(context, listen: false)
            .userInfo
            .firstname ??
        '';
    _surNameController.text =
        Provider.of<ProfileProvider>(context, listen: false)
                .userInfo
                .lastname ??
            '';
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surNameController.dispose();
    super.dispose();
  }

  File? image;
  final picker = ImagePicker();
  void _choose() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      }
    });
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
                              height: 29,
                            ),
                            _setPhoto(value),
                            const SizedBox(
                              height: 13,
                            ),
                            CustomTextField(
                                title: getTranslated('name', context),
                                hint: getTranslated('hint_name', context),
                                controller: _nameController,
                                focusNode: _nameFocus,
                                type: TextFieldType.text),
                            CustomTextField(
                                title: getTranslated('surname', context),
                                hint: getTranslated('hint_surname', context),
                                controller: _surNameController,
                                focusNode: _surNameFocus,
                                type: TextFieldType.text),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              getTranslated('gender', context),
                              style: titleTextField,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 1,
                                    child: BaseUI().buttonsType(
                                        value.genderId == 5
                                            ? TypeButton.filled
                                            : TypeButton.border,
                                        context, () {
                                      value.setGender(5);
                                    }, 'Erkak')),
                                const SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                    flex: 1,
                                    child: BaseUI().buttonsType(
                                        value.genderId == 5
                                            ? TypeButton.border
                                            : TypeButton.filled,
                                        context, () {
                                      value.setGender(6);
                                    }, 'Ayol')),
                              ],
                            ),
                            const SizedBox(
                              height: 60,
                            ),
                            BaseUI().buttonsType(TypeButton.filled, context,
                                () {
                              if (_formKey.currentState!.validate()) {
                                value
                                    .updateUserInfo(_nameController.text,
                                        _surNameController.text, image)
                                    .then((result) {
                                  if (result.status == 200) {
                                    _showSuccessDialog(context);
                                    value.getUserInfo();
                                  }
                                });
                              }
                            }, getTranslated('save', context))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
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
                        Text(getTranslated('success_user_info', context)),
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

  Widget _setPhoto(ProfileProvider value) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 85,
            height: 85,
            child: Stack(
              children: [
                Material(
                  elevation: 0,
                  shape: const CircleBorder(),
                  child: GestureDetector(
                    onTap: () {},
                    child: CircleAvatar(
                      backgroundColor: ColorResources.COLOR_WHITE,
                      radius: 45.0,
                      child: image == null
                          ? SvgPicture.asset(Images.userPhoto)
                          : ClipOval(
                              child: Image.file(image!,
                                  width: 85, height: 85, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                        onTap: () {
                          _choose();
                        },
                        child: SvgPicture.asset(Images.plus)))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
