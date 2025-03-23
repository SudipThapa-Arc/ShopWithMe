import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/borders.dart';
import 'package:shopwithme/design_system/cards.dart';


class ReviewsScreen extends StatefulWidget {
  final String productId;
  final String productName;

  const ReviewsScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String _selectedFilter = 'All';
  final List<String> _filters = ['All', '5★', '4★', '3★', '2★', '1★', 'With Photos'];

  Widget _buildRatingDistribution() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '4.5',
              style: AppTypography.headlineLarge,
            ),
            SizedBox(width: Spacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, (index) => 
                    Icon(
                      Icons.star,
                      size: 16,
                      color: index < 4 ? AppColors.warning : AppColors.border,
                    )
                  ),
                ),
                Text(
                  '2,458 reviews',
                  style: AppTypography.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: Spacing.md),
        Column(
          children: List.generate(5, (index) {
            final rating = 5 - index;
            final percentage = [0.65, 0.2, 0.1, 0.03, 0.02][index];
            return Padding(
              padding: EdgeInsets.only(bottom: Spacing.xs),
              child: Row(
                children: [
                  Text(
                    '$rating★',
                    style: AppTypography.bodyMedium,
                  ),
                  SizedBox(width: Spacing.sm),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: AppBorders.roundedSm,
                      child: LinearProgressIndicator(
                        value: percentage,
                        backgroundColor: AppColors.border,
                        valueColor: AlwaysStoppedAnimation<Color>(AppColors.warning),
                        minHeight: 8,
                      ),
                    ),
                  ),
                  SizedBox(width: Spacing.sm),
                  Text(
                    '${(percentage * 100).toInt()}%',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildReviewCard({
    required String userName,
    required double rating,
    required String comment,
    required DateTime date,
    List<String>? photos,
  }) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  userName[0].toUpperCase(),
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
              SizedBox(width: Spacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTypography.labelLarge,
                    ),
                    Row(
                      children: [
                        ...List.generate(5, (index) => Icon(
                          Icons.star,
                          size: 16,
                          color: index < rating ? AppColors.warning : AppColors.border,
                        )),
                        SizedBox(width: Spacing.sm),
                        Text(
                          '${date.day}/${date.month}/${date.year}',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: Spacing.sm),
          Text(
            comment,
            style: AppTypography.bodyMedium,
          ),
          if (photos != null && photos.isNotEmpty) ...[
            SizedBox(height: Spacing.sm),
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: photos.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: Spacing.xs),
                    child: ClipRRect(
                      borderRadius: AppBorders.roundedSm,
                      child: Image.network(
                        photos[index],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reviews',
              style: AppTypography.titleLarge,
            ),
            Text(
              widget.productName,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: EdgeInsets.all(Spacing.md),
            child: _buildRatingDistribution(),
          ),
          Container(
            height: 48,
            margin: EdgeInsets.symmetric(vertical: Spacing.sm),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: Spacing.md),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: EdgeInsets.only(right: Spacing.xs),
                  child: FilterChip(
                    selected: isSelected,
                    label: Text(filter),
                    onSelected: (selected) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    backgroundColor: AppColors.surface,
                    selectedColor: AppColors.primary.withOpacity(0.1),
                    checkmarkColor: AppColors.primary,
                    labelStyle: AppTypography.bodyMedium.copyWith(
                      color: isSelected ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(Spacing.md),
              itemCount: 10, // Replace with actual review count
              itemBuilder: (context, index) {
                // Mock data - replace with actual reviews
                return Padding(
                  padding: EdgeInsets.only(bottom: Spacing.md),
                  child: _buildReviewCard(
                    userName: 'User ${index + 1}',
                    rating: 4 + (index % 2),
                    comment: 'This is a great product! The quality is excellent and it arrived quickly.',
                    date: DateTime.now().subtract(Duration(days: index * 2)),
                    photos: index % 3 == 0 ? [
                      'https://picsum.photos/200',
                      'https://picsum.photos/201',
                    ] : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement write review functionality
        },
        backgroundColor: AppColors.primary,
        label: Text(
          'Write a Review',
          style: AppTypography.labelLarge.copyWith(
            color: AppColors.onPrimary,
          ),
        ),
        icon: Icon(Icons.rate_review, color: AppColors.onPrimary),
      ),
    );
  }
} 