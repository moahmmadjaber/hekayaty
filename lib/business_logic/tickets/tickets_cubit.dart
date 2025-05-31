import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/repository/tickets/tickets_repository.dart';

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  TicketsRepository repository;
  TicketsCubit(this.repository) : super(TicketsInitial());
}
