import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:erik_haydar/data/model/response/body/films_category_model.dart';
import 'package:erik_haydar/provider/category_provider.dart';
import 'package:erik_haydar/view/sceen/home/film_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../util/color_resources.dart';

class ItemVideosScreen extends StatefulWidget {
  final Items item;

  const ItemVideosScreen({super.key, required this.item});

  @override
  State<ItemVideosScreen> createState() => _ItemVideosScreenState();
}

class _ItemVideosScreenState extends State<ItemVideosScreen> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false)
        .getFilmsCategoryPage(widget.item.slug ?? '');
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

  // final List<String> items = [
  //   'Barchasi',
  //   'Eng ko’p ko’rilganlar',
  //   'Eng so’ngi qo’shilganlarm',
  //   'Eng ko’p izoh yozilganlar',
  // ];
  // String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 18),
                  child: CustomDropdownButton2(
                    hint: 'Select Item',
                    
                    buttonWidth: 226,
                    dropdownWidth: 252,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorResources.COLOR_WHITE,
                      boxShadow: [
                        BoxShadow(
                          color: ColorResources.COLOR_BLACK.withOpacity(0.08),
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
                          color: ColorResources.COLOR_BLACK.withOpacity(0.08),
                          blurRadius: 3.0,
                          spreadRadius: 1.0,
                        )
                      ],
                    ),
                    dropdownItems: value.filterStringList,
                    value: value.currentFilterStringValue,
                    onChanged: (filter) {
                      setState(() {
                        value.setCurrentFilterValue(filter!);
                      });
                    },
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                      child: FilmItem(item: value.films[index]),
                    ),
                  ),
                ),
              ],
            )
        // ListView.builder(
        //   shrinkWrap: true,
        //   scrollDirection: Axis.vertical,
        //   itemCount: value.films.length,
        //   itemBuilder: (context, index) {
        //     return FilmItem(item: value.films[index]);
        //   },
        // ),
        );
  }
}
