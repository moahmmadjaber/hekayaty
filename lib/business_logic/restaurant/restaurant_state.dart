part of 'restaurant_cubit.dart';

@immutable
sealed class RestaurantState {}

 class RestaurantInitial extends RestaurantState {}
class OrderLoading extends RestaurantState {}
class OrderComplete extends RestaurantState {
 final  ConfirmationModel model;
 OrderComplete(this.model);
}
class OrderError extends RestaurantState {
  final ErrorModel err;
  OrderError(this.err);
}
class GetSubCategoryLoading extends RestaurantState {}
class GetSubCategoryComplete extends RestaurantState {
 final List<SubCategories>model;
 GetSubCategoryComplete(this.model);
}
class GetSubCategoryError extends RestaurantState {
  final ErrorModel err;
  GetSubCategoryError(this.err);
}