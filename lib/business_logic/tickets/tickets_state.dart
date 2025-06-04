part of 'tickets_cubit.dart';

@immutable
sealed class TicketsState {}

final class TicketsInitial extends TicketsState {}
class OrderLoading extends TicketsState {}
class OrderComplete extends TicketsState {
  final  ConfirmationModel model;
  OrderComplete(this.model);
}
class OrderError extends TicketsState {
  final ErrorModel err;
  OrderError(this.err);
}
class GetSubCategoryLoading extends TicketsState {}
class GetSubCategoryComplete extends TicketsState {
  final List<SubCategories>model;
  GetSubCategoryComplete(this.model);
}
class GetSubCategoryError extends TicketsState {
  final ErrorModel err;
  GetSubCategoryError(this.err);
}
