import 'package:news/Pages/Splash/splash_controller.dart';
import 'package:news/theme/app_theme.dart';
import 'package:news/util/_string.dart';
import 'package:news/util/constants.dart';
import 'package:news/util/resources.dart';
import 'package:news/widgets/custom_text.dart';
import 'package:news/widgets/no_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    splashController.height = MediaQuery.of(context).size.height;
    splashController.width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: splashController,
        builder: (con) {
          return SafeArea(
            child: Scaffold(
                backgroundColor: AppTheme.colorPrimaryTheme,
                appBar: NoAppBar(),
                body: _body()),
          );
        });
  }

  _body() {
    return Container(
      color: AppTheme.colorWhite,
      padding: const EdgeInsets.all(Constant.splashAllPadding),
      height: splashController.height,
      width: splashController.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: splashController.height! / Constant.splashAppLogoHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constant.splashIconRadius),
                image: const DecorationImage(
                    image: AssetImage(appLogo), fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Constant.splashTextPadding),
              child: CustomText(
                title: Strings.appName,
                fontfamily: Strings.emptyString,
                fontSize: Constant.splashText,
                fontWight: FontWeight.bold,
                color: AppTheme.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
