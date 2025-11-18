import 'package:flutter/material.dart';
import 'package:zero_one_z_task/core/shared/custom_text.dart';
import 'package:zero_one_z_task/core/theming/app_colors.dart';
import 'package:zero_one_z_task/features/home/data/models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onTap;

  const ProductItem({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String productImage = product.image;
    final String productTitle = product.title;
    final String productDescription = product.description;
    final bool hasOffer = product.hasOffer;
    final int? discountPercentage = product.discountPercentage;
    final bool hasMultipleImages = product.images.length > 1;
    final int imagesCount = product.images.length;
    final String formattedPrice = '${product.price} ج.م';
    final String? formattedOfferPrice = product.offerPrice != null
        ? '${product.offerPrice} ج.م'
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SizedBox(
          width: 170,
          height: 200,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: const Color(0xffF7FAFF),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Image
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          child: Image.network(
                            productImage,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: 100,
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress
                                                  .expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 100,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.broken_image,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                              );
                            },
                          ),
                        ),
                        // Multiple Images Indicator
                        if (hasMultipleImages)
                          Positioned(
                            top: 8,
                            left: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.photo_library,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '$imagesCount',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                    // Product Info
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Title
                            CustomText(
                              text: productTitle,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 4),
                            // Product Description
                            CustomText(
                              text: productDescription,
                              fontSize: 11,
                              color: const Color(0xff7A7E80),
                              maxLines: 2,
                              height: 1.3,
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Price Tag
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (hasOffer && formattedOfferPrice != null) ...[
                        // Discount Percentage
                        if (discountPercentage != null)
                          Text(
                            '-$discountPercentage%',
                            style: const TextStyle(
                              color: Color(0xffD946A6),
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        // Original Price (strikethrough)
                        Text(
                          formattedPrice,
                          style: const TextStyle(
                            fontSize: 9,
                            color: Color(0xffD946A6),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        // Offer Price
                        Text(
                          formattedOfferPrice,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffD946A6),
                          ),
                        ),
                      ] else ...[
                        // Regular Price
                        Text(
                          formattedPrice,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffD946A6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
