import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:erik_haydar/localization/language_constrants.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/profile/settings/devices.dart';
import 'package:erik_haydar/view/sceen/profile/settings/support.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<ItemList> list = [
    ItemList(Images.language, 'language', true),
    ItemList(Images.phoneSetting, 'support', false),
    ItemList(Images.smartphone, 'devices', false),
  ];
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  @override
  void initState() {
    initPlatformState();
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              getTranslated('options', context),
              style: detailTitle.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 18,
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ColorResources.COLOR_EBE9E9, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      minLeadingWidth: 0,
                      leading: SvgPicture.asset(list[index].icon),
                      trailing: SvgPicture.asset(Images.right),
                      onTap: () {
                        switch (index) {
                          case 0:
                            break;
                          case 1:
                            pushNewScreen(context,
                                screen: const Support(), withNavBar: false);
                            break;
                          case 2:
                            pushNewScreen(context,
                                screen: Devices(
                                  deviceId: deviceId(),
                                ),
                                withNavBar: false);

                            break;
                        }
                      },
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            getTranslated(list[index].title, context),
                            style: profileNumber,
                          ),
                          list[index].isLangugae
                              ? Text(
                                  'O’zbekcha',
                                  style: profileNumber.copyWith(
                                      color: ColorResources.COLOR_737373),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 18,
                    ),
                itemCount: list.length),
          ],
        ),
      ),
    );
  }

  String deviceId() {
    String deviceId = '';
    if (Platform.isAndroid) {
      deviceId = _deviceData['id'];
    } else if (Platform.isIOS) {
      deviceId = _deviceData['identifierForVendor'];
    }
    return deviceId;
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

class ItemList {
  String icon;
  String title;
  bool isLangugae;

  ItemList(this.icon, this.title, this.isLangugae);
}
