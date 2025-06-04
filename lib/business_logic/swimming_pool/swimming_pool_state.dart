part of 'swimming_pool_cubit.dart';

@immutable
sealed class SwimmingPoolState {}

final class TicketsInitial extends SwimmingPoolState {}
class OrderLoading extends SwimmingPoolState {}
class OrderComplete extends SwimmingPoolState {
  final  ConfirmationModel model;
  OrderComplete(this.model);
}
class OrderError extends SwimmingPoolState {
  final ErrorModel err;
  OrderError(this.err);
}
class GetSubCategoryLoading extends SwimmingPoolState {}
class GetSubCategoryComplete extends SwimmingPoolState {
  final List<SubCategories>model;
  GetSubCategoryComplete(this.model);
}
class GetSubCategoryError extends SwimmingPoolState {
  final ErrorModel err;
  GetSubCategoryError(this.err);
}
