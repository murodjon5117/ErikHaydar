import 'package:erik_haydar/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../util/images.dart';

class HomeCategoriesScreen extends StatelessWidget {
  const HomeCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 1, color: Colors.white, spreadRadius: 2)
        ],
        // color: Colors.red,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(24), topLeft: Radius.circular(24)),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 38),
              child: Text(
                "So’ngi yuklanganlar videolar",
                style: boldTitle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 201,
                width: 162,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(color: Colors.grey, spreadRadius: 3),
                  ],
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: 100,
                            width: 130,
                            child: Image.network(
                              'https://files.itv.uz/uploads/content/snapshots/2022/09/09/87a699002c9b1f395822df5a67ee7728-q-640x360.jpeg',
                            ),
                          ),
                        ),
                        const Flexible(
                            child: Text('data', style: titleTextField)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ListTile(
                                minLeadingWidth: 0,
                                contentPadding: EdgeInsets.zero,
                                leading: SvgPicture.asset(Images.eye_icon),
                                title: const Text(
                                  '1000',
                                  style: itemWidgetTextStyle,
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                minLeadingWidth: 0,
                                contentPadding: EdgeInsets.zero,
                                leading: SvgPicture.asset(Images.comment_icon),
                                title: const Text(
                                  '1000',
                                  style: itemWidgetTextStyle,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
    );
  }
}
