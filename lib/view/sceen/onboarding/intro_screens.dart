import 'package:erik_haydar/util/images.dart';
import 'package:erik_haydar/view/sceen/onboarding/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'intro_screen.dart';

enum IndicatorType { CIRCLE, LINE, DIAMOND }

enum FooterShape { NORMAL, CURVED_TOP, CURVED_BOTTOM }

class IntroScreens extends StatefulWidget {
//  PageController get controller => this.createState()._controller;

  @override
  _IntroScreensState createState() => _IntroScreensState();
  final IndicatorType indicatorType;

  final Widget? nextWidget;
  final Widget? doneWidget;

  final String appTitle;

  final double footerRadius;

  final double viewPortFraction;

  final List<IntroScreen> slides;

  final String skipText;

  final Function? onSkip;

  final Function onDone;

  final Color activeDotColor;

  final Color? inactiveDotColor;

  final EdgeInsets footerPadding;

  final Color footerBgColor;
  final Color backFooterColor;

  final Color textColor;

  final List<Color> footerGradients;

  final ScrollPhysics physics;

  final Color containerBg;

  const IntroScreens(
      {super.key,
      required this.slides,
      this.footerRadius = 12.0,
      this.footerGradients = const [],
      this.containerBg = Colors.white,
      required this.onDone,
      this.indicatorType = IndicatorType.CIRCLE,
      this.appTitle = '',
      this.physics = const BouncingScrollPhysics(),
      this.onSkip,
      this.nextWidget,
      this.doneWidget,
      this.activeDotColor = const Color(0xFFCC4242),
      this.inactiveDotColor = const Color(0xFFD9D9D9),
      this.skipText = '      ',
      this.viewPortFraction = 1.0,
      this.textColor = Colors.black,
      this.footerPadding = const EdgeInsets.all(24),
      this.footerBgColor = const Color.fromARGB(255, 247, 249, 250),
      this.backFooterColor = const Color(0xffCC4242)})
      : assert(slides.length > 0);
}

class _IntroScreensState extends State<IntroScreens>
    with TickerProviderStateMixin {
  PageController? _controller;
  double? pageOffset = 0;
  int currentPage = 0;
  bool lastPage = false;
  late AnimationController animationController;
  IntroScreen? currentScreen;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: widget.viewPortFraction,
    )..addListener(() {
        pageOffset = _controller!.page;
      });

    currentScreen = widget.slides[0];
    animationController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
  }

  get onSkip => widget.onSkip ?? defaultOnSkip;

  defaultOnSkip() => animationController.animateTo(
        widget.slides.length - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
      );

  TextStyle get textStyle =>
      currentScreen!.textStyle ??
      Theme.of(context).textTheme.bodyText1 ??
      GoogleFonts.lato(
        fontSize: 18,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  Widget get next =>
      widget.nextWidget ??
      SvgPicture.asset(
        Images.arrow_right,
        height: 48,
      );

  Widget get done =>
      widget.doneWidget ??
      SvgPicture.asset(
        Images.arrow_right,
        height: 48,
      );

  @override
  void dispose() {
    _controller!.dispose();
    animationController.dispose();
    super.dispose();
  }

  bool get existGradientColors => widget.footerGradients.length > 0;

  LinearGradient get gradients => existGradientColors
      ? LinearGradient(
          colors: widget.footerGradients,
          begin: Alignment.topLeft,
          end: Alignment.topRight)
      : LinearGradient(
          colors: [
            widget.footerBgColor,
            widget.footerBgColor,
          ],
        );

  int getCurrentPage() => _controller!.page!.floor();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            currentScreen?.headerBgColor.withOpacity(.8) ?? Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor:
            currentScreen?.headerBgColor ?? Colors.transparent,
      ),
      child: Container(
        color: widget.containerBg,
//        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned.fill(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * .51,
              child: Container(
                padding: widget.footerPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.footerRadius.toDouble()),
                    topLeft: Radius.circular(widget.footerRadius.toDouble()),
                  ),
                  color: Colors.red[900],
                  //gradient: gradients,
                ),
              ),
            ),
            PageView.builder(
              itemCount: widget.slides.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                  currentScreen = widget.slides[currentPage];
                  setState(() {
                    currentScreen!.index = currentPage + 1;
                  });
                  if (currentPage == widget.slides.length - 1) {
                    lastPage = true;
                    animationController.forward();
                  } else {
                    lastPage = false;
                    animationController.reverse();
                  }
                });
              },
              controller: _controller,
              physics: widget.physics,
              itemBuilder: (context, index) {
                if (index == pageOffset!.floor()) {
                  return AnimatedBuilder(
                      animation: _controller!,
                      builder: (context, _) {
                        return buildPage(
                          index: index,
                          angle: pageOffset! - index,
                        );
                      });
                } else if (index == pageOffset!.floor() + 1) {
                  return AnimatedBuilder(
                    animation: _controller!,
                    builder: (context, _) {
                      return buildPage(
                        index: index,
                        angle: pageOffset! - index,
                      );
                    },
                  );
                }
                return buildPage(index: index);
              },
            ),
            Positioned.fill(
              bottom: 0,
              left: 0,
              right: 0,
              top: MediaQuery.of(context).size.height * .52,
              child: Container(
                padding: widget.footerPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(widget.footerRadius.toDouble()),
                    topLeft: Radius.circular(widget.footerRadius.toDouble()),
                  ),
                  color: Colors.white,
                  //gradient: gradients,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        currentScreen!.title!,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textStyle.apply(
                          color: widget.textColor,
                          fontWeightDelta: 12,
                          fontSizeDelta: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        currentScreen!.description!,
                        softWrap: true,
                        style: textStyle.apply(
                          color: widget.textColor,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              ),
            ),
            //controls widget
            Positioned(
              left: 0,
              right: 0,
              bottom: 100,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        width: 48,
                      ),
                      Expanded(
                        child: Container(
                          width: 160,
                          child: PageIndicator(
                            type: widget.indicatorType,
                            currentIndex: currentPage,
                            activeDotColor: widget.activeDotColor,
                            inactiveDotColor: widget.inactiveDotColor,
                            pageCount: widget.slides.length,
                            onTap: () {
                              _controller!.animateTo(
                                _controller!.page!,
                                duration: const Duration(
                                  milliseconds: 400,
                                ),
                                curve: Curves.fastOutSlowIn,
                              );
                            },
                          ),
                        ),
                      ),
                      Material(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        type: MaterialType.transparency,
                        child: lastPage
                            ? InkWell(
                                borderRadius: BorderRadius.circular(100),
                                onTap: widget.onDone as void Function()?,
                                child: done,
                              )
                            : InkWell(
                                borderRadius: BorderRadius.circular(100),
                                child: next,
                                onTap: () => _controller!.nextPage(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.fastOutSlowIn),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //app title
            /*Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.appTitle,
                  style: textStyle.apply(
                      fontSizeDelta: 12, fontWeightDelta: 8, color: Colors.red),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget buildPage(
      {required int index, double angle = 0.0, double scale = 1.0}) {
    // print(pageOffset - index);
    return Container(
      color: Colors.transparent,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, .001)
          ..rotateY(angle),
        child: widget.slides[index],
      ),
    );
  }
}
