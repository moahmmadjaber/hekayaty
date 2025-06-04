import 'package:bloc/bloc.dart';
import 'package:hekayaty/data/model/categories_model/categories_model.dart';
import 'package:hekayaty/data/model/utils/error_model.dart';
import 'package:meta/meta.dart';

import '../../data/repository/home/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());
  Future<void> checkIsActive() async{
    try{
      emit(HomeLoading());
      bool status = await repository.checkIsActive();
      if(!isClosed) {
        emit(CheckIsActiveComplete(status));
      }
    }catch(ex){
      if(ex is ErrorModel){
        if(!isClosed) {
          emit(HomeError(ex));
        }
      }else{
        if(!isClosed) {
          emit(HomeError(
              ErrorModel(
                  status: 400,
                  message: "Something went wrong"
              )
          ));
        }
      }
    }

  }
  Future<void> getCategories() async{
    try{
      emit(HomeLoading());
      List<CategoriesModel> model = await repository.getCategories();
      if(!isClosed) {
        emit(GetCategoriesComplete(model));
      }
    }catch(ex){
      if(ex is ErrorModel){
        if(!isClosed) {
          emit(HomeError(ex));
        }
      }else{
        if(!isClosed) {
          emit(HomeError(
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
