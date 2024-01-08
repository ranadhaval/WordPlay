import 'package:news/util/_string.dart';
import 'package:news/util/constants.dart';
import 'package:news/util/resources.dart';
import 'package:news/widgets/custom_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppLogo extends StatefulWidget {
  double logoHeight;
  double logoWidth;
  AppLogo({super.key, this.logoHeight = 6.5, this.logoWidth = 3});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  double? height;
  double? width;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: Constant.SIZE100),
          child: Container(
            height: height! / widget.logoHeight,
            width: width! / widget.logoWidth,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(Constant.applogoWidgeLogoBoxRadius),
                image: const DecorationImage(
                    image: AssetImage(appLogo), fit: BoxFit.cover)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(Constant.applogoWidgetTitlePadding),
          child: CustomText(
            title: Strings.appName,
            height: Constant.applogoWidgetAppnameHeight,
            fontWight: FontWeight.bold,
            fontSize: Constant.applogoWidgetAppnameSize,
          ),
        ),
      ],
    );
  }
}
