part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

 class HomeInitial extends HomeState {}

class CheckIsActiveComplete extends HomeState {
  final bool status;
  CheckIsActiveComplete(this.status);
}
class HomeError extends HomeState {
  final ErrorModel err;
  HomeError(this.err);
}
class HomeLoading extends HomeState {}
class GetCategoriesComplete extends HomeState {
  final List<CategoriesModel>model;
  GetCategoriesComplete(this.model);
}
class GetCategoriesError extends HomeState {
 final ErrorModel err;
 GetCategoriesError(this.err);
}