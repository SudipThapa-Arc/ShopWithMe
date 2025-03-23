import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/design_system/colors.dart';
import 'package:shopwithme/design_system/typography.dart';
import 'package:shopwithme/design_system/spacing.dart';
import 'package:shopwithme/design_system/buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLastPage = false;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: Icons.shopping_bag_outlined,
      title: 'Discover Latest Trends',
      description: 'Explore a wide range of products from top brands and stay up to date with the latest fashion trends.',
      backgroundColor: AppColors.primary.withOpacity(0.1),
      imageBackgroundColor: AppColors.primary.withOpacity(0.2),
    ),
    OnboardingPage(
      icon: Icons.verified_user_outlined,
      title: 'Shop with Confidence',
      description: 'Secure payments, reliable shipping, and hassle-free returns make your shopping experience seamless.',
      backgroundColor: AppColors.success.withOpacity(0.1),
      imageBackgroundColor: AppColors.success.withOpacity(0.2),
    ),
    OnboardingPage(
      icon: Icons.card_giftcard,
      title: 'Earn Rewards',
      description: 'Get exclusive offers, earn points on every purchase, and enjoy member-only benefits.',
      backgroundColor: AppColors.warning.withOpacity(0.1),
      imageBackgroundColor: AppColors.warning.withOpacity(0.2),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
        _isLastPage = _currentPage == _pages.length - 1;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('has_seen_onboarding', true);
    Get.offAllNamed('/home');
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: Spacing.xs),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index 
              ? AppColors.primary 
              : AppColors.primary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                color: page.backgroundColor,
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Container(
                        width: 280,
                        height: 280,
                        padding: EdgeInsets.all(Spacing.lg),
                        decoration: BoxDecoration(
                          color: page.imageBackgroundColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          page.icon,
                          size: 100,
                          color: AppColors.primary,
                        ),
                      ),
                      SizedBox(height: Spacing.xl),
                      Text(
                        page.title,
                        style: AppTypography.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Spacing.md),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Spacing.xl),
                        child: Text(
                          page.description,
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              );
            },
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Spacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _completeOnboarding,
                    child: Text(
                      'Skip',
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(Spacing.lg),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildPageIndicator(),
                  SizedBox(height: Spacing.lg),
                  AppButton(
                    text: _isLastPage ? 'Get Started' : 'Next',
                    onPressed: _isLastPage
                        ? _completeOnboarding
                        : () {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color imageBackgroundColor;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.imageBackgroundColor,
  });
} 