import 'package:news/Pages/Home/home.dart';
import 'package:news/Pages/Home/headlinesDetails.dart';
import 'package:news/Pages/Splash/splash.dart';
import 'package:news/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static var list = [
    GetPage(name: AppRoute.SPLASH, page: () => const Splash()),
    GetPage(name: AppRoute.PRODUCT, page: () => const Product()),
    GetPage(name: AppRoute.PRODUCT_DETAIL, page: () => const HeadlinesDetail()),
  ];
}
