import 'package:erik_haydar/helper/enums/button_enum.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/register_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/auth/register/full_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import '../../../../util/styles.dart';

class SmsScreen extends StatefulWidget {
  final String phoneNumber;
  const SmsScreen({super.key, required this.phoneNumber});

  @override
  State<SmsScreen> createState() => _SmsScreenState();
}

class _SmsScreenState extends State<SmsScreen>
    with SingleTickerProviderStateMixin {
  bool validator = false;
  AnimationController? _animationController;
  OtpFieldController otpController = OtpFieldController();
  String _otpCode = '';

  @override
  void initState() {
    _otpCode = '';
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 60));

    _animationController!.forward();
    super.initState();
  }

  @override
  void dispose() {
    _otpCode = '';
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        appBar: BaseUI().appBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.phoneNumber
                          .replaceAll('(', '')
                          .replaceAll(')', ''),
                      style: boldTitlePhone,
                    ),
                    Text(
                      getTranslated('send_sms', context),
                      style: boldTitlePhoneSub,
                    )
                  ],
                ),
              ),
              Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        getTranslated('enter_code', context),
                        style: filledButtonTextStyle.copyWith(
                            color: ColorResources.COLOR_BLACK),
                      ),
                      const SizedBox(
                        height: 23,
                      ),
                      SizedBox(
                        height: 40,
                        child: OTPTextField(
                            controller: otpController,
                            length: 5,
                            spaceBetween: 0,
                            hasError: validator,
                            isDense: false,
                            otpFieldStyle: OtpFieldStyle(
                                borderColor: ColorResources.COLOR_009C10,
                                errorBorderColor: ColorResources.COLOR_RED,
                                backgroundColor: ColorResources.COLOR_F4F4F4,
                                enabledBorderColor: ColorResources.COLOR_F4F4F4,
                                focusBorderColor: ColorResources.COLOR_737373),
                            width: MediaQuery.of(context).size.width * 2 / 3,
                            textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldWidth: 40,
                            fieldStyle: FieldStyle.box,
                            outlineBorderRadius: 4,
                            style: filledButtonTextStyle.copyWith(
                                color: ColorResources.COLOR_BLACK),
                            onChanged: (pin) {
                              setState(() {
                                if (pin.length == 5) {
                                  validator = false;
                                } else {
                                  validator = true;
                                }
                              });
                            },
                            onCompleted: (pin) {
                              setState(() {
                                _otpCode = pin;
                              });
                            }),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Countdown(
                        animation: StepTween(
                          begin: 60,
                          end: 0,
                        ).animate(_animationController!),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 40,
                  left: 0,
                  right: 0,
                  child: BaseUI().buttonsType(TypeButton.filled, context, () {
                    if (_otpCode.length == 5) {
                      value
                          .verifyPhone(widget.phoneNumber, _otpCode)
                          .then((result) {
                        if (result.status == 200) {
                          pushNewScreen(context,
                              screen: FullRegisterScreen(
                                code: _otpCode,
                                phone: widget.phoneNumber,
                              ),
                              pageTransitionAnimation:
                                  PageTransitionAnimation.fade);
                        } else {
                          setState(() {
                            validator = true;
                          });
                        }
                      });
                    } else {
                      setState(() {
                        validator = true;
                      });
                    }
                  }, getTranslated('confirm', context))),
            ],
          ),
        ),
      ),
    );
  }
}

class Countdown extends AnimatedWidget {
  Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    if (timerText == '0:00') {
      print(timerText);
    }
    return Text(
      timerText,
      style: filledButtonTextStyle.copyWith(color: ColorResources.COLOR_BLACK),
    );
  }
}
