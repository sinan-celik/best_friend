class AllBreedsResponse {
  Map<String, List<String>>? message;

  String? status;

  AllBreedsResponse({this.message, this.status});

  AllBreedsResponse.fromJson(Map<String, dynamic> json) {
    message= <String, List<String>>{};
    json['message'].forEach((key, value) {
      // print(key);
      List<String> list = List.castFrom(value);
      message?[key] = list;
    });
   
    status = json['status'];
  }
}
