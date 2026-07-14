import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/location_model.dart';
import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  final Dio dio = Dio();

  Future<void> getLocations() async {
    emit(LocationLoading());

    try {
      final response = await dio.get(
        "https://api.escuelajs.co/api/v1/locations",
      );

      final List<LocationModel> locations = (response.data as List)
          .map((e) => LocationModel.fromJson(e))
          .toList();

      emit(LocationSuccess(locations));
    } catch (e) {
      emit(LocationFailure(e.toString()));
    }
  }
}
