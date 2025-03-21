import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/languageprovider.dart';
import '../../utils/utils.dart';
import '../auth/auth.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: TextStyle(fontSize: 19.0),
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      imagePadding: EdgeInsets.zero,
      imageAlignment: Alignment.center,
      bodyAlignment: Alignment.bottomCenter,
      imageFlex: 4,
      bodyFlex: 2,
    );

    return IntroductionScreen(
      key: introKey,
      // allowImplicitScrolling: true,
      // autoScrollDuration: 3000,
      globalHeader: Align(
        alignment: Alignment.bottomRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => _onIntroEnd(context),
              child: Text(
                AppLocalizations.of(context)!.skipbutton,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).primaryColor),
              ),
            ),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          title: AppLocalizations.of(context)!.introTitle1,
          body: AppLocalizations.of(context)!.introBody1,
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.center,
            titlePadding: EdgeInsets.only(
              top: size.height * 0.1,
            ),
          ),
          image: _buildImage('assets/images/information.svg'),
          reverse: true,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.introTitle2,
          body: AppLocalizations.of(context)!.introBody2,
          image: _buildImage('assets/images/checkyourself.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.introTitle3,
          body: AppLocalizations.of(context)!.introBody3,
          image: _buildImage('assets/images/notifications.svg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.introTitle4,
          body: AppLocalizations.of(context)!.introBody4,
          decoration: pageDecoration.copyWith(
            imageAlignment: Alignment.center,
            titlePadding: EdgeInsets.only(
              top: size.height * 0.1,
            ),
          ),
          image: _buildImage('assets/images/appointment.svg'),
          reverse: true,
        ),
        PageViewModel(
          title: AppLocalizations.of(context)!.introTitle5,
          body: AppLocalizations.of(context)!.introBody5,
          image: _buildImage('assets/images/artificial_intelligence.svg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showBackButton: true,
      // showSkipButton: true,
      back: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
      // skip: Text(AppLocalizations.of(context)!.skipbutton,
      //     style: TextStyle(
      //         fontWeight: FontWeight.w600,
      //         color: Theme.of(context).primaryColor)),
      next: Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
      done: Text(AppLocalizations.of(context)!.donebutton,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      // controlsMargin: const EdgeInsets.all(16),
      // controlsPadding: kIsWeb
      //     ? const EdgeInsets.all(12.0)
      //     : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      // dotsDecorator: const DotsDecorator(
      //   size: Size(10.0, 10.0),
      //   color: Color(0xFFBDBDBD),
      //   activeSize: Size(22.0, 10.0),
      //   activeShape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(25.0)),
      //   ),
      // ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset(
      assetName,
      width: width,
    );
  }

  void _onIntroEnd(BuildContext context) async {
    context.read<LanguageProvider>().isBoardingCompleate = true;
     context.read<LanguageProvider>().boardingCompleated();
    await Utils(context).pushUntil(widget: const Auth());
  }
}
