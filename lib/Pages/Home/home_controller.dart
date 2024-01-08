import 'package:news/Pages/Home/Provider/product_provider.dart';
import 'package:news/theme/app_theme.dart';
import 'package:news/util/constants.dart';
import 'package:news/webservices/response_model.dart';
import 'package:news/widgets/sanckbar.dart';
import 'package:get/get.dart';
import 'Response/product_response.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getProduct();
    super.onInit();
  }

  NewsResponse newsResponse = NewsResponse();
  void getProduct() async {
    ProductProvider().productProvider(
        onSuccess: (ResponseModel response) async {
      if (response.statusCode == Constant.statusCode200) {
        try {
          newsResponse = NewsResponse.fromJson(response.result);
          update();
        } catch (e) {
          snackbar(e.toString(), AppTheme.colorRed);
        }
      } else {
        print("hello");
      }
    });
  }
}
