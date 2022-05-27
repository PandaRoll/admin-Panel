part of 'drawer_bloc.dart';

class DrawerBlocInitial extends DrawerBlocState {}

@immutable
abstract class DrawerBlocState {}

class DrawerBlocSuccessState extends DrawerBlocState {
  final String selectedItem;

  final Widget page;

  DrawerBlocSuccessState(this.selectedItem,this.page);
}
