
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product_model.dart';



part  'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final Dio dio = Dio();

  Future<void> getProducts() async {
    emit(HomeLoading());

    try {
      final response = await dio.get(
        "https://api.escuelajs.co/api/v1/products",
      );

      final List products = response.data;

      final List<ProductModel> productList =
      products.map((e) => ProductModel.fromJson(e)).toList();

      emit(HomeSuccess(productList));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}