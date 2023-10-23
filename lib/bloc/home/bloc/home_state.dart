part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class FirstLoadState extends HomeState {}

final class DataLoadedState extends HomeState {
  final List<BreedImage> list;
  final AllBreedsResponse allBreeds;

  const DataLoadedState({required this.allBreeds, required this.list});

  @override
  List<Object> get props => [list];
}

final class DataFilteredState extends HomeState {
  final List<BreedImage> filteredList;
  final AllBreedsResponse allBreeds;

  const DataFilteredState({required this.allBreeds, required this.filteredList});

  @override
  List<Object> get props => [filteredList];
}


// final class ClickTileState extends HomeState {}
