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
