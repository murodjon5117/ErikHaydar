import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../util/color_resources.dart';
import '../../util/images.dart';
import '../../util/styles.dart';

class CustomTextField extends StatefulWidget {
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
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  DateTime selectedDate = DateTime.now();
  final textFieldFocusNode = FocusNode();
  bool _obscured = false;

  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

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
          widget.title,
          style: titleTextField,
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLines: widget.type == TextFieldType.support ? 7 : 1,
          inputFormatters:
              (widget.type == TextFieldType.phone) ? [maskFormatter] : null,
          validator: (value) {
            switch (widget.type) {
              case TextFieldType.phone:
                if (value == null || value.isEmpty || value.length != 19) {
                  return widget.hint;
                }
                return null;
              case TextFieldType.password:
                if (value == null || value.isEmpty) {
                  return widget.hint;
                }
                return null;
              case TextFieldType.text:
                if (value == null || value.isEmpty) {
                  return widget.hint;
                }
                return null;
              case TextFieldType.selected:
                if (value == null || value.isEmpty) {
                  return widget.hint;
                }
                return null;
              case TextFieldType.summa:
                if (value == null || value.isEmpty || value.length < 4) {
                  return widget.hint;
                }
                return null;
              case TextFieldType.selectDate:
                if (value == null || value.isEmpty) {
                  return widget.hint;
                }
                return null;
              case TextFieldType.support:
                if (value == null || value.isEmpty) {
                  return widget.hint;
                }
                return null;
            }
          },
          controller: widget.controller,
          readOnly: (widget.type == TextFieldType.selected ||
                  widget.type == TextFieldType.selectDate)
              ? true
              : false,
          focusNode: widget.focusNode,
          onTap: widget.onTap,
          obscureText: _obscured,
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: _textInputType(),
          cursorColor: ColorResources.COLOR_PPIMARY,
          decoration: InputDecoration(
            filled: true,
            prefixIconConstraints: (widget.type == TextFieldType.selected)
                ? const BoxConstraints(minHeight: 24, minWidth: 24)
                : const BoxConstraints(),
            prefixIcon: (widget.type == TextFieldType.selected)
                ? SvgPicture.asset(
                    Images.prefix_icon,
                  )
                : null,
            suffixIcon: widget.type == TextFieldType.password
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: GestureDetector(
                      onTap: _toggleObscured,
                      child: Icon(
                        _obscured
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                        size: 24,
                        color: ColorResources.COLOR_PPIMARY,
                      ),
                    ),
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
    switch (widget.type) {
      case TextFieldType.phone:
        return ColorResources.COLOR_4A4949;
      case TextFieldType.password:
        return ColorResources.COLOR_CFCBCB;
      case TextFieldType.text:
        return ColorResources.COLOR_CFCBCB;
      case TextFieldType.selected:
        return ColorResources.COLOR_4A4949;
      case TextFieldType.summa:
        return ColorResources.COLOR_CFCBCB;
      case TextFieldType.selectDate:
        return ColorResources.COLOR_CFCBCB;
      case TextFieldType.support:
        return ColorResources.COLOR_CFCBCB;
    }
  }

  String _hintText() {
    switch (widget.type) {
      case TextFieldType.phone:
        return '+998 (';
      case TextFieldType.password:
        return '';
      case TextFieldType.text:
        return widget.hint;
      case TextFieldType.selected:
        return widget.hint;
      case TextFieldType.summa:
        return '(120 000)';
      case TextFieldType.selectDate:
        return widget.hint;
      case TextFieldType.support:
        return widget.hint;
    }
  }

  TextInputType _textInputType() {
    switch (widget.type) {
      case TextFieldType.phone:
        return TextInputType.phone;
      case TextFieldType.password:
        return TextInputType.visiblePassword;
      case TextFieldType.text:
        return TextInputType.text;
      case TextFieldType.selected:
        return TextInputType.text;
      case TextFieldType.summa:
        return TextInputType.number;
      case TextFieldType.selectDate:
        return TextInputType.text;
      case TextFieldType.support:
        return TextInputType.text;
    }
  }
}

enum TextFieldType {
  phone,
  password,
  text,
  support,
  summa,
  selectDate,
  selected;
}
