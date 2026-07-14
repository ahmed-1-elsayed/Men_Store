import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/category_model.dart';
import 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  final Dio dio = Dio();

  Future<void> getCategories() async {
    emit(CategoriesLoading());

    try {
      final response = await dio.get(
        "https://api.escuelajs.co/api/v1/categories",
      );

      final List<CategoryModel> categories = (response.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      emit(CategoriesSuccess(categories));
    } catch (e) {
      emit(CategoriesFailure(e.toString()));
    }
  }
}
