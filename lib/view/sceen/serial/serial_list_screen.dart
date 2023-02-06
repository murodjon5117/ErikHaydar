import 'package:erik_haydar/data/model/serial_season_model.dart';
import 'package:erik_haydar/data/model/serials_item_model.dart';
import 'package:erik_haydar/provider/serial_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/util/dimensions.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/util/styles.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';

import '../detail_film/detail_film_screen.dart';

class SerialListScreen extends StatefulWidget {
  final Seasons seasons;

  const SerialListScreen({super.key, required this.seasons});

  @override
  State<SerialListScreen> createState() => _SerialListScreenState();
}

class _SerialListScreenState extends State<SerialListScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<SerialProvider>(context, listen: false)
          .getSerialsItem(widget.seasons.slug ?? '', false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SerialProvider>(
        builder: (context, value, child) => NotificationListener(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent &&
                    value.isPaging()) {
                  value.getSerialsItem(widget.seasons.slug ?? '', true);
                }
                return true;
              },
              child: Stack(
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 20),
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 142,
                      crossAxisCount: 3,
                    ),
                    itemCount: value.serials.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 18),
                      child: ItemSerial(
                        item: value.serials[index],
                        index: index,
                      ),
                    ),
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
              ),
            ));

    // Center(child: Text(widget.seasons.name ?? ''));
  }
}

class ItemSerial extends StatelessWidget {
  final SerialsItems item;
  final int index;

  const ItemSerial({super.key, required this.item, required this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(context,
            withNavBar: false,
            screen: DetailFilmScreen(
                slug: item.slug ?? '', image: item.image ?? ''));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    height: 87,
                    child: BaseUI().imageNetwork(item.image)),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 30,
                    top: 30,
                    child: SvgPicture.asset(
                      Images.smallPlay,
                    ))
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            item.name ?? '',
            maxLines: 1,
            style:
                itemWidgetTextStyle.copyWith(fontSize: Dimensions.FONT_SIZE_16),
          )
        ],
      ),
    );
  }
}
