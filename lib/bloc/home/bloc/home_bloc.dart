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
    on<HomeEvent>((event, emit) async {
      // implement event handler
      if (event is FirstLoadEvent) {
        emit(FirstLoadState());
        //get data
        var allBreeds = await client.getAllBreeds();

        String temporaryPath = (await getTemporaryDirectory()).path;

        for (var element in allBreeds!.message!.entries) {
          var resp = await client.getUrlByBreed(element.key);
          //get and save temporary
          await client.getImage(resp!.message as String, element.key);

          list.add(BreedImage(
              element.key, resp.message!, '$temporaryPath/${element.key}.jpg'));
        }

        add(DataLoadedEvent());
        router.go('/');
      }

      if (event is DataLoadedEvent) {
        emit(DataLoadedState(list: list));
      }
    });
  }
}
