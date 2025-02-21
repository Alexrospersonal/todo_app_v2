import 'package:todos_repository/todos_repository.dart';

class ReccuringTaskDto {
  const ReccuringTaskDto({
    required this.recurringTask,
    required this.nextDate,
  });

  final TaskEntity recurringTask;
  final DateTime nextDate;
}
