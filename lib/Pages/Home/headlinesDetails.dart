import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news/Pages/Home/Response/product_response.dart';
import 'package:news/theme/app_theme.dart';
import 'package:news/util/_string.dart';
import 'package:news/util/constants.dart';
import 'package:news/widgets/custom_text.dart';

class HeadlinesDetail extends StatefulWidget {
  const HeadlinesDetail({super.key});

  @override
  State<HeadlinesDetail> createState() => _HeadlinesDetailState();
}

class _HeadlinesDetailState extends State<HeadlinesDetail> {
  double width = Constant.zero;
  double height = Constant.zero;
  Articles data = Get.arguments[Constant.INT_ZERO];
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colorWhite,
        titleSpacing: Constant.zero,
        toolbarHeight: Constant.zero,
      ),
      backgroundColor: AppTheme.colorWhite,
      body: _body(),
    );
  }

  _body() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Card(
                elevation: Constant.zero,
                child: Padding(
                  padding: const EdgeInsets.all(
                      Constant.headlineDetailsAppBarPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_rounded)),
                          CustomText(
                            title: Strings.appNameUpperCase,
                            fontSize:
                                Constant.headlineDetailsAppBarTitleFontSize,
                            leftPadding:
                                Constant.headlineDetailsAppBarTitleLeftPadding,
                            fontfamily: Strings.font2Name,
                            height: Constant.tamplateWordChooseYourBestHeight,
                            fontWight: FontWeight.w600,
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () {
                            Share.share('${data.content} ${data.url}',
                                subject: data.title.toString());
                          },
                          child: const Icon(Icons.share))
                    ],
                  ),
                ),
              ),
              Container(
                height: height * Constant.headileImageHeight,
                width: width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(data.urlToImage.toString()),
                        fit: BoxFit.cover)),
              ),
              const SizedBox(
                height: Constant.SIZE15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    leftPadding: Constant.headileTitleLeftPadding,
                    rightPadding: Constant.headileTitleRightPadding,
                    title: data.title.toString(),
                    fontSize: Constant.headileTitleSize,
                    fontfamily: Strings.emptyString,
                    textAlign: TextAlign.left,
                    fontWight: FontWeight.bold,
                    height: Constant.headileTitleHeight,
                  ),
                  CustomText(
                    topPadding: Constant.headlineContentTopPadding,
                    leftPadding: Constant.headlineContentLeftPadding,
                    rightPadding: Constant.headlineContentRightPadding,
                    bottomPadding: Constant.headlineContentBottomPadding,
                    title: data.content.toString(),
                    fontSize: Constant.headlineContentSize,
                    fontfamily: Strings.emptyString,
                    color: AppTheme.colorblack45,
                    textAlign: TextAlign.left,
                    fontWight: FontWeight.w300,
                    height: Constant.headlineContentHeight,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: Constant.headlineAuthorCircleLeftPadding),
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: Constant.authorAvtarRadius,
                            backgroundImage:
                                NetworkImage(data.urlToImage.toString())),
                        const SizedBox(
                          width: Constant.SIZE10,
                        ),
                        CustomText(
                          title: Strings.by,
                          fontfamily: Strings.emptyString,
                        ),
                        InkWell(
                          onTap: () {
                            bottomsheeet(data.urlToImage);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              CustomText(
                                title: data.author.toString(),
                                bottomPadding: Constant.authorNameBottomPadding,
                                textDecoration: TextDecoration.underline,
                                wordSpacing: Constant.authorNameWordSpacing,
                                fontSize: Constant.authorNameSize,
                                fontWight: FontWeight.w500,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  CustomText(
                    topPadding: Constant.headlineDescriptionTopPadding,
                    leftPadding: Constant.headlineDescriptionLeftPadding,
                    rightPadding: Constant.headlineDescriptionRightPadding,
                    bottomPadding: Constant.headlineDescriptionBottomPadding,
                    title: data.description
                        .toString()
                        .toString()
                        .substring(Constant.INT_ONE, data.description!.length),
                    fontSize: Constant.headlineDescriptionSize,
                    fontfamily: Strings.emptyString,
                    color: AppTheme.colorblack54,
                    textAlign: TextAlign.left,
                    fontWight: FontWeight.w300,
                    height: Constant.headlineDescriptionHeight,
                  ),
                  CustomText(
                    title: Strings.newsSource,
                    topPadding: Constant.newsSourceTextTopPadding,
                    fontWight: FontWeight.bold,
                    leftPadding: Constant.newsSourceTextLeftPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: Constant.newsSourceUrlTopPadding,
                        left: Constant.newsSourceUrlLeftPadding,
                        right: Constant.newsSourceUrlRightPadding),
                    child: InkWell(
                      onTap: () async {
                        launchUrl(Uri.parse(data.url.toString()),
                                mode: LaunchMode.inAppWebView)
                            // ignore: body_might_complete_normally_catch_error
                            .catchError((error) {
                          Get.snackbar(
                              margin: const EdgeInsets.all(
                                  Constant.failedSnackbarMargin),
                              Strings.feildError,
                              Strings.failIntoOpening,
                              backgroundColor: AppTheme.colorRed,
                              colorText: AppTheme.colorWhite,
                              snackPosition: SnackPosition.BOTTOM);
                        });
                      },
                      child: CustomText(
                        height: Constant.sourceUrlHeight,
                        title: data.url.toString(),
                        color: AppTheme.colorblue,
                        fontSize: Constant.sourceUrlSize,
                        textAlign: TextAlign.left,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                topPadding: Constant.hedlinePublishedTextTopPadding,
                rightPadding: Constant.hedlinePublishedTextRightPadding,
                bottomPadding: Constant.hedlinePublishedTextBottomPadding,
                title: "${Strings.publishedAt}${data.publishedAt} ",
                fontWight: FontWeight.w600,
                fontSize: Constant.hedlinePublishedTextSize,
                textDecoration: TextDecoration.underline,
                fontfamily: Strings.emptyString,
                color: AppTheme.colorblack,
              ),
            ],
          )
        ],
      ),
    );
  }

  bottomsheeet(image) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(
                    Constant.headlineAuthorBottomSheetPadding),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                        radius: Constant.headlineAuthorBottomSheetRadius,
                        backgroundImage: NetworkImage(image.toString())),
                    const SizedBox(
                      width: Constant.SIZE10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        CustomText(
                          title: data.author.toString(),
                          bottomPadding: Constant
                              .headlineAuthorTitleBottomSheetBottomPadding,
                          wordSpacing: Constant
                              .headlineAuthorTitleBottomSheetWordSpacing,
                          fontfamily: Strings.emptyString,
                          fontSize: Constant.headlineAuthorTitleBottomSheetSize,
                          fontWight: FontWeight.bold,
                        ),
                        CustomText(
                          title: Strings.newsAuthor,
                          leftPadding: Constant.authorRoleTextLeftPadding,
                          topPadding: Constant.authorRoleTextTopPadding,
                          fontSize: Constant.authorRoleTextSize,
                          wordSpacing: Constant.authorRoleTextWordSpacing,
                          color: AppTheme.colorblack38,
                          fontfamily: Strings.emptyString,
                          fontWight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              CustomText(
                  leftPadding: Constant.authorBioLeftPadding,
                  rightPadding: Constant.authorBioRightPadding,
                  bottomPadding: Constant.authorBioBottomPadding,
                  height: Constant.authorBioBottomHeight,
                  fontSize: Constant.authorBioBottomSize,
                  title: "${data.author} ${Strings.authorBio}")
            ],
          );
        });
  }
}
