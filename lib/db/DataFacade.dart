import 'dart:async';

import 'package:Weather_App/model/AJModel.dart';
import 'package:Weather_App/model/KeyAndJSON.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataFacade {
  Future<Database> _database;
  static final DataFacade _singleton = DataFacade._();

  final String KEY_AND_JSON_TABLE = "KeyAndJSON";
  final String WHERE_DATE_AND_WEATHER_QUERY = "secondsSinceEpoch = ?";

  factory DataFacade() {

    return _singleton;
  }

  DataFacade._() {
    getDatabasesPath().then((onVlaue) {
      _database = openDatabase(
        // Set the path to the database. Note: Using the `join` function from the
        // `path` package is best practice to ensure the path is correctly
        // constructed for each platform.

        join(onVlaue, 'adrian_johnson_database.db'),
        onCreate: (db, version) {

          // Run the CREATE TABLE statement on the database.
          return db.execute("CREATE TABLE KeyAndJSON(secondsSinceEpoch INTEGER PRIMARY KEY, JSONObject TEXT)");

        },
        version: 1,
      );
    }).catchError((error){
print('oioioioioio');
    });

  }

  String _columns(AJModel model) {

    String columns = '';
    Map<String,dynamic> map = model.toMap();
    final Iterable<String> keys = map.keys;

    for (var i = 0; i < keys.length; i++) {
      final String key = keys.elementAt(i);
      if(i == (keys.length - 1)){
        columns += (key);
      }else {
        columns += (key + ', ');
      }
    }
    return columns;
  }

  Future<void> update(AJModel model) async {
    // Get a reference to the database.
    final db = await _database;
    Type table = model.runtimeType;
    // Update the given Dog.
    await db.update(
      table.toString(),
      model.toMap(),
      // Ensure that the Dog has a matching id.
      where: model.primaryKeyName() + " = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [model.primaryKeyValue()],
    );
  }

  Future<void> deleteWeather(int secondsSinceEpoch) async {
    // Get a reference to the database.
    final db = await _database;

    // Remove the Dog from the Database.
    await db.delete(
      KEY_AND_JSON_TABLE,
      // Use a `where` clause to delete a specific dog.
      where: WHERE_DATE_AND_WEATHER_QUERY,
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [secondsSinceEpoch],
    );
  }

  Future<void> insert(AJModel model) async {
    // Get a reference to the database.
    final Database db = await _database;
    Type table = model.runtimeType;

    // Insert the Weather into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same Weather is inserted twice.
    //
    // In this case, replace any previous data.
    if (db != null) {
      await db.insert(
        table.toString(),
        model.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Stream<KeyAndJSON> weatherStream() {
    var controller = StreamController<KeyAndJSON>();
    query('KeyAndJSON', 'secondsSinceEpoch ASC').then((list){
      for(final mapItem in list) {
        KeyAndJSON weather = KeyAndJSON();
        weather.secondsSinceEpoch = mapItem['secondsSinceEpoch'];
        weather.JSONObject = mapItem['JSONObject'];

        controller.add(weather);
      }
    }).catchError((error){
      //controller.add(MSPerson(123, name: 'No Content'));
    });
    return controller.stream;
  }

  Future<List<KeyAndJSON>> weathers() async {
    // Get a reference to the database.

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await query('KeyAndJSON', 'secondsSinceEpoch ASC');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      KeyAndJSON weather = KeyAndJSON();
      weather.secondsSinceEpoch = maps[i]['secondsSinceEpoch'];
      weather.JSONObject = maps[i]['JSONObject'];
      return weather;
    });
  }

  Future<List<Map<String, dynamic>>> query(String table, String orderBy) async {
    final Database db = await _database;

    // Query the table for all The Weathers.
    final List<Map<String, dynamic>> maps = await db.query(table, orderBy: orderBy);
    return maps;
  }
}