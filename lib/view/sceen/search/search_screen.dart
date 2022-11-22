import 'package:erik_haydar/provider/search_provider.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/search/film_search_screen.dart';
import 'package:erik_haydar/view/sceen/search/music_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../localization/language_constrants.dart';
import '../../../util/color_resources.dart';
import '../../../util/images.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  String query = '';
  @override
  void initState() {
    Provider.of<SearchProvider>(context, listen: false).setDefauilLists();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorResources.COLOR_WHITE,
        appBar: BaseUI().appBar(context),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                onChanged: (result) {
                  setState(() {
                    query = result;
                    value.getFilmsSearch(query, false);
                    value.getMusicSearch(query, false);
                  });
                },
                autofocus: false,
                controller: _controller,
                readOnly: false,
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                cursorColor: ColorResources.COLOR_PPIMARY,
                decoration: InputDecoration(
                  filled: true,
                  prefixIconConstraints:
                      const BoxConstraints(minHeight: 20, minWidth: 20),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 18, right: 12),
                    child: SvgPicture.asset(
                      Images.searchIcon,
                    ),
                  ),
                  hoverColor: ColorResources.COLOR_BLACK_GREY,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: ColorResources.COLOR_PPIMARY,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: ColorResources.COLOR_F4F4F4,
                    ),
                  ),
                  hintStyle:
                      const TextStyle(color: ColorResources.COLOR_GRAY_TEXT),
                  fillColor: ColorResources.COLOR_F4F4F4,
                  alignLabelWithHint: true,
                  isDense: true,
                ),
                textInputAction: TextInputAction.next, //
              ),
            ),
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Scaffold(
                  backgroundColor: ColorResources.COLOR_WHITE,
                  appBar: AppBar(
                    elevation: 0,
                    toolbarHeight: 0,
                    // toolbarOpacity: 0,
                    backgroundColor: ColorResources.COLOR_WHITE,
                    bottom: value.totalFilmsCount == 0 &&
                            value.totalMusicsCount == 0
                        ? null
                        : TabBar(
                            isScrollable: true,
                            // padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            labelColor: ColorResources.COLOR_009C10,
                            unselectedLabelColor: ColorResources.COLOR_737373,
                            splashBorderRadius: BorderRadius.circular(50),
                            indicatorColor: ColorResources
                                .COLOR_009C10, //Change background color from here
                            tabs: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                child: Text(
                                    '${getTranslated('videos', context)} (${value.totalFilmsCount})'),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 9),
                                child: Text(
                                    '${getTranslated('musics', context)} (${value.totalMusicsCount})'),
                              ),
                            ],
                          ),
                  ),
                  body: TabBarView(children: [
                    FilmSearchScreen(query: query),
                    MusicSearchScreen(query: query),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
