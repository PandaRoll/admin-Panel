import 'package:admin/bloc/drawer_bloc/drawer_bloc.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => DrawerBloc(),
        child: Scaffold(
          key: context.read<MenuController>().scaffoldKey,
          drawer: SideMenu(),
          body: BlocBuilder<DrawerBloc, DrawerBlocState>(
            builder: (context, state) {
              if (state is DrawerBlocInitial) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // We want this side menu only for large screen
                    if (Responsive.isDesktop(context))
                      Expanded(
                        child: SideMenu(),
                      ),
                    Expanded(
                      flex: 5,
                      child: DashboardScreen(),
                    ),
                  ],
                );
              } else if (state is DrawerBlocSuccessState) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // We want this side menu only for large screen
                    if (Responsive.isDesktop(context))
                      Expanded(
                        child: SideMenu(),
                      ),
                    Expanded(
                      flex: 5,
                      child: state.page,
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
