import 'package:news/routes/app_routes.dart';
import 'package:news/theme/app_theme.dart';
import 'package:news/util/_string.dart';
import 'package:news/util/constants.dart';
import 'package:news/util/resources.dart';
import 'package:news/widgets/custom_text.dart';
import 'package:news/widgets/no_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'home_controller.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final homeController = Get.put(HomeController());
  double width = Constant.zero;
  double height = Constant.zero;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return GetBuilder(
        init: homeController,
        builder: (controller) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Constant.zero)),
              width: width * Constant.drawerWidth,
              child: drawr(),
            ),
            backgroundColor: AppTheme.homeBackgroundColor,
            appBar: NoAppBar(),
            body: _body(),
          );
        });
  }

  _body() {
    return Padding(
      padding: const EdgeInsets.all(Constant.homeBodyPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constant.zero)),
            child: Padding(
              padding: const EdgeInsets.all(Constant.drawerPannelPadding),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: Constant.drawerIconPadding),
                          child: InkWell(
                            onTap: () {
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            child: const Icon(
                              Icons.menu_sharp,
                              size: Constant.menuIconHeight,
                            ),
                          ),
                        ),
                        CustomText(
                          title: Strings.appName,
                          fontSize: Constant.appNameTextSize,
                          leftPadding: Constant.appNamePadding,
                          fontfamily: Strings.font2Name,
                          height: Constant.tamplateWordChooseYourBestHeight,
                          fontWight: FontWeight.bold,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                    const Icon(Icons.search)
                  ]),
            ),
          ),
          Card(
            child: Container(
              height: height * Constant.categoryPanelHight,
              width: width,
              padding: const EdgeInsets.all(Constant.categoryPanelPadding),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  category(Strings.techDesign),
                  category(Strings.stocks),
                  category(Strings.medical),
                  category(Strings.reform),
                ],
              ),
            ),
          ),
          homeController.newsResponse.articles == null
              ? Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: Constant.INT_FOUR,
                      itemBuilder: (context, index) {
                        return skeleton();
                      }))
              : Expanded(
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.newsResponse.articles!.length,
                      itemBuilder: (context, index) {
                        return (index) % Constant.INT_THREE == Constant.INT_ZERO
                            ? rowProduct(
                                index: index,
                                title: homeController
                                    .newsResponse.articles![index].title
                                    .toString(),
                                author: homeController
                                    .newsResponse.articles![index].author
                                    .toString(),
                                image: homeController
                                    .newsResponse.articles![index].urlToImage
                                    .toString(),
                              )
                            : newsTile(
                                index: index,
                                title: homeController
                                    .newsResponse.articles![index].title
                                    .toString(),
                                publishedAt: homeController
                                    .newsResponse.articles![index].publishedAt
                                    .toString(),
                                image: homeController
                                    .newsResponse.articles![index].urlToImage
                                    .toString(),
                              );
                      }))
        ],
      ),
    );
  }

  category(name) {
    return Padding(
      padding: const EdgeInsets.only(right: Constant.categoryBoxPadding),
      child: Container(
        padding: const EdgeInsets.only(
            left: Constant.categoryPanelPlateLeftPadding,
            top: Constant.categoryPanelPlateTopPadding,
            bottom: Constant.categoryPanelPlateBottomPadding,
            right: Constant.categoryPanelPlateRightPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constant.zero),
            border: Border.all(color: AppTheme.colorblack45)),
        child: Center(
          child: CustomText(
            title: '#$name',
            fontSize: Constant.categoryTextSize,
            fontfamily: Strings.emptyString,
            fontWight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  rowProduct({
    required int index,
    required String title,
    required String image,
    required String author,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: Constant.THREE),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoute.PRODUCT_DETAIL,
              arguments: [homeController.newsResponse.articles![index], index]);
        },
        child: Card(
          elevation: Constant.THREE,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constant.zero)),
          child: Container(
            margin: const EdgeInsets.all(Constant.profileTileMargin),
            padding: const EdgeInsets.all(Constant.THREE),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constant.zero)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: width * Constant.rownewsTileAuthorTextWidth,
                      child: CustomText(
                        bottomPadding: Constant.authorTextBOttomPedding,
                        title: author.toUpperCase(),
                        fontWight: FontWeight.bold,
                        fontfamily: Strings.emptyString,
                        height: Constant.profileTileProductNameHeight,
                      ),
                    ),
                    SizedBox(
                      width: width * Constant.rownewsTileTitleTextWidth,
                      child: CustomText(
                        textAlign: TextAlign.left,
                        title:
                            "${title.substring(Constant.INT_ZERO, title.length - Constant.subString30)}...",
                        fontWight: FontWeight.w400,
                        fontfamily: Strings.emptyString,
                        height: Constant.profileTileProductNameHeight,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoute.PRODUCT_DETAIL, arguments: [
                          homeController.newsResponse.articles![index],
                          index
                        ]);
                      },
                      child: SizedBox(
                        width: width * Constant.readMoreSizedBoxxWidth,
                        child: CustomText(
                          topPadding: Constant.THREE,
                          title: Strings.readMore,
                          fontWight: FontWeight.w400,
                          color: Colors.blue,
                          fontfamily: Strings.emptyString,
                          height: Constant.profileTileProductNameHeight,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: Constant.SIZE10,
                ),
                Column(
                  children: [
                    Container(
                      height: height * Constant.rawNewsImageHight,
                      width: width * Constant.rawNewsImageWidth,
                      margin: const EdgeInsets.all(Constant.zero),
                      decoration: BoxDecoration(
                        color: AppTheme.colorWhite,
                        borderRadius: BorderRadius.circular(Constant.zero),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(Constant.zero),
                          child: Image(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  shimmerTile({required double height, required double width}) {
    return Shimmer.fromColors(
        baseColor: AppTheme.greyColor,
        highlightColor: AppTheme.colorWhite,
        child: Container(
          color: AppTheme.colorblack,
          height: height,
          width: width,
        ));
  }

  newsTile({
    required int index,
    required String title,
    required String image,
    required String publishedAt,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: Constant.THREE),
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoute.PRODUCT_DETAIL,
              arguments: [homeController.newsResponse.articles![index], index]);
        },
        child: Card(
          elevation: Constant.THREE,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constant.zero)),
          child: Container(
            margin: const EdgeInsets.all(Constant.profileTileMargin),
            padding: const EdgeInsets.all(Constant.THREE),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Constant.zero)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      height: height * Constant.newsTileImage,
                      width: width,
                      margin: const EdgeInsets.all(
                          Constant.profileTileImageBoxMargin),
                      decoration: BoxDecoration(
                        color: AppTheme.colorWhite,
                        borderRadius: BorderRadius.circular(Constant.zero),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(Constant.zero),
                          child: Image(
                            image: NetworkImage(image),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  width: Constant.SIZE15,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: Constant.newsTileTitleLeftPadding,
                      top: Constant.newsTileTitleTopPadding),
                  child: SizedBox(
                    width: width * Constant.newsTileTitleSizedBoxWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: title,
                          fontWight: FontWeight.bold,
                          fontfamily: Strings.emptyString,
                          height: Constant.profileTileProductNameHeight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomText(
                              topPadding:
                                  Constant.profileTileProductCategoryTopPadding,
                              title: Strings.publishedAt,
                              fontWight: FontWeight.bold,
                              fontSize: Constant.publishedTextSize,
                              fontfamily: Strings.emptyString,
                              color: AppTheme.colorblack,
                            ),
                            CustomText(
                              topPadding:
                                  Constant.profileTileProductCategoryTopPadding,
                              title: publishedAt,
                              fontWight: FontWeight.bold,
                              fontSize: Constant.newsTilePublishedAtSize,
                              fontfamily: Strings.emptyString,
                              color: AppTheme.colorblack38,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  drawr() {
    return Padding(
      padding: const EdgeInsets.only(left: Constant.drawerLeftPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: Constant.profileTileTopPadding),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: Constant.accountCirccleImageRadius1,
                  child: Image(
                      image: AssetImage(
                    imageUser,
                  )),
                ),
                const SizedBox(
                  width: Constant.SIZE20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: Strings.dhavalRana,
                      fontfamily: Strings.emptyString,
                      fontWight: FontWeight.w400,
                      fontSize: Constant.profileNameTitleSize,
                    ),
                    InkWell(
                      onTap: () {},
                      child: CustomText(
                        title: Strings.viewMyProfile,
                        height: Constant.viewMyProfileTitleHeight,
                        fontfamily: Strings.emptyString,
                        color: AppTheme.themeColor,
                        fontSize: Constant.profileNameSubTitleSize,
                        fontWight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: Strings.settings,
                topPadding: Constant.settingTitleTopPadding,
                bottomPadding: Constant.settingTileTitleBottomPadding,
                fontSize: Constant.settingTitleSize,
                fontWight: FontWeight.w500,
                fontfamily: Strings.emptyString,
              ),
              settingTile(title: Strings.personalInformation),
              settingTile(title: Strings.myBookings),
              settingTile(title: Strings.myMessages),
              settingTile(title: Strings.payment),
              settingTile(title: Strings.groups),
              settingTile(title: Strings.notifications),
              settingTile(title: Strings.refer),
              settingTile(title: Strings.helpCenter),
            ],
          )
        ],
      ),
    );
  }

  settingTile({required String title, bool isFirst = false}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isFirst
            ? Container()
            : Container(
                height: Constant.settingTileDividerHeight,
                color: AppTheme.greyColor
                    .withOpacity(Constant.settingTileDividerColorOpacity),
              ),
        CustomText(
          topPadding: Constant.settingTileTitleTopPadding,
          title: title,
          color: AppTheme.colorblack87,
          fontfamily: Strings.emptyString,
          fontWight: FontWeight.w400,
          fontSize: Constant.settingTileSize,
          bottomPadding: Constant.settingTileTitleBottomPadding,
        ),
      ],
    );
  }

  skeleton() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constant.zero)),
      child: Container(
        margin: const EdgeInsets.all(Constant.skelatonContainerMargin),
        padding: const EdgeInsets.all(Constant.skelatonContainerPadding),
        decoration: BoxDecoration(
            color: AppTheme.productTileColor,
            borderRadius: BorderRadius.circular(Constant.zero)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(Constant.profileTileMargin),
                padding: const EdgeInsets.all(Constant.THREE),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Constant.zero)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        shimmerTile(
                            height: height * Constant.skelatonImageHight,
                            width: width)
                      ],
                    ),
                    const SizedBox(
                      width: Constant.SIZE15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: Constant.skelatonLeftPadding,
                          top: Constant.skelatonTopPadding),
                      child: SizedBox(
                        width: width * Constant.skelatonTitleBoxWidth,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            shimmerTile(
                                height: Constant.skelatonTitleshimmerHight,
                                width:
                                    width * Constant.skelatonTitleshimmerWidth),
                            const SizedBox(
                              height: Constant.skelatonTitleSpace,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                shimmerTile(
                                    height: Constant.skelatonTitleshimmerHight,
                                    width: width *
                                        Constant.skelatonTitle2shimmerWidth),
                                const SizedBox(
                                  height: Constant.skelatonTitleshimmerSpace,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: Constant.SIZE15,
              ),
            ]),
      ),
    );
  }
}
