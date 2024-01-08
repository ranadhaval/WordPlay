import 'package:news/webservices/api_request.dart';
import 'package:news/webservices/response_model.dart';
import 'package:news/webservices/url_constants.dart';

class ProductProvider {
  void productProvider({
    Function()? beforeSend,
    Function(ResponseModel response)? onSuccess,
    Function(ResponseModel response)? onError,
  }) {
    ApiRequest(url: UrlConstants.NEWS_URL).getRequest(
        beforeSend: () => {if (beforeSend != null) beforeSend()},
        onSuccess: (data) {
          onSuccess!(data);
        },
        onError: (error) {
          print(error);
        });
  }
}
