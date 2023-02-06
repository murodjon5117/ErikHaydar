import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:erik_haydar/data/model/response/body/films_category_model.dart';
import 'package:erik_haydar/helper/enums/view_enum.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/view/sceen/home/film/film_grid_item.dart';
import 'package:erik_haydar/view/sceen/home/film/film_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';

class ItemVideosScreen extends StatefulWidget {
  final Items item;
  ItemVideosScreen({super.key, required this.item});

  @override
  State<ItemVideosScreen> createState() => _ItemVideosScreenState();
}

class _ItemVideosScreenState extends State<ItemVideosScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 200), () {
        Provider.of<CategoryProvider>(context, listen: false)
            .getFilmsCategoryPage(widget.item.slug ?? '', false);
      });
    });
    super.initState();
  }

  double isEvenLeft(int index) {
    if (index % 2 == 0) {
      return 20.0;
    } else {
      return 6.0;
    }
  }

  double isEvenRight(int index) {
    if (index % 2 == 0) {
      return 6.0;
    } else {
      return 20.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, value, child) => Stack(
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
                            hint: 'Saralash',
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
                            dropdownItems: value.filterStringList,
                            value: value.currentFilterStringValue,
                            onChanged: (result) {
                              value.setCurrentFilterValue(result ?? '');
                              value.getFilmsCategoryPage(
                                widget.item.slug ?? '',
                                false,
                              );
                            },
                          ),
                          const Spacer(),
                          GestureDetector(
                              onTap: () {
                                value.setView(value.view == ViewEnum.grid
                                    ? ViewEnum.list
                                    : ViewEnum.grid);
                              },
                              child: SvgPicture.asset(
                                  value.view == ViewEnum.grid
                                      ? Images.showGrid
                                      : Images.showList))
                        ],
                      ),
                    ),
                    Expanded(
                      child: NotificationListener(
                        onNotification: _scrollNotification,
                        child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 8),
                            child: value.view == ViewEnum.list
                                ? list(context, value)
                                : gridList(context, value)),
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
          .getFilmsCategoryPage(widget.item.slug ?? '', true);
    }
    return true;
  }

  Widget gridList(BuildContext context, CategoryProvider value) {
    return GridView.builder(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: 201,
        crossAxisCount: 2,
      ),
      itemCount: value.films.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
            top: 9,
            bottom: 9,
            left: isEvenLeft(index),
            right: isEvenRight(index)),
        child: FilmGridItem(item: value.films[index]),
      ),
    );
  }

  Widget list(BuildContext context, CategoryProvider value) {
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      itemCount: value.films.length,
      itemBuilder: (context, index) {
        return FilmListItem(
          item: value.films[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          height: 12,
        );
      },
    );
  }
}
