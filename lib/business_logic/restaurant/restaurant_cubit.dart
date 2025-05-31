import 'package:bloc/bloc.dart';
import 'package:hekayaty/data/repository/restaurant/restaurant_repository.dart';
import 'package:meta/meta.dart';

part 'restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  RestaurantRepository repository;

  RestaurantCubit(this.repository) : super(RestaurantInitial());
}
