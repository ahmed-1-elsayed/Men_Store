import '../../../../models/location_model.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSuccess extends LocationState {
  final List<LocationModel> locations;

  LocationSuccess(this.locations);
}

class LocationFailure extends LocationState {
  final String message;

  LocationFailure(this.message);
}