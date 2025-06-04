part of 'cafeteria_cubit.dart';

@immutable
sealed class CafeteriaState {}

final class CafeteriaInitial extends CafeteriaState {}
class OrderLoading extends CafeteriaState {}
class OrderComplete extends CafeteriaState {
  final  ConfirmationModel model;
  OrderComplete(this.model);
}
class OrderError extends CafeteriaState {
  final ErrorModel err;
  OrderError(this.err);
}
class GetSubCategoryLoading extends CafeteriaState {}
class GetSubCategoryComplete extends CafeteriaState {
  final List<SubCategories>model;
  GetSubCategoryComplete(this.model);
}
class GetSubCategoryError extends CafeteriaState {
  final ErrorModel err;
  GetSubCategoryError(this.err);
}
