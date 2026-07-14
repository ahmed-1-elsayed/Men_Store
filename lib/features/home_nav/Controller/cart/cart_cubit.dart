import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/cart_get_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final Dio dio = Dio();

  Future<void> getCart() async {
    emit(CartLoading());

    try {
      final response = await dio.get("https://dummyjson.com/carts/user/1");

      final cart = CartModel.fromJson(response.data["carts"][0]);

      emit(CartSuccess(cart));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  Future<void> addToCart(int productId) async {
    try {
      await dio.post(
        "https://dummyjson.com/carts/add",
        data: {
          "userId": 1,
          "products": [
            {"id": productId, "quantity": 1},
          ],
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
