import 'package:erik_haydar/provider/home_provider.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/dimensions.dart';
import '../../../../util/styles.dart';
import '../../../base/base_ui.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeProvider>(context, listen: false).getNotification();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        appBar: BaseUI().appBar(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                getTranslated('notification', context),
                textAlign: TextAlign.start,
                style: boldTitlePhone.copyWith(
                    fontSize: Dimensions.FONT_SIZE_24, height: 1.6),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 26),
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            color: ColorResources.COLOR_FAFAFA,
                            borderRadius: BorderRadius.circular(8)),
                        child: ListTile(
                          leading: SvgPicture.asset(
                              value.notifList[index].typeId == 5
                                  ? Images.playMusic
                                  : Images.playVideoNotif),
                          title: Text(
                            value.notifList[index].title ?? '',
                            style: downloadTextStyle.copyWith(
                                color: ColorResources.COLOR_BLACK),
                          ),
                          isThreeLine: true,
                          subtitle: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(value.notifList[index].content ?? ''.trim()),
                              Align(
                                  alignment: AlignmentDirectional.topEnd,
                                  child: Text(
                                    value.notifList[index].createdAt ??
                                        ''.trim(),
                                    style: itemWidgetTextStyle,
                                    textAlign: TextAlign.right,
                                  )),
                            ],
                          ),
                        )
                        //  Row(
                        //   children: [
                        //     SvgPicture.asset(Images.play_icon),
                        //     const SizedBox(
                        //       width: 12,
                        //     ),
                        //     Column(
                        //       mainAxisSize: MainAxisSize.max,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           value.notifList[index].title ?? '',
                        //           style: downloadTextStyle.copyWith(
                        //               color: ColorResources.COLOR_BLACK),
                        //         ),
                        //         Text(value.notifList[index].content ?? ''.trim()),
                        //         Text(value.notifList[index].createdAt ??
                        //             ''.trim()),
                        //       ],
                        //     )
                        //   ],
                        // ),
                        );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 12,
                    );
                  },
                  itemCount: value.notifList.length),
            )
          ],
        ),
      ),
    );
  }
}
