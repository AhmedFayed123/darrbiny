import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'crypto_app.db';
  static const int _dbVersion = 1;

  // Singleton pattern: ensures only one instance of the database exists
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Open the database and return the instance
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    // Get the directory where the app can store files
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = '${documentsDirectory.path}/$_dbName'; // Directly using the path
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  // Create the tables in the database
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        transaction_type TEXT,
        amount REAL,
        date TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE crypto_prices(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        symbol TEXT,
        price REAL,
        timestamp TEXT
      );
    ''');

    await db.execute('''
      CREATE TABLE user_preferences(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        key TEXT,
        value TEXT
      );
    ''');
  }

  // Add a transaction
  Future<int> addTransaction(Map<String, dynamic> transaction) async {
    Database db = await instance.database;
    return await db.insert('transactions', transaction);
  }

  // Get all transactions
  Future<List<Map<String, dynamic>>> getTransactions() async {
    Database db = await instance.database;
    return await db.query('transactions');
  }

  // Get a transaction by ID
  Future<Map<String, dynamic>?> getTransactionById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result =
    await db.query('transactions', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  // Update a transaction
  Future<int> updateTransaction(Map<String, dynamic> transaction) async {
    Database db = await instance.database;
    return await db.update(
      'transactions',
      transaction,
      where: 'id = ?',
      whereArgs: [transaction['id']],
    );
  }

  // Delete a transaction
  Future<int> deleteTransaction(int id) async {
    Database db = await instance.database;
    return await db.delete('transactions', where: 'id = ?', whereArgs: [id]);
  }

  // Add a crypto price entry
  Future<int> addCryptoPrice(Map<String, dynamic> cryptoPrice) async {
    Database db = await instance.database;
    return await db.insert('crypto_prices', cryptoPrice);
  }

  // Get all crypto prices
  Future<List<Map<String, dynamic>>> getCryptoPrices() async {
    Database db = await instance.database;
    return await db.query('crypto_prices');
  }

  // Get a crypto price by symbol
  Future<Map<String, dynamic>?> getCryptoPriceBySymbol(String symbol) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'crypto_prices',
      where: 'symbol = ?',
      whereArgs: [symbol],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Update a crypto price entry
  Future<int> updateCryptoPrice(Map<String, dynamic> cryptoPrice) async {
    Database db = await instance.database;
    return await db.update(
      'crypto_prices',
      cryptoPrice,
      where: 'id = ?',
      whereArgs: [cryptoPrice['id']],
    );
  }

  // Add or update user preferences
  Future<int> addOrUpdateUserPreference(Map<String, dynamic> preference) async {
    Database db = await instance.database;
    int count = await db.update(
      'user_preferences',
      preference,
      where: 'key = ?',
      whereArgs: [preference['key']],
    );
    if (count == 0) {
      return await db.insert('user_preferences', preference);
    }
    return count;
  }

  // Get user preference by key
  Future<Map<String, dynamic>?> getUserPreference(String key) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'user_preferences',
      where: 'key = ?',
      whereArgs: [key],
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Close the database
  Future<void> closeDatabase() async {
    Database db = await instance.database;
    db.close();
  }
}
