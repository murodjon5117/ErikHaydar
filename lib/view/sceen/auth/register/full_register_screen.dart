import 'dart:ui';

import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FullRegisterScreen extends StatefulWidget {
  @override
  State<FullRegisterScreen> createState() => _FullRegisterScreenState();
}

class _FullRegisterScreenState extends State<FullRegisterScreen> {
  final FocusNode _nameFocus = FocusNode();
  TextEditingController _nameController = TextEditingController();
  final FocusNode _surNameFocus = FocusNode();
  TextEditingController _surNameController = TextEditingController();
  final FocusNode _dateFocus = FocusNode();
  TextEditingController _dateController = TextEditingController();
  final FocusNode _cityFocus = FocusNode();
  TextEditingController _cityController = TextEditingController();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _repeatPasswordFocus = FocusNode();
  TextEditingController _repeatPasswordController = TextEditingController();
  List<String> citysList = [
    'Qoraqalpog‘iston Respublikasi',
    'Andijon viloyati',
    'Buxoro viloyati',
    'Jizzax viloyati',
    'Qashqadaryo viloyati'
  ];

  @override
  void initState() {
    _nameController = TextEditingController();
    _surNameController = TextEditingController();
    _dateController = TextEditingController();
    _cityController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surNameController.dispose();
    _dateController.dispose();
    _cityController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: p1.maxHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(
                  height: 50,
                ),
                _title(),
                _setPhoto(),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      boxShadow: [
                        const BoxShadow(
                          color: ColorResources.APPBAR_HEADER_COL0R,
                          blurRadius: 8.0,
                          spreadRadius: 5.0,
                          offset: Offset(
                              4.0, 4.0), // shadow direction: bottom right
                        )
                      ],
                      color: ColorResources.COLOR_WHITE,
                      border: Border.all(
                        color: ColorResources.COLOR_F4F4F4,
                        style: BorderStyle.solid,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0))),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        CustomTextField(
                            title: getTranslated('date', context),
                            hint: getTranslated('hint_date', context),
                            controller: _dateController,
                            focusNode: _dateFocus,
                            type: TextFieldType.text),
                        CustomTextField(
                            title: getTranslated('city', context),
                            hint: getTranslated('hint_city', context),
                            controller: _cityController,
                            focusNode: _cityFocus,
                            onTap: () {
                              selectCity();
                            },
                            type: TextFieldType.selected),
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
                                child: BaseUI().buttonsType(TypeButton.filled,
                                    context, () {}, 'Erkak')),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                flex: 1,
                                child: BaseUI().buttonsType(
                                    TypeButton.border, context, () {}, 'Ayol')),
                          ],
                        ),
                        CustomTextField(
                            title: getTranslated('password', context),
                            hint: getTranslated('hint_password', context),
                            controller: _passwordController,
                            focusNode: _passwordFocus,
                            type: TextFieldType.password),
                        CustomTextField(
                            title: getTranslated('repeat_password', context),
                            hint: getTranslated('hint_password', context),
                            controller: _repeatPasswordController,
                            focusNode: _repeatPasswordFocus,
                            type: TextFieldType.password),
                        const SizedBox(
                          height: 30,
                        ),
                        BaseUI().buttonsType(TypeButton.filled, context, () {},
                            getTranslated('confirm', context))
                      ],
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

  void selectCity() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15))),
        backgroundColor: Colors.white,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: SvgPicture.asset(Images.close_image)),
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: citysList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            citysList[index],
                            style: contactInfo4Style,
                          ),
                          onTap: () {
                            _cityController.text = citysList[index];
                            Navigator.of(context).pop();
                          },
                        );
                      }),
                )
              ],
            ),
          );
        });
  }

  Widget _title() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        getTranslated('enter_personal_data', context),
        style: boldTitlePhone.copyWith(
            fontSize: Dimensions.FONT_SIZE_24, height: 1.6),
      ),
    );
  }

  Widget _setPhoto() {
    return Stack(
      children: [
        CircleAvatar(
            radius: 45,
            backgroundColor: ColorResources.COLOR_WHITE,
            child: SvgPicture.asset(Images.user_photo)),
        Positioned(
            bottom: 0, right: 0, top: 0, child: SvgPicture.asset(Images.plus))
      ],
    );
  }
}
