import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mens_store/core/helper/app_colors.dart';
import 'package:mens_store/core/helper/app_style.dart';
import 'package:mens_store/models/product_model.dart';

import '../../core/helper/app_tost.dart';
import '../home_nav/Controller/cart/cart_cubit.dart';
import '../widgets/app_button.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Details",
          style: AppStyles.label.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Price", style: AppStyles.footer),
                  const SizedBox(height: 4),
                  Text(
                    "\$ ${product.price}",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 2,
              child: SizedBox(
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      await context.read<CartCubit>().addToCart(product.id);

                      showSnackBar(
                        context: context,
                        msg: "Added to cart ",
                        type: AnimatedSnackBarType.success,
                      );
                    } catch (e) {
                      showSnackBar(
                        context: context,
                        msg: "Failed to add to cart",
                        type: AnimatedSnackBarType.error,
                      );
                    }
                  },
                  icon: Icon(Icons.shopping_bag_outlined, color: Colors.white),
                  label: Text("Add to Cart", style: AppStyles.button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: double.infinity,
                height: 320,
                decoration: BoxDecoration(
                  color: const Color(0xffF5F5F5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.images.first,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(
              product.title,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Row(
              children: const [
                Icon(Icons.star, color: Colors.orange, size: 20),
                SizedBox(width: 4),
                Text("4.0/5 (45 reviews)"),
              ],
            ),

            const SizedBox(height: 20),

            Text(
              product.description,
              style: AppStyles.footer.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
