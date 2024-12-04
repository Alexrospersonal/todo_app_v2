// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: public_member_api_docs, cascade_invocations

part of 'task.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTaskEntityCollection on Isar {
  IsarCollection<TaskEntity> get taskEntitys => this.collection();
}

const TaskEntitySchema = CollectionSchema(
  name: r'TaskEntity',
  id: -2911998186285533288,
  properties: {
    r'color': PropertySchema(
      id: 0,
      name: r'color',
      type: IsarType.long,
    ),
    r'endDateOfRepeatedly': PropertySchema(
      id: 1,
      name: r'endDateOfRepeatedly',
      type: IsarType.dateTime,
    ),
    r'hasRepeats': PropertySchema(
      id: 2,
      name: r'hasRepeats',
      type: IsarType.bool,
    ),
    r'hasTime': PropertySchema(
      id: 3,
      name: r'hasTime',
      type: IsarType.bool,
    ),
    r'important': PropertySchema(
      id: 4,
      name: r'important',
      type: IsarType.bool,
    ),
    r'isCopy': PropertySchema(
      id: 5,
      name: r'isCopy',
      type: IsarType.bool,
    ),
    r'isFinished': PropertySchema(
      id: 6,
      name: r'isFinished',
      type: IsarType.bool,
    ),
    r'notate': PropertySchema(
      id: 7,
      name: r'notate',
      type: IsarType.string,
    ),
    r'notificationId': PropertySchema(
      id: 8,
      name: r'notificationId',
      type: IsarType.long,
    ),
    r'repeatDuringDay': PropertySchema(
      id: 9,
      name: r'repeatDuringDay',
      type: IsarType.dateTimeList,
    ),
    r'repeatDuringWeek': PropertySchema(
      id: 10,
      name: r'repeatDuringWeek',
      type: IsarType.longList,
    ),
    r'taskDate': PropertySchema(
      id: 11,
      name: r'taskDate',
      type: IsarType.dateTime,
    ),
    r'title': PropertySchema(
      id: 12,
      name: r'title',
      type: IsarType.string,
    )
  },
  estimateSize: _taskEntityEstimateSize,
  serialize: _taskEntitySerialize,
  deserialize: _taskEntityDeserialize,
  deserializeProp: _taskEntityDeserializeProp,
  idName: r'id',
  indexes: {
    r'taskDate': IndexSchema(
      id: 5562689836249259754,
      name: r'taskDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'taskDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'endDateOfRepeatedly': IndexSchema(
      id: 5493750381249337925,
      name: r'endDateOfRepeatedly',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'endDateOfRepeatedly',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'category': LinkSchema(
      id: 8847283037907089969,
      name: r'category',
      target: r'CategoryEntity',
      single: true,
    ),
    r'originalTask': LinkSchema(
      id: -8211601693947406828,
      name: r'originalTask',
      target: r'TaskEntity',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _taskEntityGetId,
  getLinks: _taskEntityGetLinks,
  attach: _taskEntityAttach,
  version: '3.1.0+1',
);

int _taskEntityEstimateSize(
  TaskEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.notate;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.repeatDuringDay;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  {
    final value = object.repeatDuringWeek;
    if (value != null) {
      bytesCount += 3 + value.length * 8;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  return bytesCount;
}

void _taskEntitySerialize(
  TaskEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.color);
  writer.writeDateTime(offsets[1], object.endDateOfRepeatedly);
  writer.writeBool(offsets[2], object.hasRepeats);
  writer.writeBool(offsets[3], object.hasTime);
  writer.writeBool(offsets[4], object.important);
  writer.writeBool(offsets[5], object.isCopy);
  writer.writeBool(offsets[6], object.isFinished);
  writer.writeString(offsets[7], object.notate);
  writer.writeLong(offsets[8], object.notificationId);
  writer.writeDateTimeList(offsets[9], object.repeatDuringDay);
  writer.writeLongList(offsets[10], object.repeatDuringWeek);
  writer.writeDateTime(offsets[11], object.taskDate);
  writer.writeString(offsets[12], object.title);
}

TaskEntity _taskEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TaskEntity(
    title: reader.readString(offsets[12]),
  );
  object.color = reader.readLongOrNull(offsets[0]);
  object.endDateOfRepeatedly = reader.readDateTimeOrNull(offsets[1]);
  object.hasRepeats = reader.readBool(offsets[2]);
  object.hasTime = reader.readBool(offsets[3]);
  object.id = id;
  object.important = reader.readBool(offsets[4]);
  object.isCopy = reader.readBool(offsets[5]);
  object.isFinished = reader.readBool(offsets[6]);
  object.notate = reader.readStringOrNull(offsets[7]);
  object.notificationId = reader.readLongOrNull(offsets[8]);
  object.repeatDuringDay = reader.readDateTimeOrNullList(offsets[9]);
  object.repeatDuringWeek = reader.readLongList(offsets[10]);
  object.taskDate = reader.readDateTimeOrNull(offsets[11]);
  return object;
}

P _taskEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readBool(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readBool(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNullList(offset)) as P;
    case 10:
      return (reader.readLongList(offset)) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _taskEntityGetId(TaskEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _taskEntityGetLinks(TaskEntity object) {
  return [object.category, object.originalTask];
}

void _taskEntityAttach(IsarCollection<dynamic> col, Id id, TaskEntity object) {
  object.id = id;
  object.category
      .attach(col, col.isar.collection<CategoryEntity>(), r'category', id);
  object.originalTask
      .attach(col, col.isar.collection<TaskEntity>(), r'originalTask', id);
}

extension TaskEntityQueryWhereSort
    on QueryBuilder<TaskEntity, TaskEntity, QWhere> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhere> anyTaskDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'taskDate'),
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhere> anyEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'endDateOfRepeatedly'),
      );
    });
  }
}

extension TaskEntityQueryWhere
    on QueryBuilder<TaskEntity, TaskEntity, QWhereClause> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> taskDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taskDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> taskDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> taskDateEqualTo(
      DateTime? taskDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taskDate',
        value: [taskDate],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> taskDateNotEqualTo(
      DateTime? taskDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskDate',
              lower: [],
              upper: [taskDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskDate',
              lower: [taskDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskDate',
              lower: [taskDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskDate',
              lower: [],
              upper: [taskDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> taskDateGreaterThan(
    DateTime? taskDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskDate',
        lower: [taskDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> taskDateLessThan(
    DateTime? taskDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskDate',
        lower: [],
        upper: [taskDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause> taskDateBetween(
    DateTime? lowerTaskDate,
    DateTime? upperTaskDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'taskDate',
        lower: [lowerTaskDate],
        includeLower: includeLower,
        upper: [upperTaskDate],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'endDateOfRepeatedly',
        value: [null],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyEqualTo(DateTime? endDateOfRepeatedly) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'endDateOfRepeatedly',
        value: [endDateOfRepeatedly],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyNotEqualTo(DateTime? endDateOfRepeatedly) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [],
              upper: [endDateOfRepeatedly],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [endDateOfRepeatedly],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [endDateOfRepeatedly],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'endDateOfRepeatedly',
              lower: [],
              upper: [endDateOfRepeatedly],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyGreaterThan(
    DateTime? endDateOfRepeatedly, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [endDateOfRepeatedly],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyLessThan(
    DateTime? endDateOfRepeatedly, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [],
        upper: [endDateOfRepeatedly],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterWhereClause>
      endDateOfRepeatedlyBetween(
    DateTime? lowerEndDateOfRepeatedly,
    DateTime? upperEndDateOfRepeatedly, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'endDateOfRepeatedly',
        lower: [lowerEndDateOfRepeatedly],
        includeLower: includeLower,
        upper: [upperEndDateOfRepeatedly],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TaskEntityQueryFilter
    on QueryBuilder<TaskEntity, TaskEntity, QFilterCondition> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'color',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'color',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> colorBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'color',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endDateOfRepeatedly',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endDateOfRepeatedly',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endDateOfRepeatedly',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endDateOfRepeatedly',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endDateOfRepeatedly',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      endDateOfRepeatedlyBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endDateOfRepeatedly',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> hasRepeatsEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasRepeats',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> hasTimeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasTime',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> importantEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'important',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> isCopyEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCopy',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> isFinishedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isFinished',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notate',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notate',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notate',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notate',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> notateIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notate',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notateIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notate',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notificationIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notificationIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'notificationId',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notificationIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notificationIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notificationIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      notificationIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayElementIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayElementIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.elementIsNotNull(
        property: r'repeatDuringDay',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayElementEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayElementGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayElementLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatDuringDay',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayElementBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatDuringDay',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringDayLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringDay',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'repeatDuringWeek',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'repeatDuringWeek',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'repeatDuringWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'repeatDuringWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'repeatDuringWeek',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'repeatDuringWeek',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      repeatDuringWeekLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'repeatDuringWeek',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> taskDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'taskDate',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      taskDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'taskDate',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> taskDateEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      taskDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> taskDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskDate',
        value: value,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> taskDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }
}

extension TaskEntityQueryObject
    on QueryBuilder<TaskEntity, TaskEntity, QFilterCondition> {}

extension TaskEntityQueryLinks
    on QueryBuilder<TaskEntity, TaskEntity, QFilterCondition> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> category(
      FilterQuery<CategoryEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'category');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> categoryIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'category', 0, true, 0, true);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition> originalTask(
      FilterQuery<TaskEntity> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'originalTask');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterFilterCondition>
      originalTaskIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'originalTask', 0, true, 0, true);
    });
  }
}

extension TaskEntityQuerySortBy
    on QueryBuilder<TaskEntity, TaskEntity, QSortBy> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>
      sortByEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>
      sortByEndDateOfRepeatedlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByHasRepeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRepeats', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByHasRepeatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRepeats', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByHasTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTime', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByHasTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTime', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByIsCopy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCopy', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByIsCopyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCopy', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByNotate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByNotateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>
      sortByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByTaskDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskDate', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByTaskDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskDate', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TaskEntityQuerySortThenBy
    on QueryBuilder<TaskEntity, TaskEntity, QSortThenBy> {
  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByColorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'color', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>
      thenByEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>
      thenByEndDateOfRepeatedlyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endDateOfRepeatedly', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByHasRepeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRepeats', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByHasRepeatsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRepeats', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByHasTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTime', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByHasTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasTime', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByImportantDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'important', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByIsCopy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCopy', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByIsCopyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCopy', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByIsFinishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isFinished', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByNotate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByNotateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notate', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy>
      thenByNotificationIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notificationId', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByTaskDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskDate', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByTaskDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskDate', Sort.desc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension TaskEntityQueryWhereDistinct
    on QueryBuilder<TaskEntity, TaskEntity, QDistinct> {
  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByColor() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'color');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct>
      distinctByEndDateOfRepeatedly() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endDateOfRepeatedly');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByHasRepeats() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasRepeats');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByHasTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasTime');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByImportant() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'important');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByIsCopy() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCopy');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByIsFinished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isFinished');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByNotate(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notate', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByNotificationId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notificationId');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByRepeatDuringDay() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatDuringDay');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByRepeatDuringWeek() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'repeatDuringWeek');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByTaskDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskDate');
    });
  }

  QueryBuilder<TaskEntity, TaskEntity, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }
}

extension TaskEntityQueryProperty
    on QueryBuilder<TaskEntity, TaskEntity, QQueryProperty> {
  QueryBuilder<TaskEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TaskEntity, int?, QQueryOperations> colorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'color');
    });
  }

  QueryBuilder<TaskEntity, DateTime?, QQueryOperations>
      endDateOfRepeatedlyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endDateOfRepeatedly');
    });
  }

  QueryBuilder<TaskEntity, bool, QQueryOperations> hasRepeatsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasRepeats');
    });
  }

  QueryBuilder<TaskEntity, bool, QQueryOperations> hasTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasTime');
    });
  }

  QueryBuilder<TaskEntity, bool, QQueryOperations> importantProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'important');
    });
  }

  QueryBuilder<TaskEntity, bool, QQueryOperations> isCopyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCopy');
    });
  }

  QueryBuilder<TaskEntity, bool, QQueryOperations> isFinishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isFinished');
    });
  }

  QueryBuilder<TaskEntity, String?, QQueryOperations> notateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notate');
    });
  }

  QueryBuilder<TaskEntity, int?, QQueryOperations> notificationIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notificationId');
    });
  }

  QueryBuilder<TaskEntity, List<DateTime?>?, QQueryOperations>
      repeatDuringDayProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatDuringDay');
    });
  }

  QueryBuilder<TaskEntity, List<int>?, QQueryOperations>
      repeatDuringWeekProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'repeatDuringWeek');
    });
  }

  QueryBuilder<TaskEntity, DateTime?, QQueryOperations> taskDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskDate');
    });
  }

  QueryBuilder<TaskEntity, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }
}
