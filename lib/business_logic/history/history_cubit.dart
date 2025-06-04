import 'package:bloc/bloc.dart';
import 'package:hekayaty/data/model/utils/error_model.dart';
import 'package:hekayaty/data/repository/history/history_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/history_model/history_model.dart';

part 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  HistoryRepository repository;
  HistoryCubit(this.repository) : super(HistoryInitial());
  Future<void> get() async{
    try{
      emit(GetHistoryLoading());
      List<HistoryModel> status = await repository.get();
      if(!isClosed) {
        emit(GetHistoryComplete(status));
      }
    }catch(ex){
      if(ex is ErrorModel){
        if(!isClosed) {
          emit(HistoryError(ex));
        }
      }else{
        if(!isClosed) {
          emit(HistoryError(
              ErrorModel(
                  status: 400,
                  message: "Something went wrong"
              )
          ));
        }
      }
    }

  }
}
