import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/helper/app_colors.dart';
import '../../core/helper/app_style.dart';
import '../../core/helper/loading_helper.dart';
import '../home_nav/Controller/location/location_cubit.dart';
import '../home_nav/Controller/location/location_state.dart';
import '../widgets/location.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit()..getLocations(),
      child: Scaffold(
        backgroundColor: AppColors.white,

        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "address".tr(),
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

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("savedAddress".tr(), style: AppStyles.label),

              const SizedBox(height: 20),

              Expanded(
                child: BlocBuilder<LocationCubit, LocationState>(
                  builder: (context, state) {
                    if (state is LocationLoading) {
                      return LoadingHelper.centered();
                    }

                    if (state is LocationFailure) {
                      return Center(child: Text(state.message));
                    }

                    if (state is LocationSuccess) {
                      return ListView.builder(
                        itemCount: state.locations.length,
                        itemBuilder: (context, index) {
                          final location = state.locations[index];

                          return AddressCard(
                            title: location.name,
                            description: location.description,
                            isDefault: index == 0,
                          );
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
