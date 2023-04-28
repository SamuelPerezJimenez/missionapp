import 'package:flutter/material.dart';

import '../bloc/navigation_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    return BlocBuilder<NavigationBloc, NavigationState>(
      bloc: navigationBloc,
      builder: (BuildContext context, NavigationState state) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contacts),
              label: 'Contactos',
            ),
          ],
          currentIndex: state is UserNavigationState ? 0 : 1,
          onTap: (index) {
            if (index == 0) {
              navigationBloc.add(NavigateToUserEvent());
            } else if (index == 1) {
              navigationBloc.add(NavigateToContactsEvent());
            }
          },
        );
      },
    );
  }
}
