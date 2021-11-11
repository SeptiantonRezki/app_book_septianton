import 'package:app_book_septianton/models/bookmark.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// inisialisasi => pastikan DB sudah dibuat atau belum
// kalau belum di buat => akan membuat db yang baru
// kalau sudah di buat => maka akan memakai db lama (sudah ada)
Future initDB() async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, "db_user");
  try {
    await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onDowngrade: onDatabaseDowngradeDelete,
    );
    // print("db successfully created or updated");
  } catch (e) {
    // print(e.toString());
  }
}

Future<Database> getDB() async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'db_user');
  final db = await openDatabase(path, version: 1);
  return db;
}

Future<List<Bookmark>> getBookmarks() async {
  List<Bookmark> bookmarks = [];
  try {
    Database db = await getDB();
    final result = await db
        .rawQuery("SELECT * FROM user_bookmark_table WHERE id = ?", [1]);
    for (var item in result) {
      bookmarks.add(Bookmark.fromJson(item));
    }
  } catch (e) {
    // print(e.toString());
  }
  return bookmarks;
}

Future<Bookmark> getBookmark(int idBookmark) async {
  Bookmark bookmark = Bookmark.initial();
  try {
    Database db = await getDB();
    final result = await db.rawQuery(
        "SELECT * FROM user_bookmark_table WHERE id =? AND id_bookmark = ?",
        [1, idBookmark]);
    bookmark = Bookmark.fromJson(result.first);
  } catch (e) {
    // print(e.toString());
  }
  return bookmark;
}

Future<List<Bookmark>> addBookmark(
    {required String title, required String description}) async {
  try {
    Database db = await getDB();
    await db.insert('user_bookmark_table', {
      "id": 1,
      "title": title,
      "description": description,
    });
  } catch (e) {
    // print(e.toString());
  }
  return await getBookmarks();
}

Future<List<Bookmark>> removeBookmark({required int idBookmark}) async {
  try {
    Database db = await getDB();
    await db.rawDelete(
        "DELETE FROM user_bookmark_table WHERE id_bookmark = ?", [idBookmark]);
  } catch (e) {
    // print(e.toString());
  }
  return await getBookmarks();
}

_onCreate(Database db, int version) async {
  // Database is created, create the table
  await db.execute(
      "CREATE TABLE IF NOT EXISTS user_table (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)");
  await db.execute(
      "CREATE TABLE IF NOT EXISTS user_bookmark_table (id_bookmark INTEGER PRIMARY KEY AUTOINCREMENT, id INTEGER, title TEXT, description TEXT,  FOREIGN KEY(id) REFERENCES user_table(id))");
  db.insert("user_table", {"id": 1, "name": "guest"},
      conflictAlgorithm: ConflictAlgorithm.replace);
}

_onUpgrade(Database db, int oldVersion, int newVersion) async {
  // Database version is updated, alter the table
  // await db.execute("ALTER TABLE Test ADD name TEXT");
}
