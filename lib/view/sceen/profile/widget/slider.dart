import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../helper/enums/button_enum.dart';
import '../../../../util/color_resources.dart';
import '../../../../util/images.dart';
import '../../../../util/styles.dart';
import '../../../base/base_ui.dart';

class Carousel extends StatelessWidget {
  Carousel({super.key});
  List<String> tarifListItems = [
    'Lorem Ipsum is simply',
    'Lorem Ipsum is simply',
    'Lorem Ipsum is simply',
    'Lorem Ipsum is simplywgugwgduwgudw dw dhiw',
    'Lorem Ipsum is simply',
    'Lorem Ipsum is simply',
    'Lorem Ipsum is simply',
    'Lorem Ipsum is simply',
    'Lorem Ipsum is simply'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Text(
          'Tariflar',
          style: boldTitle.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 18,
        ),
        CarouselSlider(
          options: CarouselOptions(
            height: 289.0,
            aspectRatio: 16 / 9,
            viewportFraction: 0.5,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: 219,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    decoration: BoxDecoration(
                        boxShadow: [
                          const BoxShadow(
                            color: ColorResources.COLOR_EBE9E9,
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(
                                2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                        color: ColorResources.COLOR_WHITE,
                        border: Border.all(
                          color: ColorResources.COLOR_EBE9E9,
                          style: BorderStyle.solid,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              'Premium',
                              style: textButtonTextStyle.copyWith(
                                  fontWeight: FontWeight.w500),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  itemCount: tarifListItems.length,
                                  itemBuilder: (context, index) => Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(Images.check),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Text(
                                          tarifListItems[index],
                                          style: profileTitle.copyWith(
                                              color:
                                                  ColorResources.COLOR_737373),
                                        ),
                                      ),
                                    ],
                                  ),
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const SizedBox(
                                    height: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            left: 0,
                            right: 0,
                            bottom: 10,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: BaseUI().buttonsType(
                                  TypeButton.tarifBorder,
                                  context,
                                  () {},
                                  'Tasdiqlash'),
                            ))
                      ],
                    ));
              },
            );
          }).toList(),
        ),
        const SizedBox(
          height: 42,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Images.logout),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Akkauntdan chiqish',
              style: textButtonTextStyle,
            ),
          ],
        ),
        const SizedBox(
          height: 18,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Ishlab chiqdi', style: profileTitle),
            const SizedBox(
              width: 8,
            ),
            Text(
              'ITeach Soft',
              style: titleTextField.copyWith(color: ColorResources.COLOR_BLACK),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        )
      ],
    );
  }
}
