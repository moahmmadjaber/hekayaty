part of 'history_cubit.dart';

@immutable
sealed class HistoryState {}

 class HistoryInitial extends HistoryState {}
 class GetHistoryLoading extends HistoryState {}
 class GetHistoryComplete extends HistoryState {
  final List<HistoryModel> model;
  GetHistoryComplete(this.model);
 }
 class HistoryError extends HistoryState {
  final ErrorModel err;
  HistoryError(this.err);}