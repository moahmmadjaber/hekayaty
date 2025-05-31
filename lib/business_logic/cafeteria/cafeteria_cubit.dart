import 'package:bloc/bloc.dart';
import 'package:hekayaty/data/repository/cafeteria/cafeteria_repository.dart';
import 'package:meta/meta.dart';

part 'cafeteria_state.dart';

class CafeteriaCubit extends Cubit<CafeteriaState> {
  CafeteriaRepository repository;
  CafeteriaCubit(this.repository) : super(CafeteriaInitial());
}
