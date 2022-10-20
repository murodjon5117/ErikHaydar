import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../util/color_resources.dart';
import '../../util/images.dart';
import '../../util/styles.dart';

class CustomTextField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextFieldType type;
  VoidCallback? onTap;

  CustomTextField(
      {super.key,
      required this.title,
      required this.hint,
      required this.controller,
      required this.focusNode,
      this.onTap,
      required this.type});

  @override
  Widget build(BuildContext context) {
    var maskFormatter = MaskTextInputFormatter(
        mask: '+998 (##) ###-##-##',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 18,
        ),
        Text(
          title,
          style: titleTextField,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          inputFormatters:
              (type == TextFieldType.phone) ? [maskFormatter] : null,
          validator: (value) {
            switch (type) {
              case TextFieldType.phone:
                if (value == null || value.isEmpty || value.length != 19) {
                  return hint;
                }
                return null;
              case TextFieldType.password:
                if (value == null || value.isEmpty) {
                  return hint;
                }
                return null;
              case TextFieldType.text:
                if (value == null || value.isEmpty) {
                  return hint;
                }
                return null;
              case TextFieldType.selected:
                if (value == null || value.isEmpty) {
                  return hint;
                }
                return null;
            }
          },
          controller: controller,
          readOnly: (type == TextFieldType.selected) ? true : false,
          focusNode: focusNode,
          onTap: onTap,
          keyboardType: _textInputType(),
          cursorColor: ColorResources.COLOR_PPIMARY,
          decoration: InputDecoration(
            filled: true,
            prefixIconConstraints: (type == TextFieldType.selected)
                ? const BoxConstraints(minHeight: 24, minWidth: 24)
                : const BoxConstraints(),
            prefixIcon: (type == TextFieldType.selected)
                ? SvgPicture.asset(
                    Images.prefix_icon,
                  )
                : null,
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
            hintStyle: TextStyle(color: _hintColor()),
            errorStyle: errorTextStyle,
            hintText: _hintText(),
            fillColor: ColorResources.COLOR_F4F4F4,
            alignLabelWithHint: true,
            isDense: true,
          ),
          textInputAction: TextInputAction.next, //
        ),
      ],
    );
  }

  Color _hintColor() {
    switch (type) {
      case TextFieldType.phone:
        return ColorResources.COLOR_4A4949;
      case TextFieldType.password:
        return ColorResources.COLOR_CFCBCB;
      case TextFieldType.text:
        return ColorResources.COLOR_CFCBCB;
      case TextFieldType.selected:
        return ColorResources.COLOR_4A4949;
    }
  }

  String _hintText() {
    switch (type) {
      case TextFieldType.phone:
        return '+998 (';
      case TextFieldType.password:
        return '';
      case TextFieldType.text:
        return hint;
      case TextFieldType.selected:
        return hint;
    }
  }

  TextInputType _textInputType() {
    switch (type) {
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.password:
        print(type);
        return TextInputType.visiblePassword;
      case TextFieldType.text:
        return TextInputType.text;
      case TextFieldType.selected:
        return TextInputType.text;
    }
  }
}

enum TextFieldType {
  phone("phone"),
  password("password"),
  text("text"),
  selected("select");

  final String type;

  const TextFieldType(this.type);

  factory TextFieldType.fromType(String type) {
    return values.firstWhere((element) => element.type == type);
  }
}
