part of 'school_supply_cubit.dart';

@immutable
sealed class SchoolSupplyState {}

final class SchoolSupplyInitial extends SchoolSupplyState {}
class OrderLoading extends SchoolSupplyState {}
class OrderComplete extends SchoolSupplyState {
  final  ConfirmationModel model;
  OrderComplete(this.model);
}
class OrderError extends SchoolSupplyState {
  final ErrorModel err;
  OrderError(this.err);
}
class GetSubCategoryLoading extends SchoolSupplyState {}
class GetSubCategoryComplete extends SchoolSupplyState {
  final SubCategories model;
  GetSubCategoryComplete(this.model);
}
class GetSubCategoryError extends SchoolSupplyState {
  final ErrorModel err;
  GetSubCategoryError(this.err);
}