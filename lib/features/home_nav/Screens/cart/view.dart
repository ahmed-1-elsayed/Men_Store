import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/helper/app_style.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/cart_item.dart';
import '../../Controller/cart/cart_cubit.dart';
import '../../Controller/cart/cart_state.dart';




class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<CartCubit>().getCart();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,

      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "My Cart",
          style: AppStyles.label.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is CartFailure) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is CartSuccess) {
              final cart = state.cart;

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cart.products.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 15),
                      itemBuilder: (context, index) {
                        final item = cart.products[index];

                        return CartItem(
                          image: item.thumbnail,
                          title: item.title,
                          size: "L",
                          price: item.price,
                          quantity: item.quantity,
                          onAdd: () {},
                          onRemove: () {},
                          onDelete: () {},
                        );
                      },
                    ),
                  ),

                  const Divider(),

                  const SizedBox(height: 10),

                  _priceRow(
                    "Sub-total",
                    "\$ ${cart.total.toStringAsFixed(2)}",
                  ),

                  const SizedBox(height: 10),

                  _priceRow(
                    "VAT (%)",
                    "\$ 0.00",
                  ),

                  const SizedBox(height: 10),

                  _priceRow(
                    "Shipping fee",
                    "\$ 80.00",
                  ),

                  const Divider(),

                  _priceRow(
                    "Total",
                    "\$ ${(cart.total + 80).toStringAsFixed(2)}",
                    isTotal: true,
                  ),

                  const SizedBox(height: 20),

                  AppButton(
                    text: "Go To Checkout",
                    onPressed: () {},
                  ),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _priceRow(
      String title,
      String value, {
        bool isTotal = false,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: isTotal ? AppStyles.label : AppStyles.footer,
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 22 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}