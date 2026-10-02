import 'app_language.dart';

/// Centralized Bilingual Dictionary (English & Khmer ភាសាខ្មែរ).
class AppTranslations {
  AppTranslations._();

  static const Map<String, Map<String, String>> _values = {
    // ─── Navigation & Shell ──────────────────────────────────────────────────
    'home': {'en': 'Home', 'km': 'ទំព័រដើម'},
    'shop': {'en': 'Shop', 'km': 'ហាងទំនិញ'},
    'bag': {'en': 'My Bag', 'km': 'កន្ត្រកទំនិញ'},
    'favorites': {'en': 'Favorites', 'km': 'ចូលចិត្ត'},
    'profile': {'en': 'Profile', 'km': 'គណនី'},
    'categories': {'en': 'Categories', 'km': 'ប្រភេទមុខទំនិញ'},
    'search': {'en': 'Search', 'km': 'ស្វែងរក'},
    'notifications': {'en': 'Notifications', 'km': 'ការជូនដំណឹង'},
    'settings': {'en': 'Settings', 'km': 'ការកំណត់'},
    'myOrders': {'en': 'My Orders', 'km': 'ការបញ្ជាទិញរបស់ខ្ញុំ'},
    'shippingAddresses': {'en': 'Shipping Addresses', 'km': 'អាសយដ្ឋានដឹកជញ្ជូន'},

    // ─── E-Commerce & Actions ────────────────────────────────────────────────
    'summerSale': {'en': 'SUMMER SALES', 'km': 'ការបញ្ចុះតម្លៃរដូវក្តៅ'},
    'upTo50Off': {'en': 'Up to 50% off', 'km': 'បញ្ចុះតម្លៃរហូតដល់ 50%'},
    'viewAll': {'en': 'View all', 'km': 'មើលទាំងអស់'},
    'newArrivals': {'en': "You've never seen it before!", 'km': 'ទំនិញមកដល់ថ្មីៗ!'},
    'sale': {'en': 'Sale', 'km': 'បញ្ចុះតម្លៃ'},
    'new': {'en': 'New', 'km': 'ថ្មី'},
    'addToCart': {'en': 'Add to Cart', 'km': 'ដាក់ក្នុងកន្ត្រក'},
    'checkOut': {'en': 'CHECK OUT', 'km': 'ទូទាត់ប្រាក់'},
    'totalAmount': {'en': 'Total amount:', 'km': 'ចំនួនសរុប:'},
    'emptyBag': {'en': 'Your bag is empty', 'km': 'កន្ត្រករបស់អ្នកទទេ'},
    'emptyFavorites': {'en': 'No Favorites Yet', 'km': 'មិនទាន់មានទំនិញចូលចិត្តនៅឡើយ'},
    'recentSearches': {'en': 'Recent Searches', 'km': 'ការស្វែងរកថ្មីៗ'},
    'productDetails': {'en': 'Product Details', 'km': 'ព័ត៌មានលម្អិតទំនិញ'},
    'description': {'en': 'Description', 'km': 'ការពិពណ៌នា'},
    'paymentMethod': {'en': 'Payment Method', 'km': 'វិធីសាស្ត្រទូទាត់'},
    'submitOrder': {'en': 'SUBMIT ORDER', 'km': 'បញ្ជាក់ការបញ្ជាទិញ'},
    'orderDelivered': {'en': 'Delivered', 'km': 'បានដឹកជញ្ជូនរួចរាល់'},
    'orderProcessing': {'en': 'Processing', 'km': 'កំពុងដំណើរការ'},

    // ─── Auth & Profile ──────────────────────────────────────────────────────
    'login': {'en': 'Login', 'km': 'ចូលគណនី'},
    'register': {'en': 'Register', 'km': 'ចុះឈ្មោះ'},
    'logout': {'en': 'Logout', 'km': 'ចាកចេញ'},
    'signOutConfirm': {
      'en': 'Are you sure you want to sign out from your account?',
      'km': 'តើអ្នកពិតជាចង់ចាកចេញពីគណនីរបស់អ្នកមែនទេ?'
    },
    'username': {'en': 'Username', 'km': 'ឈ្មោះគណនី'},
    'password': {'en': 'Password', 'km': 'លេខសម្ងាត់'},
    'personalInfo': {'en': 'Personal Information', 'km': 'ព័ត៌មានផ្ទាល់ខ្លួន'},
    'language': {'en': 'Language', 'km': 'ភាសា'},
    'changeLanguage': {'en': 'Change Language', 'km': 'ផ្លាស់ប្តូរភាសា'},
    'hapticsFeedback': {'en': 'Haptic Touch & Vibration', 'km': 'រំញ័រពេលប៉ះ & សង្កត់'},
    'saveChanges': {'en': 'Save Changes', 'km': 'រក្សាទុកការផ្លាស់ប្តូរ'},

    // ─── Common UI & Alerts ──────────────────────────────────────────────────
    'confirm': {'en': 'Confirm', 'km': 'យល់ព្រម'},
    'cancel': {'en': 'Cancel', 'km': 'បោះបង់'},
    'retry': {'en': 'Retry', 'km': 'ព្យាយាមម្តងទៀត'},
    'loading': {'en': 'Please wait...', 'km': 'សូមរង់ចាំ...'},
    'error': {'en': 'Something went wrong', 'km': 'មានបញ្ហាមិនប្រក្រតីកើតឡើង'},
    'success': {'en': 'Success', 'km': 'ជោគជ័យ'},
  };

  /// Translates a key according to the active language code
  static String get(String key, AppLanguage language) {
    final entry = _values[key];
    if (entry == null) return key;
    return entry[language.code] ?? entry['en'] ?? key;
  }
}
