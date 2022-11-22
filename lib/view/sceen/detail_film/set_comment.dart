import 'package:erik_haydar/data/model/response/body/detail_fim_model.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/detail_film_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../util/color_resources.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class SetComment extends StatefulWidget {
  final int id;
  const SetComment({super.key, required this.id});

  @override
  State<SetComment> createState() => _SetCommentState();
}

class _SetCommentState extends State<SetComment> {
  TextEditingController _controller = TextEditingController();

  FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
            decoration: const BoxDecoration(
              color: ColorResources.COLOR_WHITE,
              boxShadow: [
                BoxShadow(
                  color: ColorResources.COLOR_EBE9E9,
                  blurRadius: 5.0,
                  spreadRadius: 3.0,
                )
              ],
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(16), topLeft: Radius.circular(16)),
            ),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      getTranslated('set_comment', context),
                      style: titleTextField.copyWith(
                          color: ColorResources.COLOR_BLACK),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _controller,
                      readOnly: false,
                      focusNode: _focusNode,
                      keyboardType: TextInputType.text,
                      cursorColor: ColorResources.COLOR_PPIMARY,
                      decoration: InputDecoration(
                        filled: true,
                        suffixIcon: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: SvgPicture.asset(Images.send),
                          onPressed: () {
                            Provider.of<FilmDetailProvider>(context,
                                    listen: false)
                                .setComment(_controller.text, widget.id)
                                .then((result) => {
                                      if (result.status == 200)
                                        {
                                          FocusScope.of(context).unfocus(),
                                          _controller.clear(),
                                        }
                                    });
                          },
                        ),
                        contentPadding: const EdgeInsets.only(left: 23),
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
                        hintStyle:
                            const TextStyle(color: ColorResources.COLOR_CFCBCB),
                        errorStyle: errorTextStyle,
                        hintText: getTranslated('write', context),
                        fillColor: ColorResources.COLOR_F4F4F4,
                        alignLabelWithHint: false,
                        isDense: false,
                      ),
                      textInputAction: TextInputAction.next, //
                    ),
                  ],
                ))));
  }
}
