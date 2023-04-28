import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../../authentication/presentation/pages/user_page.dart';
import '../../../navigation/bloc/navigation_bloc.dart';
import '../../../navigation/presentation/navigation_view.dart';
import 'contacts_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (_) => sl<NavigationBloc>(),
        ),
      ],
      child: Scaffold(
        body: BlocBuilder<NavigationBloc, NavigationState>(
          builder: (BuildContext context, NavigationState state) {
            if (state is UserNavigationState) {
              return const UserProfilePage();
            } else if (state is ContactsNavigationState) {
              return const ContactsPage();
            }
            return Container();
          },
        ),
        bottomNavigationBar: const NavigationView(),
      ),
    );
  }
}
