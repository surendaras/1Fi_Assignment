# 1Fi Mobile App - 1Fi Marketplace Feature

This repository contains the complete implementation for the **1Fi SDE Intern Assignment**. It extends the existing 1Fi application experience with the **1Fi Marketplace** section within the **Shop** page, adhering strictly to 1Fi's fintech design language, clean architecture, and responsive user experience.

---

## 🌟 Assignment Scope & Architecture

### 1. Shop Page Navigation (3 Options)
- **A. Top Brands**: Clean placeholder view with a teaser for upcoming brand partnerships and voucher integrations.
- **B. Nearby Stores**: Clean placeholder view highlighting local offline store discovery and Scan & Pay with 1Fi Credit.
- **C. 1Fi Marketplace**: **Fully designed, interactive, dynamic, and production-ready fintech marketplace.**

---

## 🚀 Key Features Implemented in 1Fi Marketplace

### 1. Dynamic Product Catalog & Filtering
- **Multi-Category Navigation**: Categorized into Smartphones, Laptops & Computing, Audio & Sound, Wearables, and Smart Home Appliances.
- **Instant Search & Real-Time Filtering**:
  - Live query search across product title, brand, and description.
  - Interactive Filter Bottom Sheet with Brand selection, dual-thumb Price Range slider (₹0 - ₹2,50,000), 0% No-Cost EMI toggle, and Sorting options (Price Low-to-High, High-to-Low, Ratings, Lowest EMI).
- **Interactive Carousel Banners**: Highlighting 1Fi credit perks (Zero Downpayment, ₹2.5L Pre-Approved Limits, Instant Cashback).
- **Product Cards**: High-res imagery, discount pill tags, real-time wishlist toggles, customer ratings, original MRP vs. 1Fi Offer price, and starting EMI badges.

### 2. Rich Product Details Page (PDP)
- **Multi-Image Gallery**: Smooth image carousel with active indicator dots.
- **Live Variant Selection**:
  - **Color Swatches**: Visual color selection with dynamic name updates.
  - **Configuration / Storage**: Selection chips with dynamic price calculation and instant adjustment across base price, discount %, and EMI plans.
- **1Fi Pre-Approved Credit Integration**: Dynamic validation against the user's available 1Fi credit limit (pledged against mutual funds).
- **Pincode Delivery Estimator**: Live PIN code validation with delivery date computation.
- **Key Highlights & Technical Specs**: Expandable feature tables and specifications.

### 3. Interactive EMI Plan Calculator & Amortization Engine
- **Tenure Options**: 3 Months (No-Cost), 6 Months (No-Cost / Most Popular), 9 Months (Low-Cost @ 11.99%), 12 Months (Extended @ 13.49%), and 18 Months.
- **Financial Calculations**:
  - Accurate monthly installment computation (Reducing balance & Subvention models).
  - Clear breakdown of Principal, Interest, Processing Fee, Total Payable, and 1Fi Savings.
- **Month-by-Month Repayment Schedule Modal**: Full amortization table detailing installment number, due dates (5th of every month), principal vs. interest breakdown, and reducing balance.

### 4. EMI Checkout & Auto-Debit E-Mandate Flow
- **Step 1: Order & Loan Summary**: Product, chosen variant, tenure, and installment schedule.
- **Step 2: Auto-Debit NACH Mandate Setup**: Bank account selection (HDFC, ICICI, SBI, Axis) and KYC verification.
- **Step 3: Instant Loan Approval & Confirmation**: Animated success checkmark, unique 1Fi Order ID, Loan Reference Number, and repayment calendar.

---

## 🛠️ Project Structure & Clean Architecture

```
lib/
├── main.dart                          # App entry point with MultiProvider & Theme
├── theme/
│   ├── app_colors.dart                # 1Fi Emerald (#00D09C), Navy (#0B132B), Indigo, Gold
│   └── app_theme.dart                 # Material 3 typography, card styling, buttons
├── models/
│   ├── category_model.dart            # Category data structure
│   ├── product_model.dart             # Product metadata, highlights & specs
│   ├── variant_model.dart             # Color & storage variant definitions
│   ├── emi_plan_model.dart            # EMI tenures & amortization items
│   └── order_model.dart               # Order & loan reference model
├── services/
│   └── emi_calculator_service.dart    # EMI math & reducing balance amortization engine
├── repositories/
│   ├── product_repository.dart        # Abstract repository interface
│   └── mock_product_repository.dart   # Dynamic mock data source with simulated latency
├── providers/
│   ├── marketplace_provider.dart      # Catalog, filters, search & wishlist state
│   ├── product_detail_provider.dart   # Variant pricing & active EMI tenure state
│   └── checkout_provider.dart         # Credit limit, e-mandate & order lifecycle state
├── utils/
│   └── formatters.dart                # Indian Currency (₹) and Date formatters
└── screens/
    ├── main_navigation_screen.dart    # Bottom nav (Home, Shop, Credit, Profile)
    ├── home/home_screen.dart          # 1Fi dashboard & credit limit overview
    ├── credit/credit_screen.dart      # Loan against mutual funds & active mandates
    ├── profile/profile_screen.dart    # KYC verification, accounts & support
    ├── checkout/
    │   ├── checkout_screen.dart       # Loan application & mandate authorization
    │   └── order_success_screen.dart  # Loan approval & repayment calendar
    └── shop/
        ├── shop_screen.dart           # Segmented Tabs (Top Brands, Nearby Stores, Marketplace)
        ├── placeholders/
        │   ├── top_brands_tab.dart    # Option A placeholder
        │   └── nearby_stores_tab.dart # Option B placeholder
        └── marketplace/
            ├── marketplace_view.dart  # Option C - 1Fi Marketplace
            ├── product_detail_screen.dart
            └── widgets/
                ├── banner_carousel.dart
                ├── category_pills.dart
                ├── product_card.dart
                ├── filter_sheet.dart
                └── repayment_schedule_modal.dart
```

---

## 🧪 Testing & Verification

Comprehensive automated unit and widget tests are included:
```bash
flutter test
```

### Test Coverage:
1. **`emi_calculator_test.dart`**: Validates 0% No-Cost EMI calculations, standard reducing balance formulas, and amortization schedules.
2. **`product_repository_test.dart`**: Validates category filtering, live text search, brand filters, and price ranges.
3. **`widget_test.dart`**: Validates tab switching between Top Brands, Nearby Stores, and 1Fi Marketplace, and UI component rendering.

---

## 💻 Running the Project Locally

### Prerequisites
- Flutter SDK (3.x or higher)
- Google Chrome or Windows Desktop / Android Emulator

### Commands
```bash
# 1. Fetch dependencies
flutter pub get

# 2. Run static analysis
flutter analyze

# 3. Run automated tests
flutter test

# 4. Run on Chrome (Web)
flutter run -d chrome

# 5. Run on Windows Desktop
flutter run -d windows
```

---

## 🎨 Design Philosophy & Consistency
- Designed to feel like a native, premium fintech mobile application.
- Uses 1Fi's signature colors: Emerald Teal (`#00D09C`), Slate Blue (`#0B132B`), and Gold (`#FFB703`).
- Clean separation of concerns with decoupled reactive state management (`provider`).
- Zero hardcoded UI data — all product, variant, and EMI configurations are served dynamically via the Repository pattern.
