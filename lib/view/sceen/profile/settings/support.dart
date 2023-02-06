import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/view/base/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/base_ui.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  final FocusNode focus = FocusNode();

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.COLOR_WHITE,
      appBar: BaseUI().appBar(context),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  getTranslated('support', context),
                  style: detailTitle.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, ',
                  style: textButtonTextStyle.copyWith(
                      color: ColorResources.COLOR_737373),
                ),
                const SizedBox(
                  height: 24,
                ),
                CustomTextField(
                    title: getTranslated('message', context),
                    hint: getTranslated('write_message', context),
                    controller: controller,
                    focusNode: focus,
                    type: TextFieldType.support),
                const SizedBox(
                  height: 18,
                ),
                BaseUI().buttonsType(TypeButton.filled, context, () {
                  if (formKey.currentState!.validate()) {
                    Provider.of<ProfileProvider>(context, listen: false)
                        .setSupport(controller.text.trim())
                        .then((value) {
                      if (value.status == 200) {
                        _showSuccessDialog(context, controller.text);
                      }
                    });
                  }
                }, getTranslated('send', context))
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showSuccessDialog(BuildContext context, String message) {
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
                          getTranslated('sent', context),
                          style: boldTitle.copyWith(
                              fontSize: Dimensions.FONT_SIZE_24),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          message,
                          maxLines: 3,
                        ),
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
}
