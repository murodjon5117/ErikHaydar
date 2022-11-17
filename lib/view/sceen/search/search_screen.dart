import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/color_resources.dart';
import '../../../util/images.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_WHITE,
      appBar: BaseUI().appBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextFormField(
              validator: (value) {

              },
              controller: _controller,
              readOnly: false,
              focusNode: _focusNode,
              keyboardType: TextInputType.text,
              cursorColor: ColorResources.COLOR_PPIMARY,
              decoration: InputDecoration(
                filled: true,
                prefixIconConstraints:
                    const BoxConstraints(minHeight: 20, minWidth: 20),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18,right: 12),
                  child: SvgPicture.asset(
                    Images.searchIcon,
                  ),
                ),
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
                hintStyle: const TextStyle(color: ColorResources.COLOR_GRAY_TEXT),
                fillColor: ColorResources.COLOR_F4F4F4,
                alignLabelWithHint: true,
                isDense: true,
              ),
              textInputAction: TextInputAction.next, //
            ),
          ],
        ),
      ),
    );
  }
}
