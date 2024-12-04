import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_db_api/src/models/category.dart';
import 'package:todo_db_api/src/models/task.dart';

/// A provider class to manage the initialization of the Isar database.
///
/// This class handles opening the Isar database in the application's
/// document directory, ensuring the database is accessible
/// for persistent storage.
class IsarProvider {
  /// Initializes and opens the Isar database.
  ///
  /// This method retrieves the application's document directory path using
  /// [getApplicationDocumentsDirectory] and opens the Isar database
  /// at that location.
  ///
  /// - Returns a [Future<Isar>] that resolves to the opened Isar instance.
  /// - The schema used in this example is an empty list `[]`.
  /// Make sure to provide
  ///   your collection schemas when using this method.
  ///
  /// Example:
  /// ```dart
  /// final isar = await IsarProvider.init();
  /// ```
  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [CategoryEntitySchema, TaskEntitySchema],
      directory: dir.path,
    );
  }
}
