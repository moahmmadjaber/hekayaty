import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/school_supply/school_supply.dart';

part 'school_supply_state.dart';

class SchoolSupplyCubit extends Cubit<SchoolSupplyState> {
  SchoolSupplyRepository repository;
  SchoolSupplyCubit(this.repository) : super(SchoolSupplyInitial());
}
