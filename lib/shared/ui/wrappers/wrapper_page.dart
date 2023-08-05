import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../themes/color.dart';
import '../../../themes/themes.dart';
import '../../utils/utils_global.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.scrollable = true,
    this.appBarHeight,
    this.hasPadding = true,
    this.statusBarColor,
    this.navigationBarColor,
    this.backgroundImage,
    this.height,
    this.safeTop = true,
    this.safeBot = true,
    this.fullScreen = false,
  });

  final Widget child;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool scrollable;
  final double? appBarHeight;
  final bool hasPadding;
  final Color? statusBarColor;
  final Color? navigationBarColor;
  final DecorationImage? backgroundImage;
  final double? height;
  final bool safeTop;
  final bool safeBot;
  final bool fullScreen;

  @override
  State<StatefulWidget> createState() => _WrapperPage();
}

class _WrapperPage extends State<WrapperPage> {
  Widget iOSChild(double padTop, double padBot) {
    return Material(
      child: Container(
        padding: EdgeInsets.only(
          top: padTop,
          bottom: padBot,
        ),
        width: MediaQuery.of(context).size.width,
        color: widget.backgroundColor,
        child: Column(
          children: <Widget>[
            widget.appBar ?? Container(),
            //
            Expanded(
              child: widget.scrollable
                  ? SingleChildScrollView(
                      padding: EdgeInsets.all(
                        widget.hasPadding ? AppTheme.defaultPadding : 0,
                      ),
                      child: _FullWidth(child: widget.child),
                    )
                  : _FullWidth(child: widget.child),
            ),
            //
            widget.bottomNavigationBar ?? Container(),
          ],
        ),
      ),
    );
  }

  Widget androidChild(
    double padTop,
    double padBot,
    DecorationImage? image,
    double? height,
    bool safeTop,
    bool safeBot,
  ) {
    return SafeArea(
      top: safeTop,
      bottom: safeBot,
      child: Scaffold(
        backgroundColor: widget.backgroundColor,
        appBar: widget.appBar != null
            ? PreferredSize(
                preferredSize: const Size.fromHeight(100),
                child: widget.appBar ?? Container(),
              )
            : null,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                // top: padTop,
                bottom: padBot,
              ),
              width: MediaQuery.of(context).size.width,
              height: height,
              decoration: BoxDecoration(
                image: image,
                color: widget.backgroundColor,
              ),
              child: widget.scrollable
                  ? SingleChildScrollView(
                      padding: EdgeInsets.all(
                        widget.hasPadding ? AppTheme.defaultPadding : 0,
                      ),
                      child: _FullWidth(child: widget.child),
                    )
                  : _FullWidth(child: widget.child),
            ),
            //
            Positioned(
              bottom: 16,
              right: 16,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                reverseDuration: const Duration(milliseconds: 500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                switchOutCurve: Curves.easeInOutCubic,
                child: AppUtilsGlobal().internetState.value
                    ? Container()
                    : _NoConnection(),
              ),
            ),
            //
          ],
        ),
        bottomNavigationBar: widget.bottomNavigationBar,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double padTop = MediaQuery.of(context).padding.top;
    double padBot = MediaQuery.of(context).padding.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.navTheme(
        statusBarColor: widget.statusBarColor,
        navigationBarColor: widget.navigationBarColor,
      ),
      child: androidChild(
        padTop,
        padBot,
        widget.backgroundImage,
        widget.height,
        widget.safeTop,
        widget.safeBot,
      ),
    );
  }
}

class _FullWidth extends StatelessWidget {
  const _FullWidth({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: child,
    );
  }
}

class _NoConnection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NoConnectionState();
}

class _NoConnectionState extends State<_NoConnection>
    with TickerProviderStateMixin {
  late AnimationController motionController;
  late Animation motionAnimation;
  double size = 20;

  @override
  void initState() {
    motionController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      lowerBound: 0.5,
    );

    motionAnimation = CurvedAnimation(
      parent: motionController,
      curve: Curves.ease,
    );

    motionController.forward();
    motionController.addStatusListener((status) {
      setState(() {
        if (status == AnimationStatus.completed) {
          motionController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          motionController.forward();
        }
      });
    });
    motionController.addListener(() {
      setState(() {
        size = motionController.value * 250;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    motionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius: BorderRadius.circular(32),
      ),
      child: const Center(
        // child: HeroIcon(
        //   HeroIcons.signalSlash,
        //   color: AppColors.white,
        // ),
        child: Icon(
          Icons.wifi_off_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }
}
