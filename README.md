# Foodie Express 🛵

A food delivery app built with Flutter for the Mobile Application Development (MAD) course at Riphah International University.

**Student:** M. Najam-ul-Hassan (SAP 63099)
**Instructor:** Mr. Muhammad Usman

## Features so far

- Sign up page with name, email, password and confirm password validation
- Login page that checks the saved account (stored with SharedPreferences)
- Animated welcome screen after login (staggered animations with AnimationController)
- Home/menu screen with category filter chips (Desi, Fast Food, Drinks, Desserts)
- Add/remove items with quantity counters
- Food detail page with Hero animation; returns the chosen quantity back to the menu
- Named route navigation (all routes in `lib/routes.dart`)
- Side drawer and BottomAppBar with a notched cart button (badge shows item count)
- Help (FAQ), About and Profile screens; logout clears the navigation stack
- Checkout dialog with delivery fee and order confirmation

## Project structure

```
lib/
├── main.dart              # app entry point
├── routes.dart            # named routes + onGenerateRoute
├── theme.dart             # colours and app theme
├── models/food_item.dart  # FoodItem class + menu data
├── services/auth_service.dart
├── screens/
│   ├── login_screen.dart
│   ├── signup_screen.dart
│   ├── welcome_screen.dart
│   ├── home_screen.dart
│   ├── food_detail_screen.dart
│   ├── help_screen.dart
│   ├── about_screen.dart
│   └── profile_screen.dart
└── widgets/food_card.dart
```

## Run

```
flutter pub get
flutter run
```
