import 'package:my_mini_project/models/sqlite_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  final String nameDatabase = 'miniprojectmobile.db';
  final int version = 1;
  final String tableDatabase = 'tableOrder';
  final String columnId = 'id';
  final String columnIdSeller = 'idSeller';
  final String columnIdProduct = 'idProduct';
  final String columnIdName = 'name';
  final String columnIdPrice = 'price';
  final String columnIdAmount = 'amount';
  final String columnIdSum = 'sum';

  SQLiteHelper() {
    initialDatabase();
  }

  Future<Null> initialDatabase() async {
    await openDatabase(
      join(await getDatabasesPath(), nameDatabase),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE $tableDatabase ($columnId INTEGER PRIMARY KEY, $columnIdSeller TEXT, $columnIdProduct TEXT, $columnIdName TEXT, $columnIdPrice TEXT, $columnIdAmount TEXT, $columnIdSum TEXT)'),
      version: version,
    );
  }

  Future<Database> connecteDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), nameDatabase));
  }

  Future<List<SQLiteModel>> readSQLite() async {
    Database database = await connecteDatabase();
    List<SQLiteModel> results = [];
    List<Map<String, dynamic>> maps = await database.query(tableDatabase);
    // print('### maps on SQLiteHelper ==> $maps');
    for (var element in maps) {
      SQLiteModel model = SQLiteModel.fromMap(element);
      results.add(model);
    }
    return results;
  }

  Future<Null> insertValueToSQLite(SQLiteModel sqLiteModel) async {
    Database database = await connecteDatabase();
    await database.insert(tableDatabase, sqLiteModel.toMap()).then(
          (value) => print('### insert Value name ==>> ${sqLiteModel.name}'),
        );
  }

  Future<void> deleteSQLiteWhereId(int id) async {
    Database database = await connecteDatabase();
    await database
        .delete(tableDatabase, where: '$columnId = $id')
        .then((value) => print('### Success Delete id ==> $id'));
  }

  Future<void> emptySQLite() async {
    Database database = await connecteDatabase();
    await database.delete(tableDatabase).then(
          (value) => print('### Empty All Table Succes'),
        );
  }
  //
}
