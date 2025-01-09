// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

import 'package:isar/isar.dart';
import 'package:todo_db_api/src/models/task.dart';

part 'category.g.dart';

/// Category model for the Isar database.
///
/// Used to store information about categories that can be associated
/// with tasks.
@collection
class CategoryEntity {
  /// Constructor to create a category.
  ///
  /// [name] is a required parameter for the category's name.
  /// [emoji] is an optional parameter, defaults to an empty string.
  CategoryEntity({required this.name, this.emoji = ''});

  /// Unique identifier for the category, generated automatically.
  Id id = Isar.autoIncrement;

  /// Name of the category.
  String name;

  /// Emoji icon associated with the category.
  String emoji;

  /// Backlink to tasks belonging to this category.
  @Backlink(to: 'category')
  final IsarLinks<TaskEntity> tasks = IsarLinks<TaskEntity>();

  @override
  String toString() => '$emoji $name';

  /// Converts the category into JSON format.
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'emoji': emoji};
  }

  ///
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is CategoryEntity && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
