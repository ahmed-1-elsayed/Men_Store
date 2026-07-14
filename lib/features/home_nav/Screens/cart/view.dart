import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/app_colors.dart';
import '../../../../core/helper/app_style.dart';
import '../../../../core/helper/loading_helper.dart';
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

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
          "myCart".tr(),
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
              return LoadingHelper.centered();
            }

            if (state is CartFailure) {
              return Center(child: Text(state.message));
            }

            if (state is CartSuccess) {
              final cart = state.cart;

              if (cart.products.isEmpty) {
                return Center(
                  child: Text("emptyCart".tr(), style: AppStyles.label),
                );
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      itemCount: cart.products.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 15),
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
                    "subTotal".tr(),
                    "\$ ${cart.total.toStringAsFixed(2)}",
                  ),

                  const SizedBox(height: 10),

                  _priceRow("vat".tr(), "\$ 0.00"),

                  const SizedBox(height: 10),

                  _priceRow("shippingFee".tr(), "\$ 80.00"),

                  const Divider(),

                  _priceRow(
                    "total".tr(),
                    "\$ ${(cart.total + 80).toStringAsFixed(2)}",
                    isTotal: true,
                  ),

                  const SizedBox(height: 20),

                  AppButton(text: "goToCheckout".tr(), onPressed: () {}),
                ],
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _priceRow(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: isTotal ? AppStyles.label : AppStyles.footer),
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
