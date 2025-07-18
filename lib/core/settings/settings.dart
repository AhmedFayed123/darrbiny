import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// API Base URL
const String kApiBaseUrl = "https://api.cryptoapp.com/v1/";

// Currency Settings
const String kDefaultCurrency = "USD";
const List<String> kSupportedCurrencies = ["USD", "EUR", "GBP", "JPY", "BTC", "ETH"];

// App Settings
const bool kIsDarkModeEnabled = false;  // Dark mode by default
const bool kIsPushNotificationsEnabled = true;  // Push notifications enabled by default

// User Preferences (Can be used with SharedPreferences or another storage solution)
class UserPreferences {
  static late SharedPreferences _preferences;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static String get selectedCurrency => _preferences.getString('selectedCurrency') ?? kDefaultCurrency;
  static bool get isDarkMode => _preferences.getBool('isDarkMode') ?? kIsDarkModeEnabled;
  static bool get isPushNotificationsEnabled => _preferences.getBool('isPushNotificationsEnabled') ?? kIsPushNotificationsEnabled;

  static Future setSelectedCurrency(String currency) async {
    await _preferences.setString('selectedCurrency', currency);
  }

  static Future setIsDarkMode(bool value) async {
    await _preferences.setBool('isDarkMode', value);
  }

  static Future setPushNotificationsEnabled(bool value) async {
    await _preferences.setBool('isPushNotificationsEnabled', value);
  }
}

// App Constants
class AppSettings {
  static const String appName = "CryptoApp";  // App name
  static const String appVersion = "1.0.0";  // App version
  static const String contactEmail = "support@cryptoapp.com";  // Contact email
}

// Network and API Configuration
class ApiConfig {
  static const int timeoutDurationInSeconds = 30;  // Timeout duration for API requests
  static const String kApiKey = "your_api_key_here";  // API Key (for authentication or requests)
}

// Settings for Crypto Prices
class CryptoSettings {
  static const String kPriceFormat = "USD";  // Default price format (e.g., USD, BTC, ETH)
  static const double kPriceRefreshIntervalInMinutes = 5.0;  // Price refresh interval in minutes
}

// General UI Settings
class UISettings {
  static const double kButtonRadius = 12.0;  // Button corner radius
  static const double kCardElevation = 5.0;  // Card elevation for Material design
  static const EdgeInsetsGeometry kPagePadding = EdgeInsets.all(16.0);  // Padding for pages/screens
}

// App Environment (can be used to switch between production, staging, etc.)
enum Environment { production, staging, development }

class AppEnvironment {
  static const Environment environment = Environment.production;  // Set the environment for API endpoints
  static const bool isInDevelopment = false;  // Flag for development mode

  static String get baseUrl {
    switch (environment) {
      case Environment.production:
        return 'https://api.cryptoapp.com/v1/';
      case Environment.staging:
        return 'https://staging-api.cryptoapp.com/v1/';
      case Environment.development:
        return 'https://dev-api.cryptoapp.com/v1/';
    }
  }
}
