class BaseResponse {
  bool? success;
  String? message;
  String? errorMessage;
  String? accessToken;

  BaseResponse(
      {this.success, this.message, this.errorMessage, this.accessToken});

  BaseResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    errorMessage = json['errorMessage'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['errorMessage'] = this.errorMessage;
    data['accessToken'] = this.accessToken;
    return data;
  }
}
