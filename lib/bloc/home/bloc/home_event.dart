part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FirstLoadEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class DataLoadedEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class DataFilteredEvent extends HomeEvent {

  final String value;

  const DataFilteredEvent({required this.value});
  @override
  List<Object> get props => [value];
}

// class ClickTileEvent extends HomeEvent {
//   ClickTileEvent(this.name);
//   String name;

//   @override
//   List<Object> get props => [name];
// }
