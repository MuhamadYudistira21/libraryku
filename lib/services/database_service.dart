import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/book_model.dart';

class DatabaseService {
  static Database? _database;

  static final DatabaseService instance =
  DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath =
    await getDatabasesPath();

    final path =
    join(dbPath, 'library.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(
      Database db,
      int version) async {
    await db.execute('''
      CREATE TABLE books(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        borrower TEXT NOT NULL,
        borrowDate TEXT NOT NULL,
        returnDate TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertBook(
      BookModel book) async {
    final db = await database;

    return await db.insert(
      'books',
      book.toMap(),
    );
  }

  Future<List<BookModel>>
  getBooks() async {
    final db = await database;

    final data = await db.query(
      'books',
      orderBy: 'id DESC',
    );

    return data
        .map(
          (e) => BookModel.fromMap(e),
    )
        .toList();
  }

  Future<int> updateBook(
      BookModel book) async {
    final db = await database;

    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(
      int id) async {
    final db = await database;

    return await db.delete(
      'books',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}