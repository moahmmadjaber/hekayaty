import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/categories_model/categories_model.dart';
import '../../data/model/confirmation_model/confirmation_model.dart';
import '../../data/model/utils/error_model.dart';
import '../../data/repository/swimming_pool/swimming_pool_repository.dart';
import '../../data/repository/tickets/tickets_repository.dart';

part 'swimming_pool_state.dart';

class SwimmingPoolCubit extends Cubit<SwimmingPoolState> {
  SwimmingPoolRepository repository;
  SwimmingPoolCubit(this.repository) : super(TicketsInitial());
  Future<void> order(List<SubCategories> order,discountPercentage,discountNote) async{
    try{
      emit(OrderLoading());
      ConfirmationModel model = await repository.order(order,discountPercentage,discountNote);
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
