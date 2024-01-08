import 'package:news/util/constants.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class SplashController extends GetxController {
  double? height;
  double? width;
  @override
  void onInit() {
    Future.delayed(
        const Duration(
          seconds: Constant.INT_TWO,
        ), () {
      Get.offAllNamed(AppRoute.PRODUCT);
    });

    super.onInit();
  }
}
