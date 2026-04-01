

import 'package:buylike/models/product_model.dart';
import 'package:buylike/themes/app_theme.dart';
import 'package:flutter/material.dart';

//product details screen displayed as a modal dialog when a product card is tapped. Shows image, title, price, rating, description, and an "Add to Cart" button.
class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: 40,
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Product image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.lg)),
                  child: Container(
                    height: 240,
                    width: double.infinity,
                    color: AppColors.imageBg,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stack) =>
                          const Icon(Icons.broken_image, size: 64, color: AppColors.iconGrey),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm + 2,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(AppRadius.chip),
                        ),
                        child: Text(
                          product.category.toUpperCase(),
                          style: AppTextStyles.categoryChip,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm + 2),
                      // Title
                      Text(product.title, style: AppTextStyles.detailTitle),
                      const SizedBox(height: AppSpacing.sm + 2),
                      // Price + Rating row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: AppTextStyles.detailPrice,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.sm,
                                  vertical: AppSpacing.xs,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.ratingOrange,
                                  borderRadius: BorderRadius.circular(AppRadius.badge),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      product.rating.toStringAsFixed(1),
                                      style: AppTextStyles.ratingDetail,
                                    ),
                                    const SizedBox(width: 3),
                                    const Icon(Icons.star, color: Colors.white, size: 13),
                                  ],
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm - 2),
                              Text(
                                '(${product.stock} in stock)',
                                style: const TextStyle(
                                  color: AppColors.textMuted,
                                  fontSize: AppFontSizes.body,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Divider(),
                      const SizedBox(height: AppSpacing.sm),
                      const Text('Description', style: AppTextStyles.detailDescriptionHeader),
                      const SizedBox(height: AppSpacing.sm - 2),
                      Text(product.description, style: AppTextStyles.detailDescriptionBody),
                      const SizedBox(height: AppSpacing.xl),
                      
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Add to Cart', style: AppTextStyles.addToCart),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
         
          Positioned(
            top: AppSpacing.sm,
            right: AppSpacing.sm,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: const BoxDecoration(
                  color: AppColors.cardBg,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: AppColors.closeButtonShadow, blurRadius: 4)],
                ),
                child: const Icon(Icons.close, size: 20, color: AppColors.textDark),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
