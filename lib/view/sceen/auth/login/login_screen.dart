import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/provider/login_provider.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/route.dart';
import '../../../../util/styles.dart';
import '../../../base/custom_text_field.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String deviceToken = '';
  String deviceId = '';
  String deviceName = '';
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    initPlatformState();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (ctx, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        body: AbsorbPointer(
          absorbing: value.isLoading,
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  child: Stack(
                    children: [
                      Image.asset(
                          width: double.infinity,
                          fit: BoxFit.fill,
                          Images.login_image),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Wrap(
                    children: [
                      Form(
                        key: _formKey,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: ColorResources.COLOR_WHITE,
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 34,
                                ),
                                SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      getTranslated('login', context),
                                      style: boldTitle,
                                      textAlign: TextAlign.center,
                                    )),
                                const SizedBox(
                                  height: 24,
                                ),
                                CustomTextField(
                                    title:
                                        getTranslated('phone_number', context),
                                    hint: getTranslated(
                                        'hint_phone_number', context),
                                    controller: _phoneNumberController,
                                    focusNode: _phoneNumberFocus,
                                    type: TextFieldType.phone),
                                const SizedBox(
                                  height: 18,
                                ),
                                CustomTextField(
                                    title: getTranslated('password', context),
                                    hint:
                                        getTranslated('hint_password', context),
                                    controller: _passwordController,
                                    focusNode: _passwordFocus,
                                    type: TextFieldType.password),
                                const SizedBox(
                                  height: 24,
                                ),
                                value.isLoading
                                    ? BaseUI().progressIndicator()
                                    : BaseUI().buttonsType(
                                        TypeButton.filled, context, () {
                                        if (_formKey.currentState!.validate()) {
                                          if (Platform.isAndroid) {
                                            deviceName = _deviceData['model'];
                                            deviceId = _deviceData['id'];
                                          } else if (Platform.isIOS) {
                                            deviceName = _deviceData['name'];
                                            deviceId = _deviceData[
                                                'identifierForVendor'];
                                          }
                                          value
                                              .login(
                                                  _phoneNumberController.text
                                                      .replaceAll(' ', '')
                                                      .replaceAll(')', '')
                                                      .replaceAll('(', '')
                                                      .replaceAll('-', ''),
                                                  _passwordController.text,
                                                  deviceId,
                                                  deviceName,
                                                  deviceToken,
                                                  context)
                                              .then((result) {
                                            if (result.status == 200) {
                                              Navigator.of(
                                                context,
                                                rootNavigator: true,
                                              ).push(createRoute(
                                                  DashBoardScreen()));
                                            }
                                          });
                                        }
                                      }, getTranslated('enter', context)),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).push(createRoute(RegisterScreen()));
                                    },
                                    child: Text(
                                      'text',
                                      style: filledButtonTextStyle,
                                    )),
                                // BaseUI().buttonsType(TypeButton.text, context,
                                //     () {
                                //   // Navigator.of(
                                //   //   context,
                                //   //   rootNavigator: true,
                                //   // ).push(createRoute(RegisterScreen()));
                                // }, ''),
                                const SizedBox(
                                  height: 34,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
