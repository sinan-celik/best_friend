import 'package:best_friend/api/all_breeds_response.dart';
import 'package:best_friend/api/breed_url_response.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class ApiClient {
  String baseUrl = 'https://dog.ceo/api/';

  Future<AllBreedsResponse?> getAllBreeds() async {
    var response = await Dio().get('${baseUrl}breeds/list/all');

    if (response.statusCode == 200) {
      return AllBreedsResponse.fromJson(response.data);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<BreedUrlResponse?> getUrlByBreed(String breed) async {
    var response = await Dio().get('${baseUrl}breed/$breed/images/random');

    if (response.statusCode == 200) {
      return BreedUrlResponse.fromJson(response.data);
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<dynamic> getImage(String url, String breed) async {
  
    try {
      await Dio().download(
        url,
        '${(await getTemporaryDirectory()).path}/$breed.jpg',
      );
    } catch (exp) {
      print(exp);
    }
  }
}
