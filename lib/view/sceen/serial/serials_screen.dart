import 'package:erik_haydar/provider/serial_provider.dart';
import 'package:erik_haydar/util/color_resources.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class SerialsScreen extends StatefulWidget {
  final String slug;
  final String name;

  const SerialsScreen({super.key, required this.slug, required this.name});
  @override
  State<SerialsScreen> createState() => _SerialsScreenState();
}

class _SerialsScreenState extends State<SerialsScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FocusManager.instance.primaryFocus?.unfocus();
      Provider.of<SerialProvider>(context, listen: false)
          .getSerialSeason(widget.slug);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SerialProvider>(
      builder: (context, value, child) => DefaultTabController(
        length: value.seasonList.length,
        child: Scaffold(
            appBar: BaseUI().appBar(context),
            backgroundColor: ColorResources.COLOR_WHITE,
            body: Scaffold(
              backgroundColor: ColorResources.COLOR_WHITE,
              appBar: AppBar(
                title: TabBar(
                  indicatorWeight: 3,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  labelColor: ColorResources.COLOR_PPIMARY,
                  indicatorColor: ColorResources.COLOR_PPIMARY,
                  unselectedLabelColor: ColorResources.COLOR_BLACK,
                  isScrollable: true,
                  tabs: value.tabs,
                ),
                titleSpacing: 0,
                centerTitle: false,
                elevation: 0.0,
                backgroundColor: ColorResources.COLOR_WHITE,
              ),
              body: Column(
                children: [
                  const Divider(
                    color: ColorResources.COLOR_EBE9E9,
                    height: 2,
                  ),
                  Expanded(
                    child: TabBarView(
                      children: value.generalWidgets,
                    ),
                  ),
                ],
              ),
            )
            //  Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Column(
            //     children: [
            //       Text(
            //         widget.name,
            //         textAlign: TextAlign.start,
            //         style: boldTitlePhone.copyWith(
            //             fontSize: Dimensions.FONT_SIZE_24, height: 1.6),
            //       )
            //     ],
            //   ),

            // ),
            ),
      ),
    );
  }
}
