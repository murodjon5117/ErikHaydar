import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:erik_haydar/data/model/response/body/detail_fim_model.dart';
import 'package:erik_haydar/provider/detail_film_provider.dart';
import 'package:erik_haydar/view/base/base_ui.dart';
import 'package:erik_haydar/view/sceen/detail_film/comment_list.dart';
import 'package:erik_haydar/view/sceen/detail_film/set_comment.dart';
import 'package:erik_haydar/view/sceen/player/player_screen.dart';
import 'package:erik_haydar/view/sceen/serial/serials_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../data/model/response/base/video/audio.dart';
import '../../../data/model/response/base/video/m3u8.dart';
import '../../../data/model/response/base/video/m3u8s.dart';
import '../../../data/model/response/base/video/regex_response.dart';
import '../../../helper/enums/button_enum.dart';
import '../../../localization/language_constrants.dart';
import '../../../provider/home_provider.dart';
import '../../../provider/serial_provider.dart';
import '../../../util/color_resources.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';

class DetailFilmScreen extends StatefulWidget {
  final String slug;
  final String image;

  const DetailFilmScreen({super.key, required this.slug, required this.image});
  @override
  State<DetailFilmScreen> createState() => _DetailFilmScreenState();
}

class _DetailFilmScreenState extends State<DetailFilmScreen> {
  List<M3U8pass> yoyo = [];
  // m3u8 audio list
  List<AUDIO> audioList = [];
  // m3u8 temp data
  String? m3u8Content;
  // subtitle temp data  @override
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Provider.of<FilmDetailProvider>(context, listen: false)
          .getFilmDetail(widget.slug)
          .then((result) {
        if (result.canWatch ?? false) {
          Provider.of<FilmDetailProvider>(context, listen: false)
              .getMovieSource(widget.slug)
              .then((value) {
            if ((value.sources ?? '').isNotEmpty) {
              m3u8video(value.sources ?? '');
            }
          });
        } else {}
      });
      Provider.of<FilmDetailProvider>(context, listen: false)
          .getComment(widget.slug, false);
    });
    // m3u8video(
    //     'https://hamshira.biznesgoya.uz/uploads/media/stream/191/e8e7b83d5b7bcad18b31d0c7b7e910b3/cbdd90b6f2900f0c57ea0f56bed5b83c.m3u8');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (p0, p1) => Consumer<FilmDetailProvider>(
        builder: (context, value, child) => Scaffold(
          backgroundColor: ColorResources.COLOR_WHITE,
          appBar: AppBar(
            backgroundColor: ColorResources.COLOR_WHITE,
            centerTitle: true,
            elevation: 0.0,
            leading: IconButton(
              icon: SvgPicture.asset(Images.back_icon),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [favorite(context, value.detailFilmModel)],
          ),
          body: Stack(
            children: [
              NotificationListener(
                onNotification: _scrollNotification,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: p1.maxHeight,
                    ),
                    child: Column(
                      children: [
                        detaiPhoto(value.detailFilmModel),
                        detailInformation(value.detailFilmModel),
                        detailFunctions(value.detailFilmModel.viewsCount ?? 0),
                        CommentList(
                          commentList: value.commentList,
                          totalCount: value.totalItemCount,
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SetComment(id: value.detailFilmModel.id ?? 0)
            ],
          ),
        ),
      ),
    );
  }

  Future<M3U8s> m3u8video(String video) async {
    // yoyo.add(M3U8pass(dataQuality: "Auto", dataURL: video));
    RegExp regExpAudio = RegExp(
      RegexResponse.regexMEDIA,
      caseSensitive: false,
      multiLine: true,
    );
    RegExp regExp = RegExp(
      r"#EXT-X-STREAM-INF:(?:.*,RESOLUTION=(\d+x\d+))?,?(.*)\r?\n(.*)",
      caseSensitive: false,
      multiLine: true,
    );
    setState(
      () {
        if (m3u8Content != null) {
          print("--- HLS Old Data ----\n$m3u8Content");
          m3u8Content = null;
        }
      },
    );
    if (m3u8Content == null && video != null) {
      http.Response response = await http.get(Uri.parse(video));
      if (response.statusCode == 200) {
        m3u8Content = utf8.decode(response.bodyBytes);
      }
    }
    List<RegExpMatch> matches = regExp.allMatches(m3u8Content!).toList();
    List<RegExpMatch> audioMatches =
        regExpAudio.allMatches(m3u8Content!).toList();
    print(
        "--- HLS Data ----\n$m3u8Content \ntotal length: ${yoyo.length} \nfinish");

    matches.forEach(
      (RegExpMatch regExpMatch) async {
        String quality = (regExpMatch.group(1)).toString();
        String sourceURL = (regExpMatch.group(3)).toString();
        final netRegex = RegExp(r'^(http|https):\/\/([\w.]+\/?)\S*');
        final netRegex2 = RegExp(r'(.*)\r?\/');
        final isNetwork = netRegex.hasMatch(sourceURL);
        final match = netRegex2.firstMatch(video);
        String url;
        if (isNetwork) {
          url = sourceURL;
        } else {
          print(match);
          final dataURL = match!.group(0);
          url = "$dataURL$sourceURL";
          print("--- hls child url integration ---\nchild url :$url");
        }
        audioMatches.forEach(
          (RegExpMatch regExpMatch2) async {
            String audioURL = (regExpMatch2.group(1)).toString();
            final isNetwork = netRegex.hasMatch(audioURL);
            final match = netRegex2.firstMatch(video);
            String auURL = audioURL;
            if (isNetwork) {
              auURL = audioURL;
            } else {
              print(match);
              final auDataURL = match!.group(0);
              auURL = "$auDataURL$audioURL";
              print("url network audio  $url $audioURL");
            }
            audioList.add(AUDIO(url: auURL));
            print(audioURL);
          },
        );
        String audio = "";
        print("-- audio ---\naudio list length :${audio.length}");
        if (audioList.isNotEmpty) {
          audio =
              """#EXT-X-MEDIA:TYPE=AUDIO,GROUP-ID="audio-medium",NAME="audio",AUTOSELECT=YES,DEFAULT=YES,CHANNELS="2",URI="${audioList.last.url}"\n""";
        } else {
          audio = "";
        }
        try {
          final Directory directory = await getApplicationDocumentsDirectory();
          final File file = File('${directory.path}/yoyo$quality.m3u8');
          await file.writeAsString(
              """#EXTM3U\n#EXT-X-INDEPENDENT-SEGMENTS\n$audio#EXT-X-STREAM-INF:CLOSED-CAPTIONS=NONE,BANDWIDTH=1469712,RESOLUTION=$quality,FRAME-RATE=30.000\n$url""");
        } catch (e) {
          print("Couldn't write file");
        }
        yoyo.add(M3U8pass(dataQuality: quality, dataURL: url));
      },
    );
    M3U8s m3u8s = M3U8s(m3u8s: yoyo);
    print(
        "--- m3u8 file write ---\n${yoyo.map((e) => e.dataQuality == e.dataURL).toList()}\nlength : ${yoyo.length}\nSuccess");
    return m3u8s;
  }

  bool _scrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        Provider.of<FilmDetailProvider>(context, listen: false).isPaging()) {
      Provider.of<FilmDetailProvider>(context, listen: false)
          .getComment(widget.slug, true);
    }
    return true;
  }

  Widget detailInformation(DetailFilmModel detailFilmModel) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 27),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                getTranslated('downloaded', context),
                style:
                    titleTextField.copyWith(color: ColorResources.COLOR_BBB5B5),
              ),
              Text(
                detailFilmModel.createdAt ?? '',
                style: titleTextField,
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            detailFilmModel.name ?? '',
            style: detailTitle,
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            detailFilmModel.description ?? '',
            style: filledButtonTextStyle.copyWith(
                color: ColorResources.COLOR_BLACK),
          ),
        ],
      ),
    );
  }

  Widget detailFunctions(int viewCount) {
    return Consumer<FilmDetailProvider>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                value.likeForFilm(widget.slug);
              },
              child: Column(
                children: [
                  SvgPicture.asset(value.isLike ? Images.liked : Images.unLike),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    value.likeCount.toString(),
                    style: titleTextField.copyWith(
                        color: value.isLike
                            ? ColorResources.COLOR_PPIMARY
                            : ColorResources.COLOR_737373),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            GestureDetector(
              onTap: () {
                value.dissLikeForFilm(widget.slug);
              },
              child: Column(
                children: [
                  SvgPicture.asset(
                      value.isDisLike ? Images.disliked : Images.unDislike),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    value.likeDisCount.toString(),
                    style: titleTextField.copyWith(
                        color: value.isDisLike
                            ? ColorResources.COLOR_PPIMARY
                            : ColorResources.COLOR_737373),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Column(
              children: [
                SvgPicture.asset(Images.view),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  viewCount.toString(),
                  style: titleTextField,
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                // final taskId = await FlutterDownloader.enqueue(
                //   url: yoyo[0].dataURL ?? '',
                //   savedDir: '/path/to/download/directory',
                //   showNotification: true,
                //   openFileFromNotification: true,
                // );

                // value.downloadVideo((yoyo[0].dataURL ?? ''));
                downloadFile(yoyo[0].dataURL ?? '');
              },
              child: Column(
                children: [
                  SvgPicture.asset(Images.downloadVideo),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    getTranslated('download', context),
                    style: downloadTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> downloadFile(String imageUrl) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      print(dir.path);
      print(yoyo[0].dataURL ?? '');
      print(yoyo[1].dataURL ?? '');
      await dio.download(yoyo[0].dataURL ?? '', "${dir.path}/demo.mp4",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec , Total: $total");

        setState(() {
          print(((rec / total) * 100).toStringAsFixed(0) + "%");
        });
      });
    } catch (e) {
      print(e);
    }

    // setState(() {
    //   downloading = false;
    //   progressString = "Completed";
    // });
    print("Download completed");
  }

  Widget detaiPhoto(
    DetailFilmModel model,
  ) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
              width: double.infinity,
              height: 238,
              child: BaseUI().imageNetwork(widget.image)),
        ),
        Positioned(
            top: 10, left: 0, child: tipVideo(model.isFree ?? false, context)),
        Positioned(
            top: 77,
            bottom: 77,
            left: 0,
            right: 0,
            child: GestureDetector(
                onTap: () {
                  print(widget.slug);
                  if (model.canWatch ?? false) {
                    if (model.isSerial ?? false) {
                      Provider.of<SerialProvider>(context, listen: false)
                          .getSerialSeason(widget.slug)
                          .then((value) {
                        if (value) {
                          pushNewScreen(context,
                              screen: SerialsScreen(
                                  slug: model.slug ?? '',
                                  name: model.name ?? ''));
                        }
                      });
                    } else {
                      if ((Provider.of<FilmDetailProvider>(context,
                                      listen: false)
                                  .movieSource
                                  .sources ??
                              '')
                          .isNotEmpty) {
                        pushNewScreen(context,
                            screen: PlayerScreen(yoyo: yoyo),
                            withNavBar: false);
                      }
                    }
                  } else {
                    _showMessage(model.canWatchMessage ?? '');
                  }
                },
                child: SvgPicture.asset(Images.playVideo)))
      ],
    );
  }

  _showMessage(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
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
                        getTranslated('info', context),
                        style: boldTitle.copyWith(
                            fontSize: Dimensions.FONT_SIZE_24),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(message),
                      const SizedBox(
                        height: 24,
                      ),
                      BaseUI().buttonsType(TypeButton.filled, context, () {
                        Navigator.pop(context);
                      }, getTranslated('understand', context)),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget tipVideo(bool isFree, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: isFree
              ? ColorResources.COLOR_0ABA66
              : ColorResources.COLOR_6212C7,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30.0),
              topRight: Radius.circular(30.0))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 5, 27, 5),
        child: Text(getTranslated(isFree ? 'free' : 'premium', context),
            style: itemWidgetTextStyle.copyWith(
                color: ColorResources.COLOR_WHITE)),
      ),
    );
  }

  Widget favorite(
    BuildContext context,
    DetailFilmModel detailFilmModel,
  ) {
    return GestureDetector(
        onTap: () {
          Provider.of<HomeProvider>(context, listen: false)
              .addFavorite(widget.slug)
              .then((value) {
            if (value.status == 200) {
              if (detailFilmModel.isUserFavoriteFilm == true) {
                setState(() {
                  detailFilmModel.isUserFavoriteFilm = false;
                });
              } else {
                setState(() {
                  detailFilmModel.isUserFavoriteFilm = true;
                });
              }
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SvgPicture.asset(detailFilmModel.isUserFavoriteFilm ?? false
              ? Images.favorited
              : Images.favorite),
        ));
  }
}
