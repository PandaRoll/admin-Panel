import 'package:admin/screens/dashboard/components/form.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../screens/dashboard/components/ui.dart';

part 'drawer_bloc_event.dart';
part 'drawer_bloc_state.dart';

class DrawerBloc extends Bloc<DrawerBlocEvent, DrawerBlocState> {
  DrawerBloc() : super(DrawerBlocInitial()) {
    on<DrawerBlocEvent>((event, emit) async {
      emit(DrawerBlocInitial());
      try {
        if (event is NavigateTo) {
          emit(DrawerBlocSuccessState(
              event.destination, widgetPusher(event.destination, null)));
        }
      } catch (e) {
        // emit(ChapterDetailsErrorState(e.toString(),event.courseId,event.videoId));
      }
    });
  }

  Widget widgetPusher(String routename, dynamic arguments) {
    switch (routename) {
      case "Grid":
        return UI(
          title: 'UI',
        );
      case "form":
        return AllFieldsV1(title: "title");
      default:
        return DashboardScreen();
    }
  }
}
