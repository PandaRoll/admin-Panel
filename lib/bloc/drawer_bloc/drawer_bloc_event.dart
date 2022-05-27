part of 'drawer_bloc.dart';

@immutable
abstract class DrawerBlocEvent {}

class NavigateTo extends DrawerBlocEvent {
  final String destination;
  NavigateTo(this.destination);
}
