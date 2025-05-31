import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/home/home_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository repository;

  HomeCubit(this.repository) : super(HomeInitial());
}
