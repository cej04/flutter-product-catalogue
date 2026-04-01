

import 'package:buylike/models/product_model.dart';
import 'package:buylike/provider/provider.dart';
import 'package:buylike/screen/product_details_screen.dart';
import 'package:buylike/themes/app_theme.dart';
import 'package:buylike/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//product list screen with search, filter, and infinite scroll features. Displays products in a grid and allows viewing details in a modal.
class ProductListScreen extends StatefulWidget {
  final String? categorySlug;
  final String title;

  const ProductListScreen({super.key, required this.categorySlug, required this.title});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<ProductProvider>();
      provider.clearFilters();
      provider.loadProducts(categorySlug: widget.categorySlug);
    });
  }

  void _onScroll() {
    // Trigger load more when within 200px of the bottom
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ProductProvider>().loadMore();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _showFilterSheet(BuildContext context) {
    final provider = context.read<ProductProvider>();
    double? minPrice = provider.minPrice;
    double? maxPrice = provider.maxPrice;
    double? minRating = provider.minRating;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) => Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filters', style: AppTextStyles.filterTitle),
              const SizedBox(height: AppSpacing.lg),
              const Text('Min Price (\$)', style: AppTextStyles.filterLabel),
              Slider(
                value: minPrice ?? 0,
                min: 0,
                max: 1000,
                divisions: 20,
                label: '\$${(minPrice ?? 0).toStringAsFixed(0)}',
                onChanged: (v) => setModalState(() => minPrice = v == 0 ? null : v),
              ),
              const Text('Max Price (\$)', style: AppTextStyles.filterLabel),
              Slider(
                value: maxPrice ?? 1000,
                min: 0,
                max: 1000,
                divisions: 20,
                label: '\$${(maxPrice ?? 1000).toStringAsFixed(0)}',
                onChanged: (v) => setModalState(() => maxPrice = v == 1000 ? null : v),
              ),
              const Text('Min Rating', style: AppTextStyles.filterLabel),
              Slider(
                value: minRating ?? 0,
                min: 0,
                max: 5,
                divisions: 10,
                label: '${(minRating ?? 0).toStringAsFixed(1)}★',
                onChanged: (v) => setModalState(() => minRating = v == 0 ? null : v),
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        provider.clearFilters();
                        Navigator.pop(ctx);
                      },
                      child: const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        provider.setFilters(min: minPrice, max: maxPrice, rating: minRating);
                        Navigator.pop(ctx);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProductDetail(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (_) => ProductDetailScreen(product: product),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBg,
        elevation: 1,
        title: Text(widget.title, style: AppTextStyles.appBarTitle),
        iconTheme: const IconThemeData(color: AppColors.textDark),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterSheet(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(AppSpacing.sm + 2),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search in ${widget.title}...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          context.read<ProductProvider>().setSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.cardBg,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (v) {
                setState(() {});
                context.read<ProductProvider>().setSearch(v);
              },
            ),
          ),
          // Product grid
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (ctx, provider, _) {
                if (provider.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.error != null) {
                  return Center(child: Text('Error: ${provider.error}'));
                }
                if (provider.products.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                // Extra item at the end for the loading indicator
                final itemCount = provider.products.length + (provider.hasMore ? 1 : 0);

                return GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm + 2,
                    vertical: AppSpacing.xs,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.68,
                    crossAxisSpacing: AppSpacing.sm + 2,
                    mainAxisSpacing: AppSpacing.sm + 2,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (ctx, i) {
                    // Last slot = loading spinner spanning both columns
                    if (i >= provider.products.length) {
                      return const _LoadingTile();
                    }
                    return ProductCard(
                      product: provider.products[i],
                      onTap: () => _showProductDetail(context, provider.products[i]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Full-width loading indicator shown as the last grid item.
class _LoadingTile extends StatelessWidget {
  const _LoadingTile();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.lg),
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
