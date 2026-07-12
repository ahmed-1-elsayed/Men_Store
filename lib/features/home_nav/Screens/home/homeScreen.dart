import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/app_colors.dart';
import '../../../../core/helper/app_style.dart';
import '../../../details_screen/details_screen.dart';
import '../../../widgets/product_card.dart';
import '../../Controller/category/categories_cubit.dart';
import '../../Controller/category/categories_state.dart';
import '../../Controller/product/home_cubit.dart';
import '../../Controller/product/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()..getProducts()),
        BlocProvider(create: (_) => CategoriesCubit()..getCategories()),
      ],
      child:  _HomeBody(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body:  SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text("Discover", style: AppStyles.title),
              SizedBox(height: 20),
              _SearchFilterBar(),
              SizedBox(height: 20),
              _CategoriesList(),
              SizedBox(height: 20),
              Expanded(child: _ProductsGrid()),
            ],
          ),
        ),
      ),
    );
  }
}

class _SearchFilterBar extends StatelessWidget {
  const _SearchFilterBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 52,
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon:  Icon(Icons.search),
                filled: true,
                fillColor: AppColors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:  BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:  BorderSide(color: AppColors.primary),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child:  Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }
}

class _CategoriesList extends StatelessWidget {
  const _CategoriesList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, categoryState) {
          if (categoryState is CategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (categoryState is CategoriesFailure) {
            return Center(child: Text(categoryState.message));
          }

          if (categoryState is CategoriesSuccess) {
            return BlocBuilder<HomeCubit, HomeState>(
              builder: (context, homeState) {
                final selectedCategory = context
                    .read<HomeCubit>()
                    .selectedCategory;

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryState.categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return _CategoryChip(
                        title: "All",
                        selected: selectedCategory == 0,
                        onTap: () {
                          context.read<HomeCubit>().getProducts();
                        },
                      );
                    }

                    final category = categoryState.categories[index - 1];

                    return _CategoryChip(
                      title: category.name,
                      selected: selectedCategory == category.id,
                      onTap: () {
                        context.read<HomeCubit>().getProductsByCategory(
                          category.id,
                        );
                      },
                    );
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.border,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: selected ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  const _ProductsGrid();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is HomeFailure) {
          return Center(child: Text(state.message));
        }

        if (state is HomeSuccess) {
          return GridView.builder(
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: .62,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];

              return ProductCard(
                product: product,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailsScreen(product: product),
                    ),
                  );
                },
              );
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
