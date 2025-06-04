import 'package:bloc/bloc.dart';
import 'package:hekayaty/data/model/utils/error_model.dart';
import 'package:meta/meta.dart';

import '../../data/model/login_model/login_model.dart';
import '../../data/repository/login_repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository repository;
  LoginCubit(this.repository) : super(LoginInitial());
  Future<void> checkId(String userName, password) async{
    try{
      emit(LoginLoading());
      LoginModel token = await repository.login(userName, password);
      if(!isClosed) {
        emit(LoginComplete(token,));
      }
    }catch(ex){
      if(ex is ErrorModel){
        if(!isClosed) {
          emit(LoginError(ex));
        }
      }else{
        if(!isClosed) {
          emit(LoginError(
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
