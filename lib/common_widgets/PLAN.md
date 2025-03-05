E-COMMERCE APP ENHANCEMENT PROMPTS
================================

1. Core UI/UX Implementation Tasks
--------------------------------
CONTEXT:
Current app has basic UI components but needs polish and consistent design system.
See: home_screen.dart, category_screen.dart, cart_screen.dart

REQUIRED ACTIONS:
1.1. Loading States
    - Implement ShimmerLoading widget for:
      * Product grid items
      * Category list
      * Cart items
      * Search results
    - Add circular progress indicators for:
      * Button loading states
      * Image loading
      * Data fetching operations

1.2. Error Handling
    - Create custom error widgets for:
      * Network errors
      * Empty states
      * Form validation errors
    - Implement error boundaries
    - Add retry mechanisms
    - Show user-friendly error messages

1.3. Animations & Transitions
    - Add Hero animations for:
      * Product image transitions
      * Category transitions
    - Implement smooth page transitions
    - Add micro-interactions:
      * Button press effects
      * List item animations
      * Loading animations

2. Design System Implementation
-----------------------------
CONTEXT:
Implementing brand guide with SF Pro Display typography and specified color scheme.
See: constants/consts.dart, constants/styles.dart

REQUIRED ACTIONS:
2.1. Color System
    - Define brand colors:
      ```dart
      class AppColors {
        // Primary Colors
        static const primary = Color.fromRGBO(230, 46, 4, 1);  // Existing redColor as primary
        static const secondary = Color(0xFF020711);   // Black from brand guide
        static const neutral = Color(0xFFA4A8B5);     // Gray from brand guide
        
        // Semantic Colors
        static const success = Color(0xFF4CAF50);
        static const error = Color(0xFFE53935);
        static const warning = Color(0xFFFFB300);
        static const info = Color(0xFF2196F3);
        
        // Background Colors
        static const background = Color(0xFFF8F9FA);
        static const surface = Color(0xFFFFFFFF);
        
        // Text Colors
        static const textPrimary = Color(0xFF020711);
        static const textSecondary = Color(0xFFA4A8B5);
      }
      ```

2.2. Typography System
    - Implement SF Pro Display font family:
      ```dart
      class AppTypography {
        static const fontFamily = 'SF Pro Display';
        
        static const h1 = TextStyle(
          fontFamily: fontFamily,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.5,
          color: AppColors.textPrimary,
        );
        
        static const h2 = TextStyle(
          fontFamily: fontFamily,
          fontSize: 28,
          fontWeight: FontWeight.w500,  // Medium
          letterSpacing: -0.5,
        );
        
        static const body = TextStyle(
          fontFamily: fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,  // Regular
          letterSpacing: 0.15,
        );
        
        static const caption = TextStyle(
          fontFamily: fontFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
        );
      }
      ```

2.3. Font Weights
    - Define weight constants:
      ```dart
      class FontWeights {
        static const regular = FontWeight.w400;
        static const medium = FontWeight.w500;
        static const bold = FontWeight.w700;
      }
      ```

2.4. Spacing & Sizing System
    - Implement consistent spacing:
      ```dart
      class Spacing {
        // Base unit: 4dp
        static const xs = 4.0;    // Tiny spacing
        static const sm = 8.0;    // Small elements
        static const md = 16.0;   // Standard spacing
        static const lg = 24.0;   // Large sections
        static const xl = 32.0;   // Extra large gaps
        
        // Component specific
        static const buttonHeight = 48.0;
        static const inputHeight = 56.0;
        static const cardPadding = 16.0;
        static const sectionSpacing = 24.0;
      }
      ```

2.5. Border Radius
    - Define corner styles:
      ```dart
      class Corners {
        static const sm = 4.0;
        static const md = 8.0;
        static const lg = 16.0;
        static const full = 999.0;
      }
      ```

2.6. Elevation & Shadows
    - Implement consistent shadows:
      ```dart
      class Elevation {
        static const List<BoxShadow> low = [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ];
        
        static const List<BoxShadow> medium = [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ];
      }
      ```

2.7. Layout Grid
    - Define grid system:
      ```dart
      class Grid {
        static const double gutterWidth = 16.0;
        static const int columns = 12;
        static const double maxWidth = 1200.0;
      }
      ```

3. Component Enhancement
----------------------
CONTEXT:
Current components need standardization and enhancement.
See: common_widgets/, views/

REQUIRED ACTIONS:
3.1. Product Cards
    - Enhance ProductCard widget:
      * Add hover effects
      * Implement quick view
      * Add to cart animation
      * Wishlist toggle
      * Rating display
      * Price formatting
      * Discount badge

3.2. Forms & Inputs
    - Create custom form components:
      * TextInput with validation
      * DropdownSelect with search
      * Checkbox with custom style
      * RadioButton with animation
      * Form error handling

3.3. Navigation
    - Improve navigation components:
      * Custom BottomNavBar
      * Drawer with animations
      * AppBar with search
      * Category navigation
      * Breadcrumbs

4. Shopping Experience Enhancement
-------------------------------
CONTEXT:
Current shopping flow needs optimization.
See: product_controller.dart, cart_screen.dart

REQUIRED ACTIONS:
4.1. Product Discovery
    - Implement search features:
      * Autocomplete suggestions
      * Recent searches
      * Popular searches
      * Category filters
      * Price filters
      * Rating filters

4.2. Cart & Checkout
    - Enhance cart functionality:
      * Real-time price updates
      * Quantity adjustments
      * Remove item animation
      * Save for later
      * Apply coupon codes
      * Shipping calculator

4.3. User Account
    - Add account features:
      * Order history
      * Saved addresses
      * Payment methods
      * Wishlist management
      * Recently viewed
      * Review management

5. Performance & Technical Improvements
-----------------------------------
CONTEXT:
App needs optimization and technical enhancements.
See: main.dart, controllers/

REQUIRED ACTIONS:
5.1. State Management
    - Implement GetX patterns:
      * Separate business logic
      * Create repositories
      * Handle loading states
      * Manage errors
      * Cache responses

5.2. Image Optimization
    - Implement image handling:
      * Lazy loading
      * Caching
      * Compression
      * Placeholder system
      * Error fallbacks

5.3. Testing Strategy
    - Add test coverage:
      * Unit tests for controllers
      * Widget tests for components
      * Integration tests for flows
      * Performance testing
      * Error scenario testing

6. Next Steps
------------
1. Start with design system implementation
2. Create reusable components
3. Enhance existing screens
4. Add new features
5. Implement testing
6. Optimize performance

Note: Each implementation should follow Material Design 3 guidelines and maintain consistency across the app.
