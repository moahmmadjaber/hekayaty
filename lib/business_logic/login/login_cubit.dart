import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/login_repository/login_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository repository;
  LoginCubit(this.repository) : super(LoginInitial());
}
