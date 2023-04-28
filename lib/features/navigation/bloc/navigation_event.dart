part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigateToUserEvent extends NavigationEvent {}

class NavigateToContactsEvent extends NavigationEvent {}
