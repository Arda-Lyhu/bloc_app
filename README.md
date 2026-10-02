# 🚀 Enterprise Flutter Architecture & Starter Guide

> A production-grade, enterprise-scale Flutter project built with **Clean Architecture + BLoC + GoRouter + Dynamic Core Engine**. 
> Designed to be **100% modular, portable, responsive**, and easily understandable for any new developer joining the project.

---

## 📑 Table of Contents
1. [🌟 Quick Start for New Developers](#1-🌟-quick-start-for-new-developers)
2. [📂 Project Folder Structure](#2-📂-project-folder-structure)
3. [🏛 Clean Architecture Flow](#3-🏛-clean-architecture-flow)
4. [🧭 How to Add a New Feature (Step-by-Step Guide)](#4-🧭-how-to-add-a-new-feature-step-by-step-guide)
5. [⚙️ Global Master Cockpit (`AppConfig`)](#5-⚙️-global-master-cockpit-appconfig)
6. [🔌 Dependency Injection (`GetIt`)](#6-🔌-dependency-injection-getit)
7. [🚦 Routing & Shell Navigation (`GoRouter`)](#7-🚦-routing--shell-navigation-gorouter)
8. [🌐 Network Layer & Token Store (`Dio`)](#8-🌐-network-layer--token-store-dio)
9. [🎛 State Management (`BLoC`)](#9-🎛-state-management-bloc)
10. [🧰 Reusable Custom Core Components](#10-🧰-reusable-custom-core-components)
    - [Tactile Haptics (`AppHaptics`)](#tactile-haptics-apphaptics)
    - [Buttons (`AppButton`)](#buttons-appbutton)
    - [Inputs with Validation & Auto-Buzz (`AppTextField`)](#inputs-with-validation--auto-buzz-apptextfield)
    - [Skeleton Shimmer Loader (`AppShimmer`)](#skeleton-shimmer-loader-appshimmer)
    - [Modals & Bottom Sheets (`AppDialogs`)](#modals--bottom-sheets-appdialogs)
    - [Network Image with Shimmer (`AppNetworkImage`)](#network-image-with-shimmer-appnetworkimage)
    - [Empty & Error States (`AppEmptyState`)](#empty--error-states-appemptystate)
    - [3D Isometric Artwork (`ThreeDIconArtwork`)](#3d-isometric-artwork-threediconartwork)
11. [📐 Responsive Layout Engine](#11-📐-responsive-layout-engine)
12. [🛠 Utilities & Helpers](#12-🛠-utilities--helpers)
13. [📦 How to Copy Core into Another Project](#13-📦-how-to-copy-core-into-another-project)

---

## 1. 🌟 Quick Start for New Developers

### Prerequisites
- Flutter SDK `>=3.6.0` (Dart `>=3.12.0`)
- Android Studio / Xcode / VS Code with Flutter extension

### Getting Started
```bash
# 1. Clone repository and navigate to folder
cd app_scale

# 2. Install dependencies
flutter pub get

# 3. Run the application
flutter run
```

### 🔑 Test Accounts (DummyJSON API)
Because DummyJSON is a mock backend:
- **Username:** `emilys`
- **Password:** `emilyspass`
- *(Alternative)* **Username:** `michaelw` | **Password:** `michaelwpass`

---

## 2. 📂 Project Folder Structure

The project strictly follows a **Layered Clean Architecture** combined with a **Feature-First** structure:

```text
lib/
├── main.dart                       # App entry point (initializes AppConfig & DI)
├── app/                            # Global app-level setup
│   ├── app.dart                    # MaterialApp.router configuration & themeMode
│   ├── app_bloc_observer.dart      # Global BLoC state transitions logger
│   ├── router/                     # GoRouter route definitions & route names
│   │   ├── app_router.dart
│   │   └── route_name.dart
│   ├── shell/                      # Bottom navigation persistent shell
│   │   └── main_shell.dart
│   └── theme/                      # Dynamic Material 3 Light & Dark themes
│       └── app_theme.dart
│
├── core/                           # 🚀 100% Portable Shared Core Engine
│   ├── core.dart                   # Master barrel export for everything in core
│   ├── config/                     # Global app configuration cockpit
│   │   └── app_config.dart
│   ├── constants/                  # Spacing tokens & global assets
│   │   └── app_spacing.dart
│   ├── di/                         # Dependency Injection setup & modules
│   │   ├── injection_container.dart
│   │   └── modules/                # (network, auth, home modules)
│   ├── errors/                     # App-wide exceptions & failure models
│   │   └── exceptions.dart
│   ├── network/                    # Dio client, interceptors, TokenStore & endpoints
│   │   ├── api_client.dart
│   │   ├── api_endpoints.dart
│   │   ├── base_remote_data_source.dart
│   │   └── token_store.dart
│   ├── responsive/                 # Breakpoints, ResponsiveBuilder & Context extensions
│   │   ├── context_extensions.dart
│   │   └── responsive_layout.dart
│   ├── utils/                      # Logging, haptics, alerts, debouncer, formatters
│   │   ├── app_alerts.dart
│   │   ├── app_formatters.dart
│   │   ├── app_haptics.dart
│   │   ├── app_logger.dart
│   │   ├── app_validators.dart
│   │   └── debouncer.dart
│   └── widgets/                    # Reusable enterprise UI widgets
│       ├── app_button.dart
│       ├── app_dialogs.dart
│       ├── app_empty_state.dart
│       ├── app_network_image.dart
│       ├── app_shimmer.dart
│       ├── app_text_field.dart
│       └── three_d_icon_artwork.dart
│
└── features/                       # 📦 Business Features (Feature-First)
    ├── auth/                       # Authentication Feature (Login, Register)
    │   ├── data/                   # Models, data sources, repository implementations
    │   ├── domain/                 # Entities, repository interfaces, use cases
    │   └── presentation/           # BLoC, screens, widgets
    ├── home/                       # Home Feed / Product Explorer Feature
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    ├── onboarding/                 # 3D Isometric Onboarding Carousel Feature
    └── (profile / cart / etc.)     # Future features follow the exact same structure
```

---

## 3. 🏛 Clean Architecture Flow

Every feature is decoupled into 3 clear layers. Flow of data moves from **outside in**:

```
[UI / Screens] 
      │ 
      ▼ triggers Event
   [BLoC] 
      │ 
      ▼ calls
  [UseCase] 
      │ 
      ▼ requests
[Repository Interface]  <─── (Domain Layer: Pure Dart, 0 Flutter dependencies)
      │ 
      ▼ implemented by
[Repository Implementation]  <─── (Data Layer: parses Models & handles exceptions)
      │ 
      ▼ calls
[Remote DataSource / ApiClient] 
      │ 
      ▼
 [Backend REST API]
```

---

## 4. 🧭 How to Add a New Feature (Step-by-Step Guide)

Let's say you want to add a new **Cart** feature:

### Step 1: Create the Feature Directory Structure
```text
lib/features/cart/
├── data/
│   ├── models/cart_item_model.dart
│   ├── datasources/cart_remote_data_source.dart
│   └── repositories/cart_repository_impl.dart
├── domain/
│   ├── entities/cart_item_entity.dart
│   ├── repositories/cart_repository.dart
│   └── usecases/get_cart_items.dart
└── presentation/
    ├── bloc/cart_bloc.dart (cart_event.dart, cart_state.dart)
    ├── screens/cart_screen.dart
    └── widgets/cart_item_tile.dart
```

### Step 2: Register in Dependency Injection (`lib/core/di/`)
Create `lib/core/di/modules/cart_module.dart`:
```dart
import 'package:get_it/get_it.dart';
import '../../../features/cart/data/datasources/cart_remote_data_source.dart';
import '../../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../../features/cart/domain/repositories/cart_repository.dart';
import '../../../features/cart/domain/usecases/get_cart_items.dart';
import '../../../features/cart/presentation/bloc/cart_bloc.dart';

void initCartModule(GetIt sl) {
  // 1. Data Source
  sl.registerLazySingleton<CartRemoteDataSource>(() => CartRemoteDataSourceImpl(sl()));
  // 2. Repository
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  // 3. Use Case
  sl.registerLazySingleton(() => GetCartItems(sl()));
  // 4. BLoC (Factory for fresh instances or Singleton if shared)
  sl.registerFactory(() => CartBloc(getCartItems: sl()));
}
```
Add `initCartModule(sl);` in [`injection_container.dart`](file:///Users/nsm/Documents/app_scale/lib/core/di/injection_container.dart).

### Step 3: Add Route in `app_router.dart`
```dart
GoRoute(
  path: RouteName.cart,
  builder: (context, state) => BlocProvider(
    create: (context) => sl<CartBloc>()..add(FetchCartItems()),
    child: const CartScreen(),
  ),
),
```

---

## 5. ⚙️ Global Master Cockpit (`AppConfig`)

Configure your entire app dynamically from one place in [`main.dart`](file:///Users/nsm/Documents/app_scale/lib/main.dart):

```dart
AppConfig.initialize(
  appName: 'Nova Market',
  environment: AppEnvironment.production,
  baseUrl: 'https://dummyjson.com',
  primaryColor: const Color(0xFF6366F1), // Custom primary brand color
  enableHaptics: true,                   // Master toggle for phone vibration
  enableLogging: true,                   // Master toggle for network/BLoC logging
  enableOnboarding: true,                // Skip or show onboarding screen
);
```

---

## 6. 🔌 Dependency Injection (`GetIt`)

Access any service, use case, or BLoC anywhere using the global service locator `sl`:

```dart
// Retrieve instance
final authRepository = sl<AuthRepository>();

// Or provide BLoC to screen
BlocProvider(
  create: (context) => sl<UserBloc>(),
  child: const LoginScreen(),
)
```

---

## 7. 🚦 Routing & Shell Navigation (`GoRouter`)

Routes are declared in [`lib/app/router/app_router.dart`](file:///Users/nsm/Documents/app_scale/lib/app/router/app_router.dart) with type-safe route names in [`route_name.dart`](file:///Users/nsm/Documents/app_scale/lib/app/router/route_name.dart):

```dart
// Navigate to a new screen
context.pushNamed(RouteName.login);

// Replace current screen
context.goNamed(RouteName.home);

// Navigate with parameters
context.pushNamed(RouteName.productDetail, extra: product);
```

The app includes a persistent bottom navigation bar using **StatefulShellRoute** in [`lib/app/shell/main_shell.dart`](file:///Users/nsm/Documents/app_scale/lib/app/shell/main_shell.dart).

---

## 8. 🌐 Network Layer & Token Store (`Dio`)

- **`ApiClient`**: Pre-configured with automatic JSON parsing, request/response logging, timeouts, and error transformation.
- **`TokenStore`**: Singleton token storage. When a user logs in, `TokenStore().setToken(token)` automatically attaches `Authorization: Bearer <token>` to all future requests.
- **`ApiEndpoints`**: Centralized URL endpoint constants in [`api_endpoints.dart`](file:///Users/nsm/Documents/app_scale/lib/core/network/api_endpoints.dart).

```dart
// Performing an authenticated GET request
final response = await apiClient.get(
  ApiEndpoints.userProfile,
  requiresAuth: true,
);
```

---

## 9. 🎛 State Management (`BLoC`)

Every UI screen reacts to BLoC states using `BlocBuilder`, `BlocListener`, or `BlocConsumer`:

```dart
BlocConsumer<UserBloc, UserState>(
  listener: (context, state) {
    if (state is UserAuthenticated) {
      AppAlerts.showSuccess(context, 'Welcome back, ${state.user.username}!');
      context.goNamed(RouteName.home);
    } else if (state is UserError) {
      AppAlerts.showError(context, state.message);
    }
  },
  builder: (context, state) {
    return AppButton(
      text: 'Login',
      isLoading: state is UserLoading,
      onPressed: () {
        context.read<UserBloc>().add(
          LoginSubmitted(username: _userCtrl.text, password: _passCtrl.text),
        );
      },
    );
  },
)
```

All BLoC state changes are automatically logged to the console with [`AppBlocObserver`](file:///Users/nsm/Documents/app_scale/lib/app/app_bloc_observer.dart).

---

## 10. 🧰 Reusable Custom Core Components

Import all core components with a single line:
```dart
import 'package:app_scale/core/core.dart'; // or relative: import '../../core/core.dart';
```

### Tactile Haptics (`AppHaptics`)
```dart
AppHaptics.buttonPress(); // Tap touch
AppHaptics.selection();   // Tab / item switch
AppHaptics.error();       // Buzz-buzz on validation / error
AppHaptics.success();     // Success feedback
```

### Declarative Typography & Styles (`AppText` & `AppTextStyle`)
Effortless text styling with preset font tokens, fluent chaining, and declarative widgets:

```dart
// 1. Declarative Text Widgets
AppText.h1('Big Display Title')
AppText.h2('Section Header')
AppText.h3('Card Title')
AppText.title('Product Name', isPrimary: true)
AppText.subtitle('Electronics')
AppText.body('Item description text...', isMuted: true, maxLines: 2)
AppText.caption('2 hours ago')
AppText.overline('NEW ARRIVAL', isPrimary: true)

// 2. Direct TextStyle Tokens & Fluent Chaining
Text(
  'Custom Styled Text',
  style: AppTextStyle.h2.bold.primary(context),
)

Text(
  'Secondary Muted Text',
  style: AppTextStyle.body.muted(context).italic,
)
```

### Buttons (`AppButton`)
```dart
AppButton(
  text: 'Continue',
  icon: Icons.arrow_forward_rounded,
  isLoading: false,
  onPressed: () => submitForm(),
)
```

### Inputs with Validation & Auto-Buzz (`AppTextField`)
```dart
// Standard text input
AppTextField(
  controller: _emailController,
  label: 'Email',
  hint: 'user@example.com',
  prefixIcon: Icons.email_outlined,
  vibrateOnError: true, // Buzzes phone if validation fails
  validator: (v) => AppValidators.email(v),
)

// Password field (auto includes toggleable eye icon)
AppTextField(
  controller: _passwordController,
  label: 'Password',
  isPassword: true,
  validator: (v) => AppValidators.password(v),
)
```

### Ultra-Cool Animated Loaders (`AppLoader` & `AppLoadingOverlay`)
Powered by `loading_animation_widget` and `flutter_spinkit` with 8 animation styles:

```dart
// 1. Fluid Staggered Waves (Default)
const AppLoader(message: 'Loading products...')

// 2. Cyber Wave Bar Animation
const AppLoader.wave(message: 'Fetching feed...')

// 3. 3D Geometric Isometric Cube
const AppLoader.cube(message: 'Building orders...')

// 4. Compact Bouncing Dots (Inside buttons / chips)
const AppLoader.small()

// 5. Custom Animation Style Selection
AppLoader(
  style: AppLoaderStyle.spinningLines, // staggeredDots, wave, pulse, cubeGrid, threeBounce, spinningLines, doubleBounce, foldingCube
  size: 50,
  color: Colors.deepPurple,
  message: 'Authenticating...',
)

// 6. Modal Blocking Frosted Glass Dialog
AppLoader.showOverlay(
  context, 
  message: 'Processing payment...', 
  style: AppLoaderStyle.wave,
);
await processPayment();
AppLoader.hide(context);

// 7. Full Screen Overlay Widget
AppLoadingOverlay(
  isLoading: state is UserLoading,
  style: AppLoaderStyle.staggeredDots,
  message: 'Please wait...',
  child: MyFormScreen(),
)
```

### Skeleton Shimmer Loader (`AppShimmer`)
```dart
// Product / Card skeleton
AppShimmer.card(height: 200, borderRadius: 16)

// List skeleton
AppShimmer.list(count: 5, itemHeight: 72)

// Feed grid skeleton
AppShimmer.grid(count: 6, aspectRatio: 0.75)
```

### Modals & Bottom Sheets (`AppDialogs`)
```dart
// Frosted glass blur confirmation
final ok = await AppDialogs.showConfirm(
  context: context,
  title: 'Log Out',
  message: 'Are you sure you want to sign out?',
  confirmText: 'Sign Out',
  isDestructive: true,
  icon: Icons.logout_rounded,
);

// Bottom Sheet
AppDialogs.showBottomSheet(
  context: context,
  builder: (ctx) => MyCustomFilterSheet(),
);
```

### Network Image with Shimmer (`AppNetworkImage`)
```dart
// Rounded image with automatic shimmer and error placeholder
AppNetworkImage(
  imageUrl: product.thumbnail,
  width: double.infinity,
  height: 180,
  borderRadius: BorderRadius.circular(16),
)

// Circle Avatar
AppNetworkImage(
  imageUrl: user.avatarUrl,
  width: 48,
  height: 48,
  isCircle: true,
)
```

### Empty & Error States (`AppEmptyState`)
```dart
AppEmptyState(
  icon: Icons.shopping_bag_outlined,
  title: 'Your cart is empty',
  subtitle: 'Explore our catalog and add your favorite items',
  actionLabel: 'Start Shopping',
  onAction: () => context.goNamed(RouteName.home),
)
```

### 3D Isometric Artwork (`ThreeDIconArtwork`)
```dart
ThreeDIconArtwork(
  primaryIcon: Icons.shopping_bag_rounded,
  badgeIcon: Icons.star_rounded,
  primaryColor: Colors.deepPurple,
  secondaryColor: Colors.amber,
  size: 220,
)
```

---

## 11. 📐 Responsive Layout Engine

Build responsive layouts across Mobile (<600px), Tablet (600–1200px), and Desktop (>1200px):

### Quick Context Helpers
```dart
if (context.isMobile) { ... }
if (context.isTablet) { ... }
if (context.isDesktop) { ... }

final screenW = context.screenWidth;
final theme = context.theme;
final colors = context.colorScheme;
```

### `ResponsiveBuilder`
```dart
ResponsiveBuilder(
  mobile: (ctx) => MobileFeed(),
  tablet: (ctx) => TabletFeed(),
  desktop: (ctx) => DesktopFeed(),
)
```

### `ResponsiveContainer`
Prevents content from stretching too wide on iPad/Web/Desktop:
```dart
ResponsiveContainer(
  maxWidth: 840,
  child: ProfileForm(),
)
```

---

## 12. 🛠 Utilities & Helpers

### Bilingual Localization (Khmer ភាសាខ្មែរ & English 🇺🇸)
Instant, zero-restart bilingual translation engine with Google Font **Kantumruy Pro** for native Khmer typography:

```dart
// 1. Translate any string via context extension
context.tr('home')            // -> "Home" (EN) or "ទំព័រដើម" (KM)
context.tr('addToCart')       // -> "Add to Cart" or "ដាក់ក្នុងកន្ត្រក"
context.tr('checkOut')        // -> "CHECK OUT" or "ទូទាត់ប្រាក់"

// 2. Check active language
final isKm = context.isKhmer; // bool
final lang = context.language; // AppLanguage.english or AppLanguage.khmer

// 3. Switch Language Programmatically
LanguageController.instance.setLanguage(AppLanguage.khmer);

// 4. Open Interactive Language Selector Sheet
LanguageSelectorSheet.show(context);
```

### Data Formatters (`AppFormatters`)
```dart
AppFormatters.currency(1499.50)         // -> "$1,499.50"
AppFormatters.compactNumber(1500000)    // -> "1.5M"
AppFormatters.date(DateTime.now())       // -> "Oct 02, 2026"
AppFormatters.time(DateTime.now())       // -> "04:30 PM"
AppFormatters.timeAgo(pastDate)          // -> "5 mins ago" / "Just now"
```

### Search Debouncer (`Debouncer`)
```dart
final _debouncer = Debouncer(milliseconds: 350);

void onSearch(String text) {
  _debouncer.run(() {
    context.read<SearchBloc>().add(SearchTextChanged(text));
  });
}
```

### Smart Logger (`AppLogger`)
```dart
AppLogger.i('App loaded');              // 🟢 [INFO]
AppLogger.d('Current state: $state');   // 🐛 [DEBUG]
AppLogger.w('Token expiring soon');    // ⚠️ [WARN]
AppLogger.e('Login failed', error, st); // 🔴 [ERROR]
AppLogger.net('GET', '/products', 200); // 🌐 [NET]
```

---

## 13. 📦 How to Copy Core into Another Project

To use this engine in any new Flutter project:

1. **Copy `lib/core/`** into your new project's `lib/` directory.
2. In your new project's `pubspec.yaml`, add:
   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     dio: ^5.11.1
     go_router: ^18.0.1
     flutter_bloc: ^9.1.1
     bloc: ^9.2.1
     equatable: ^3.0.0
     get_it: ^8.0.3
     vibration: ^3.2.1
     intl: ^0.20.2
   ```
3. In `main.dart`, initialize `AppConfig.initialize(...)` and `await initDependencies()`.
4. Import `import 'package:<your_project_name>/core/core.dart';` and enjoy building at lightspeed!
