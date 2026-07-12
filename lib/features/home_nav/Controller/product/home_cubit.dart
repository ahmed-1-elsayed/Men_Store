import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final Dio dio = Dio();

  int selectedCategory = 0;

  /// Get All Products
  Future<void> getProducts() async {
    emit(HomeLoading());

    selectedCategory = 0;

    try {
      final response = await dio.get(
        "https://api.escuelajs.co/api/v1/products",
      );

      final List<ProductModel> products =
      (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      emit(
        HomeSuccess(
          products: products,
          selectedCategory: selectedCategory,
        ),
      );
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  /// Filter Products By Category
  Future<void> getProductsByCategory(int categoryId) async {
    emit(HomeLoading());

    selectedCategory = categoryId;

    try {
      final response = await dio.get(
        "https://api.escuelajs.co/api/v1/products/?categoryId=$categoryId",
      );

      final List<ProductModel> products =
      (response.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      emit(
        HomeSuccess(
          products: products,
          selectedCategory: selectedCategory,
        ),
      );
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}