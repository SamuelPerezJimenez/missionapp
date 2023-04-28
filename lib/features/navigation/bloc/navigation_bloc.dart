import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(UserNavigationState()) {
    on<NavigateToUserEvent>((event, emit) {
      emit(UserNavigationState());
    });
    on<NavigateToContactsEvent>((event, emit) {
      emit(ContactsNavigationState());
    });
  }
}
