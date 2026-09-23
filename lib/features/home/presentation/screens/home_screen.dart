import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_error.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../products/presentation/widgets/hero_banner.dart';
import '../../../products/presentation/widgets/product_item_card.dart';
import '../../../products/presentation/widgets/section_header.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const AppLoader(message: 'Loading store with BLoC...');
          } else if (state is HomeError) {
            return AppError(
              message: state.message,
              onRetry: () =>
                  context.read<HomeBloc>().add(FetchHomeFeedEvent()),
            );
          } else if (state is HomeLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Hero Banner
                  const HeroBanner(),
                  const SizedBox(height: 24),

                  // Sale Section Header
                  SectionHeader(
                    title: 'Sale',
                    subtitle: 'Super summer sale',
                    onViewAll: () {},
                  ),
                  const SizedBox(height: 16),

                  // Sale Products Horizontal Scroll
                  SizedBox(
                    height: 270,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.saleProducts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final item = state.saleProducts[index];
                        return ProductItemCard(
                          product: item,
                          onTap: () {
                            context.push('/product/${item.id}');
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  // New Section Header
                  SectionHeader(
                    title: 'New',
                    subtitle: "You've never seen it before!",
                    onViewAll: () {},
                  ),
                  const SizedBox(height: 16),

                  // New Products Horizontal Scroll
                  SizedBox(
                    height: 270,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.newProducts.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        final item = state.newProducts[index];
                        return ProductItemCard(
                          product: item,
                          onTap: () {
                            context.push('/product/${item.id}');
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
