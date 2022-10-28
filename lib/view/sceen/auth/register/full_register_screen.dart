import 'dart:io';

import 'package:erik_haydar/view/sceen/profile/profile_acreen.dart';
import 'package:image_picker/image_picker.dart';

import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/register_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../util/route.dart';
import '../../dashboard_screen.dart';

class FullRegisterScreen extends StatefulWidget {
  final String phone;
  final String code;

  const FullRegisterScreen(
      {super.key, required this.phone, required this.code});
  @override
  State<FullRegisterScreen> createState() => _FullRegisterScreenState();
}

class _FullRegisterScreenState extends State<FullRegisterScreen> {
  final _formKey = GlobalKey<FormState>();

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
  void initState() {
    Provider.of<RegisterProvider>(context, listen: false).getCities(context);
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
      builder: (p0, p1) => Consumer<RegisterProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: ColorResources.COLOR_WHITE,
          body: AbsorbPointer(
            absorbing: value.isLoading,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minHeight: p1.maxHeight, minWidth: p1.maxWidth),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    _title(),
                    SizedBox(
                      width: p1.maxWidth,
                      height: p1.maxHeight,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 80,
                            left: 0,
                            right: 0,
                            child: Form(
                              key: _formKey,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      const BoxShadow(
                                        color:
                                            ColorResources.APPBAR_HEADER_COL0R,
                                        blurRadius: 8.0,
                                        spreadRadius: 5.0,
                                        offset: Offset(4.0,
                                            4.0), // shadow direction: bottom right
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomTextField(
                                          title: getTranslated('name', context),
                                          hint: getTranslated(
                                              'hint_name', context),
                                          controller: _nameController,
                                          focusNode: _nameFocus,
                                          type: TextFieldType.text),
                                      CustomTextField(
                                          title:
                                              getTranslated('surname', context),
                                          hint: getTranslated(
                                              'hint_surname', context),
                                          controller: _surNameController,
                                          focusNode: _surNameFocus,
                                          type: TextFieldType.text),
                                      CustomTextField(
                                          title: getTranslated('date', context),
                                          hint: getTranslated(
                                              'hint_date', context),
                                          controller: _dateController,
                                          focusNode: _dateFocus,
                                          type: TextFieldType.text),
                                      CustomTextField(
                                          title: getTranslated('city', context),
                                          hint: getTranslated(
                                              'hint_city', context),
                                          controller: _cityController,
                                          focusNode: _cityFocus,
                                          onTap: () {
                                            selectCity(value);
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
                                      CustomTextField(
                                          title: getTranslated(
                                              'password', context),
                                          hint: getTranslated(
                                              'hint_password', context),
                                          controller: _passwordController,
                                          focusNode: _passwordFocus,
                                          type: TextFieldType.password),
                                      CustomTextField(
                                          title: getTranslated(
                                              'repeat_password', context),
                                          hint: getTranslated(
                                              'hint_password', context),
                                          controller: _repeatPasswordController,
                                          focusNode: _repeatPasswordFocus,
                                          type: TextFieldType.password),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      BaseUI().buttonsType(
                                          TypeButton.filled, context, () {
                                        if (_formKey.currentState!.validate()) {
                                          value
                                              .savePhoto(
                                                  context,
                                                  image,
                                                  widget.phone,
                                                  widget.code,
                                                  _nameController.text,
                                                  _surNameController.text,
                                                  _passwordController.text,
                                                  _repeatPasswordController
                                                      .text,
                                                  _dateController.text,
                                                  '121212122',
                                                  'deviceName',
                                                  'deviceToken')
                                              .then((result) {
                                            if (result == true) {
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).push(createRoute(
                                                  ProfileScreen()));
                                            }
                                          });
                                        }
                                      }, getTranslated('confirm', context))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              left: 0, top: 13, right: 0, child: _setPhoto()),
                          value.isLoading
                              ? BaseUI().progressIndicator()
                              : const SizedBox()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void selectCity(RegisterProvider value) {
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
                      itemCount: value.cityList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            value.cityList[index].nameUz ?? '',
                            style: contactInfo4Style,
                          ),
                          onTap: () {
                            value.setCity(value.cityList[index].id ?? 0);
                            _cityController.text =
                                value.cityList[index].nameUz ?? '';
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
    return Column(
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
                        ? SvgPicture.asset(Images.user_photo)
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
    );
  }
}
