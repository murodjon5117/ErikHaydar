import 'package:erik_haydar/provider/profile_provider.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../base/base_ui.dart';

class Devices extends StatefulWidget {
  final String deviceId;
  const Devices({super.key, required this.deviceId});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProfileProvider>(context, listen: false).getActiveDevices();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        appBar: BaseUI().appBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getTranslated('devices', context),
                style: detailTitle.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                '${getTranslated('count_devices', context)} ${Provider.of<ProfileProvider>(context, listen: false).userInfo.allowedDevicesCount}',
                style:
                    titleTextField.copyWith(color: ColorResources.COLOR_BLACK),
              ),
              const SizedBox(
                height: 18,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        decoration: BoxDecoration(
                            color: ColorResources.COLOR_F9F9F9,
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          trailing: value.deviceList[index].deviceId ==
                                  widget.deviceId
                              ? const SizedBox()
                              : IconButton(
                                  onPressed: () {
                                    _showDeleteDialog(
                                        value.deviceList[index].deviceName ??
                                            '',
                                        index);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: ColorResources.COLOR_PPIMARY,
                                  )),
                          leading: SvgPicture.asset(Images.activePhone),
                          title: Text(value.deviceList[index].deviceName ?? ''),
                          subtitle:
                              Text(value.deviceList[index].createdAt ?? ''),
                        ));
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 18,
                      ),
                  itemCount: value.deviceList.length)
            ],
          ),
        ),
      ),
    );
  }

  _showDeleteDialog(String deviceName, int index) {
    showDialog(
        barrierDismissible: true,
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
                    padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Images.activePhone),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          getTranslated('delete_device', context),
                          style: boldTitle.copyWith(
                              fontSize: Dimensions.FONT_SIZE_24),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                            '${getTranslated('delete_device', context)}: $deviceName'),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: BaseUI().buttonsType(
                                    TypeButton.cancel, context, () {
                                  Navigator.pop(context);
                                }, getTranslated('exitt', context))),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                                flex: 1,
                                child: BaseUI().buttonsType(
                                    TypeButton.filled, context, () {
                                  value
                                      .deleteDevice(
                                          value.deviceList[index].deviceId ??
                                              '')
                                      .then((result) {
                                    if (result.status == 200) {
                                      _showSuccessDialog();
                                      value.getActiveDevices();
                                    }
                                  });
                                }, getTranslated('delete', context))),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showSuccessDialog() {
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
                          getTranslated('conguratulation', context),
                          style: boldTitle.copyWith(
                              fontSize: Dimensions.FONT_SIZE_24),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(getTranslated('delete_success', context)),
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
