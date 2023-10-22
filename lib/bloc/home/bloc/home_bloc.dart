import 'package:best_friend/api/all_breeds_response.dart';
import 'package:best_friend/api/api_client.dart';
import 'package:best_friend/data/models/breed_image.dart';
import 'package:best_friend/router.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:path_provider/path_provider.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    ApiClient client = ApiClient();
    List<BreedImage> list = List.empty(growable: true);
    AllBreedsResponse? allBreeds;
    on<HomeEvent>((event, emit) async {
      // implement event handler
      if (event is FirstLoadEvent) {
        emit(FirstLoadState());
        //get data
        allBreeds = await client.getAllBreeds();

        String temporaryPath = (await getTemporaryDirectory()).path;

        List<Future> futureList = [];

        for (var element in allBreeds!.message!.entries) {
          futureList.add(getOne(client, list, temporaryPath, element.key));
        }

        await Future.wait(futureList);

        add(DataLoadedEvent());
        router.go('/');
      }

      if (event is DataLoadedEvent) {
        emit(DataLoadedState(list: list, allBreeds: allBreeds!, ));
      }

      // if (event is ClickTileEvent) {

      //   print('event.name ::' + event.name);

      //   emit(ClickTileState());
      // }
    });
  }

  Future getOne(ApiClient client, List<BreedImage> list, String temporaryPath,
      String key) async {
    print(key);
    print(DateTime.now());

    var resp = await client.getUrlByBreed(key);
    //get and save temporary
    await client.getImage(resp!.message as String, key);

    list.add(BreedImage(key, resp.message!, '$temporaryPath/$key.jpg'));
  }
}
