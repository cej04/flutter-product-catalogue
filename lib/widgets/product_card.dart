

import 'package:buylike/models/product_model.dart';
import 'package:buylike/themes/app_theme.dart';
import 'package:flutter/material.dart';


// Reusable product card widget
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;

  const ProductCard({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Card body
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              boxShadow: const [BoxShadow(color: AppColors.shadowColor, blurRadius: 4)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.sm)),
                    child: Container(
                      color: AppColors.imageBg,
                      width: double.infinity,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stack) =>
                            const Icon(Icons.broken_image, size: 48, color: AppColors.iconGrey),
                      ),
                    ),
                  ),
                ),
                // Product info
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.productTitle,
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AppTextStyles.productPrice,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.ratingOrange,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(AppRadius.sm),
                  bottomLeft: Radius.circular(AppRadius.badge),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: AppTextStyles.ratingBadge,
                  ),
                  const SizedBox(width: 2),
                  const Icon(Icons.star, color: Colors.white, size: 11),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
