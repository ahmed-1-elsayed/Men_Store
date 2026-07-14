import '../../../../models/product_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<ProductModel> products;
  final int selectedCategory;

  HomeSuccess({required this.products, required this.selectedCategory});
}

class HomeFailure extends HomeState {
  final String message;

  HomeFailure(this.message);
}
