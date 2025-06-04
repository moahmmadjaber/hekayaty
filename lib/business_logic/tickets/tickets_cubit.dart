import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/categories_model/categories_model.dart';
import '../../data/model/confirmation_model/confirmation_model.dart';
import '../../data/model/utils/error_model.dart';
import '../../data/repository/tickets/tickets_repository.dart';

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsRepository repository;
  TicketsCubit(this.repository) : super(TicketsInitial());
  Future<void> order(List<SubCategories> order,SubCategories flowerModel,int flowersCount,int childrenNo,int discount,String discountNote,String guardianName,String guardianContacts) async{
    try{
      emit(OrderLoading());
      ConfirmationModel model = await repository.order(order,flowerModel,flowersCount,childrenNo,discount,discountNote,guardianName,guardianContacts);
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
