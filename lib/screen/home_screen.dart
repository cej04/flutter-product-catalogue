

import 'package:buylike/provider/provider.dart';
import 'package:buylike/screen/product_list_screen.dart';
import 'package:buylike/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


//home screen with search bar and category grid. Fetches categories from API and displays in a grid. Tapping a category navigates to the product list screen for that category.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _categoryIcons = {
    'beauty': Icons.face_retouching_natural,
    'fragrances': Icons.spa,
    'furniture': Icons.chair,
    'groceries': Icons.shopping_basket,
    'home-decoration': Icons.home,
    'kitchen-accessories': Icons.kitchen,
    'laptops': Icons.laptop,
    'mens-shirts': Icons.checkroom,
    'mens-shoes': Icons.directions_walk,
    'mens-watches': Icons.watch,
    'mobile-accessories': Icons.headset,
    'motorcycle': Icons.two_wheeler,
    'skin-care': Icons.spa,
    'smartphones': Icons.smartphone,
    'sports-accessories': Icons.sports_basketball,
    'sunglasses': Icons.wb_sunny,
    'tablets': Icons.tablet,
    'tops': Icons.style,
    'vehicle': Icons.directions_car,
    'womens-bags': Icons.shopping_bag,
    'womens-dresses': Icons.woman,
    'womens-jewellery': Icons.diamond,
    'womens-shoes': Icons.directions_walk,
    'womens-watches': Icons.watch,
  };

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().loadCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: AppColors.appBarBg,
        elevation: 1,
        title: const Text('BuyLike', style: AppTextStyles.appBarTitle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProductListScreen(
                    categorySlug: null,
                    title: 'All Products',
                  ),
                ),
              ),
              child: Container(
                margin: const EdgeInsets.all(AppSpacing.md),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(AppRadius.xs),
                  boxShadow: const [BoxShadow(color: AppColors.shadowColor, blurRadius: 4)],
                ),
                child: Row(
                  children: const [
                    Icon(Icons.search, color: AppColors.iconGrey),
                    SizedBox(width: AppSpacing.sm),
                    Text('Search products...', style: AppTextStyles.searchHint),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Text('Product Categories', style: AppTextStyles.sectionHeader),
            ),
            Consumer<ProductProvider>(
              builder: (ctx, provider, _) {
                if (provider.loading) {
                  return const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (provider.error != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Text('Error: ${provider.error}'),
                    ),
                  );
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.xs,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: AppSpacing.sm,
                    mainAxisSpacing: AppSpacing.sm,
                  ),
                  itemCount: provider.categories.length,
                  itemBuilder: (ctx, i) {
                    final cat = provider.categories[i];
                    return _CategoryTile(
                      label: cat.name,
                      icon: _categoryIcons[cat.slug] ?? Icons.category,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductListScreen(
                            categorySlug: cat.slug,
                            title: cat.name,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppRadius.md),
          boxShadow: const [BoxShadow(color: AppColors.shadowColor, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: AppColors.primary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.categoryLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
