import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../models/product.dart';

/// Product card used in the "Featured Products" 2-column grid.
class ProductCard extends StatefulWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _liked = false;

  @override
  Widget build(BuildContext context) {
    final p = widget.product;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 4 / 5,
          child: Stack(
            fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  p.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.surfaceContainerHigh,
                    child: const Icon(Icons.image_outlined,
                        color: AppColors.outline),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => setState(() => _liked = !_liked),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _liked ? Icons.favorite : Icons.favorite_border,
                      size: 18,
                      color: _liked ? AppColors.error : AppColors.outline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          p.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              fontWeight: FontWeight.w600, color: AppColors.onSurface),
        ),
        Text(
          p.subtitle,
          style: const TextStyle(
              fontSize: 12, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 2),
        Text(
          '\$${p.price.toStringAsFixed(2)}',
          style: const TextStyle(
              fontWeight: FontWeight.w700, color: AppColors.primary),
        ),
      ],
    );
  }
}

/// Compact horizontal flash-sale card with a progress bar & strike-through
/// original price.
class FlashSaleCard extends StatelessWidget {
  final Product product;
  const FlashSaleCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: AppColors.surfaceContainerHigh,
                  child: const Icon(Icons.image_outlined,
                      color: AppColors.outline),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.w600, color: AppColors.onSurface),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                    fontWeight: FontWeight.w700, color: AppColors.primary),
              ),
              const SizedBox(width: 6),
              if (product.originalPrice != null)
                Text(
                  '\$${product.originalPrice!.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.outline,
                    decoration: TextDecoration.lineThrough,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (product.saleProgress ?? 0) / 100,
              minHeight: 4,
              backgroundColor: AppColors.surfaceContainerHigh,
              valueColor:
              const AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}