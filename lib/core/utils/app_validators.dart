/// Reusable form validation rules for inputs across any app
class AppValidators {
  AppValidators._();

  /// Validates that field is not empty
  static String? required(
    String? value, {
    String? fieldName,
    String? message,
  }) {
    if (value == null || value.trim().isEmpty) {
      if (message != null) return message;
      if (fieldName != null) return 'Please enter your $fieldName';
      return 'This field is required';
    }
    return null;
  }

  /// Validates email format
  static String? email(String? value, [String message = 'Please enter a valid email address']) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return message;
    }
    return null;
  }

  /// Validates minimum string length
  static String? Function(String?) minLength(int length, [String? customMessage]) {
    return (String? value) {
      if (value == null || value.trim().length < length) {
        return customMessage ?? 'Must be at least $length characters';
      }
      return null;
    };
  }

  /// Validates password strength (min length, letter and number)
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }
    return null;
  }

  /// Validates confirmation password match
  static String? Function(String?) match(
    String originalValue, [
    String message = 'Passwords do not match',
  ]) {
    return (String? value) {
      if (value != originalValue) {
        return message;
      }
      return null;
    };
  }
}
