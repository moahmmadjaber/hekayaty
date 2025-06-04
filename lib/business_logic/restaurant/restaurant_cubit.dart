import 'package:bloc/bloc.dart';
import 'package:hekayaty/data/model/utils/error_model.dart';
import 'package:hekayaty/data/repository/restaurant/restaurant_repository.dart';
import 'package:meta/meta.dart';

import '../../data/model/categories_model/categories_model.dart';
import '../../data/model/confirmation_model/confirmation_model.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantRepository repository;

  RestaurantCubit(this.repository) : super(RestaurantInitial());
  Future<void> order(List<SubCategories> order) async{
    try{
      emit(OrderLoading());
      ConfirmationModel model = await repository.order(order);
      if(!isClosed) {
        emit(OrderComplete(model,));
      }
    }catch(ex){
      if(ex is ErrorModel){
        if(!isClosed) {
          emit(OrderError(ex));
        }
      }else{
        if(!isClosed) {
          emit(OrderError(
              ErrorModel(
                  status: 400,
                  message: "Something went wrong"
              )
          ));
        }
      }
    }

  }
  Future<void> orderComplete(orderId) async{
    try{

      ConfirmationModel model = await repository.orderComplete(orderId);
      if(!isClosed) {

      }
    }catch(ex){
      if(ex is ErrorModel){
        if(!isClosed) {

        }
      }else{
        if(!isClosed) {

        }
      }
    }

  }
  Future<void> getSubCategory(int  categoryId) async{
    try{
      emit(GetSubCategoryLoading());
      List<SubCategories> model = await repository.getSubCategory(categoryId);
      if(!isClosed) {
        emit(GetSubCategoryComplete(model,));
      }
    }catch(ex){
      if(ex is ErrorModel){
        if(!isClosed) {
          emit(OrderError(ex));
        }
      }else{
        if(!isClosed) {
          emit(OrderError(
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
