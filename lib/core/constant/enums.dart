// enums.dart

/// Enum for representing user status in a crypto app
enum UserStatus {
  active,
  inactive,
  banned,
  pending,
}

/// Enum for representing the types of transactions in a crypto app
enum TransactionType {
  deposit,
  withdrawal,
  transfer,
  exchange,
}

/// Enum for representing different types of cryptocurrencies
enum CryptoCurrency {
  bitcoin,
  ethereum,
  ripple,
  litecoin,
  bitcoinCash,
  dogecoin,
}

/// Enum for representing the app's theme (Light or Dark)
enum AppTheme {
  light,
  dark,
}

/// Enum for representing different account types
enum AccountType {
  standard,
  premium,
  enterprise,
}

/// Enum for representing different payment methods in a crypto app
enum PaymentMethod {
  creditCard,
  bankTransfer,
  paypal,
  cryptoWallet,
}

/// Enum for representing the states of a transaction
enum TransactionStatus {
  pending,
  completed,
  failed,
  canceled,
}

/// Enum for representing different order statuses in trading
enum OrderStatus {
  open,
  filled,
  canceled,
  expired,
}

/// Enum for representing different trading modes
enum TradingMode {
  marketOrder,
  limitOrder,
  stopLoss,
  takeProfit,
}

/// Enum for representing the user's investment strategy
enum InvestmentStrategy {
  conservative,
  balanced,
  aggressive,
}

/// Enum for representing different levels of user verification
enum VerificationLevel {
  basic,
  advanced,
  verified,
}
