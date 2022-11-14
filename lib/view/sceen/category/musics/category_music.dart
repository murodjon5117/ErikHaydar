import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/view/sceen/home/music/music_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';

class CategoryMusic extends StatefulWidget {
  @override
  State<CategoryMusic> createState() => _CategoryMusicState();
}

class _CategoryMusicState extends State<CategoryMusic> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false)
          .getCategoryMusics('slug', false);
    });

    super.initState();
  }

  final List<String> items = [
    'Barchasi',
    'Eng ko’p ko’rilganlar',
    'Eng so’ngi qo’shilganlarm',
    'Eng ko’p izoh yozilganlar',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, value, child) =>  Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 18, right: 20),
                        child: Row(
                          children: [
                            CustomDropdownButton2(
                              hint: 'Select Item',
                              buttonWidth: 226,
                              dropdownWidth: 252,
                              dropdownDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorResources.COLOR_WHITE,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResources.COLOR_BLACK
                                        .withOpacity(0.08),
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: ColorResources.COLOR_WHITE,
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorResources.COLOR_BLACK
                                        .withOpacity(0.08),
                                    blurRadius: 3.0,
                                    spreadRadius: 1.0,
                                  )
                                ],
                              ),
                              dropdownItems: items,
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: NotificationListener(
                          onNotification: _scrollNotification,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 8),
                              child: list(context, value)),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: value.isPagingLoading
                          ? const LinearProgressIndicator(
                              backgroundColor: ColorResources.COLOR_GREY,
                              color: ColorResources.COLOR_PPIMARY,
                              minHeight: 4,
                            )
                          : const SizedBox())
                ],
              ));
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        Provider.of<CategoryProvider>(context, listen: false).isPaging()) {
      Provider.of<CategoryProvider>(context, listen: false)
          .getCategoryMusics('', true);
    }
    return true;
  }

  Widget list(BuildContext context, CategoryProvider value) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: value.musics.length,
      itemBuilder: (context, index) {
        return MusicItem(musicModel: value.musics[index]);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 12,
        );
      },
    );
  }
}
