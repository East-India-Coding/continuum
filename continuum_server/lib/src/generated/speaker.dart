/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Speaker
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Speaker._({
    this.id,
    required this.userId,
    required this.name,
    required this.normalizedName,
    required this.detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Speaker({
    int? id,
    required String userId,
    required String name,
    required String normalizedName,
    required int detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _SpeakerImpl;

  factory Speaker.fromJson(Map<String, dynamic> jsonSerialization) {
    return Speaker(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      name: jsonSerialization['name'] as String,
      normalizedName: jsonSerialization['normalizedName'] as String,
      detectedCount: jsonSerialization['detectedCount'] as int,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = SpeakerTable();

  static const db = SpeakerRepository._();

  @override
  int? id;

  String userId;

  String name;

  String normalizedName;

  int detectedCount;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Speaker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Speaker copyWith({
    int? id,
    String? userId,
    String? name,
    String? normalizedName,
    int? detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Speaker',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'normalizedName': normalizedName,
      'detectedCount': detectedCount,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Speaker',
      if (id != null) 'id': id,
      'userId': userId,
      'name': name,
      'normalizedName': normalizedName,
      'detectedCount': detectedCount,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SpeakerInclude include() {
    return SpeakerInclude._();
  }

  static SpeakerIncludeList includeList({
    _i1.WhereExpressionBuilder<SpeakerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpeakerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpeakerTable>? orderByList,
    SpeakerInclude? include,
  }) {
    return SpeakerIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Speaker.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Speaker.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SpeakerImpl extends Speaker {
  _SpeakerImpl({
    int? id,
    required String userId,
    required String name,
    required String normalizedName,
    required int detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         normalizedName: normalizedName,
         detectedCount: detectedCount,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Speaker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Speaker copyWith({
    Object? id = _Undefined,
    String? userId,
    String? name,
    String? normalizedName,
    int? detectedCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Speaker(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      detectedCount: detectedCount ?? this.detectedCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class SpeakerUpdateTable extends _i1.UpdateTable<SpeakerTable> {
  SpeakerUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> normalizedName(String value) =>
      _i1.ColumnValue(
        table.normalizedName,
        value,
      );

  _i1.ColumnValue<int, int> detectedCount(int value) => _i1.ColumnValue(
    table.detectedCount,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SpeakerTable extends _i1.Table<int?> {
  SpeakerTable({super.tableRelation}) : super(tableName: 'speaker') {
    updateTable = SpeakerUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    normalizedName = _i1.ColumnString(
      'normalizedName',
      this,
    );
    detectedCount = _i1.ColumnInt(
      'detectedCount',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final SpeakerUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString normalizedName;

  late final _i1.ColumnInt detectedCount;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    name,
    normalizedName,
    detectedCount,
    createdAt,
    updatedAt,
  ];
}

class SpeakerInclude extends _i1.IncludeObject {
  SpeakerInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Speaker.t;
}

class SpeakerIncludeList extends _i1.IncludeList {
  SpeakerIncludeList._({
    _i1.WhereExpressionBuilder<SpeakerTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Speaker.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Speaker.t;
}

class SpeakerRepository {
  const SpeakerRepository._();

  /// Returns a list of [Speaker]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Speaker>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpeakerTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpeakerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpeakerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Speaker>(
      where: where?.call(Speaker.t),
      orderBy: orderBy?.call(Speaker.t),
      orderByList: orderByList?.call(Speaker.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Speaker] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Speaker?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpeakerTable>? where,
    int? offset,
    _i1.OrderByBuilder<SpeakerTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SpeakerTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Speaker>(
      where: where?.call(Speaker.t),
      orderBy: orderBy?.call(Speaker.t),
      orderByList: orderByList?.call(Speaker.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Speaker] by its [id] or null if no such row exists.
  Future<Speaker?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Speaker>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Speaker]s in the list and returns the inserted rows.
  ///
  /// The returned [Speaker]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Speaker>> insert(
    _i1.Session session,
    List<Speaker> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Speaker>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Speaker] and returns the inserted row.
  ///
  /// The returned [Speaker] will have its `id` field set.
  Future<Speaker> insertRow(
    _i1.Session session,
    Speaker row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Speaker>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Speaker]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Speaker>> update(
    _i1.Session session,
    List<Speaker> rows, {
    _i1.ColumnSelections<SpeakerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Speaker>(
      rows,
      columns: columns?.call(Speaker.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Speaker]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Speaker> updateRow(
    _i1.Session session,
    Speaker row, {
    _i1.ColumnSelections<SpeakerTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Speaker>(
      row,
      columns: columns?.call(Speaker.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Speaker] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Speaker?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SpeakerUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Speaker>(
      id,
      columnValues: columnValues(Speaker.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Speaker]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Speaker>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SpeakerUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SpeakerTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SpeakerTable>? orderBy,
    _i1.OrderByListBuilder<SpeakerTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Speaker>(
      columnValues: columnValues(Speaker.t.updateTable),
      where: where(Speaker.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Speaker.t),
      orderByList: orderByList?.call(Speaker.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Speaker]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Speaker>> delete(
    _i1.Session session,
    List<Speaker> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Speaker>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Speaker].
  Future<Speaker> deleteRow(
    _i1.Session session,
    Speaker row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Speaker>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Speaker>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SpeakerTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Speaker>(
      where: where(Speaker.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SpeakerTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Speaker>(
      where: where?.call(Speaker.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
