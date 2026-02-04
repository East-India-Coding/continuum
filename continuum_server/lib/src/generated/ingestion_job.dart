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

abstract class IngestionJob
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  IngestionJob._({
    this.id,
    required this.podcastId,
    required this.userId,
    String? stage,
    String? status,
    this.errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    this.completedAt,
  }) : stage = stage ?? 'booting up',
       status = status ?? 'pending',
       progress = progress ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory IngestionJob({
    int? id,
    required int podcastId,
    required String userId,
    String? stage,
    String? status,
    String? errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) = _IngestionJobImpl;

  factory IngestionJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return IngestionJob(
      id: jsonSerialization['id'] as int?,
      podcastId: jsonSerialization['podcastId'] as int,
      userId: jsonSerialization['userId'] as String,
      stage: jsonSerialization['stage'] as String?,
      status: jsonSerialization['status'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      progress: jsonSerialization['progress'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
    );
  }

  static final t = IngestionJobTable();

  static const db = IngestionJobRepository._();

  @override
  int? id;

  int podcastId;

  String userId;

  String stage;

  String status;

  String? errorMessage;

  int progress;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? completedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [IngestionJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  IngestionJob copyWith({
    int? id,
    int? podcastId,
    String? userId,
    String? stage,
    String? status,
    String? errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'IngestionJob',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      'userId': userId,
      'stage': stage,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'progress': progress,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'IngestionJob',
      if (id != null) 'id': id,
      'podcastId': podcastId,
      'userId': userId,
      'stage': stage,
      'status': status,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'progress': progress,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
    };
  }

  static IngestionJobInclude include() {
    return IngestionJobInclude._();
  }

  static IngestionJobIncludeList includeList({
    _i1.WhereExpressionBuilder<IngestionJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IngestionJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IngestionJobTable>? orderByList,
    IngestionJobInclude? include,
  }) {
    return IngestionJobIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngestionJob.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(IngestionJob.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _IngestionJobImpl extends IngestionJob {
  _IngestionJobImpl({
    int? id,
    required int podcastId,
    required String userId,
    String? stage,
    String? status,
    String? errorMessage,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
  }) : super._(
         id: id,
         podcastId: podcastId,
         userId: userId,
         stage: stage,
         status: status,
         errorMessage: errorMessage,
         progress: progress,
         createdAt: createdAt,
         updatedAt: updatedAt,
         completedAt: completedAt,
       );

  /// Returns a shallow copy of this [IngestionJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  IngestionJob copyWith({
    Object? id = _Undefined,
    int? podcastId,
    String? userId,
    String? stage,
    String? status,
    Object? errorMessage = _Undefined,
    int? progress,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? completedAt = _Undefined,
  }) {
    return IngestionJob(
      id: id is int? ? id : this.id,
      podcastId: podcastId ?? this.podcastId,
      userId: userId ?? this.userId,
      stage: stage ?? this.stage,
      status: status ?? this.status,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      progress: progress ?? this.progress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
    );
  }
}

class IngestionJobUpdateTable extends _i1.UpdateTable<IngestionJobTable> {
  IngestionJobUpdateTable(super.table);

  _i1.ColumnValue<int, int> podcastId(int value) => _i1.ColumnValue(
    table.podcastId,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> stage(String value) => _i1.ColumnValue(
    table.stage,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> errorMessage(String? value) =>
      _i1.ColumnValue(
        table.errorMessage,
        value,
      );

  _i1.ColumnValue<int, int> progress(int value) => _i1.ColumnValue(
    table.progress,
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

  _i1.ColumnValue<DateTime, DateTime> completedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.completedAt,
        value,
      );
}

class IngestionJobTable extends _i1.Table<int?> {
  IngestionJobTable({super.tableRelation}) : super(tableName: 'ingestion_job') {
    updateTable = IngestionJobUpdateTable(this);
    podcastId = _i1.ColumnInt(
      'podcastId',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    stage = _i1.ColumnString(
      'stage',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnString(
      'status',
      this,
      hasDefault: true,
    );
    errorMessage = _i1.ColumnString(
      'errorMessage',
      this,
    );
    progress = _i1.ColumnInt(
      'progress',
      this,
      hasDefault: true,
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
    completedAt = _i1.ColumnDateTime(
      'completedAt',
      this,
    );
  }

  late final IngestionJobUpdateTable updateTable;

  late final _i1.ColumnInt podcastId;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString stage;

  late final _i1.ColumnString status;

  late final _i1.ColumnString errorMessage;

  late final _i1.ColumnInt progress;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime completedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    podcastId,
    userId,
    stage,
    status,
    errorMessage,
    progress,
    createdAt,
    updatedAt,
    completedAt,
  ];
}

class IngestionJobInclude extends _i1.IncludeObject {
  IngestionJobInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => IngestionJob.t;
}

class IngestionJobIncludeList extends _i1.IncludeList {
  IngestionJobIncludeList._({
    _i1.WhereExpressionBuilder<IngestionJobTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(IngestionJob.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => IngestionJob.t;
}

class IngestionJobRepository {
  const IngestionJobRepository._();

  /// Returns a list of [IngestionJob]s matching the given query parameters.
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
  Future<List<IngestionJob>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IngestionJobTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IngestionJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IngestionJobTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<IngestionJob>(
      where: where?.call(IngestionJob.t),
      orderBy: orderBy?.call(IngestionJob.t),
      orderByList: orderByList?.call(IngestionJob.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [IngestionJob] matching the given query parameters.
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
  Future<IngestionJob?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IngestionJobTable>? where,
    int? offset,
    _i1.OrderByBuilder<IngestionJobTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<IngestionJobTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<IngestionJob>(
      where: where?.call(IngestionJob.t),
      orderBy: orderBy?.call(IngestionJob.t),
      orderByList: orderByList?.call(IngestionJob.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [IngestionJob] by its [id] or null if no such row exists.
  Future<IngestionJob?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<IngestionJob>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [IngestionJob]s in the list and returns the inserted rows.
  ///
  /// The returned [IngestionJob]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<IngestionJob>> insert(
    _i1.Session session,
    List<IngestionJob> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<IngestionJob>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [IngestionJob] and returns the inserted row.
  ///
  /// The returned [IngestionJob] will have its `id` field set.
  Future<IngestionJob> insertRow(
    _i1.Session session,
    IngestionJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<IngestionJob>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [IngestionJob]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<IngestionJob>> update(
    _i1.Session session,
    List<IngestionJob> rows, {
    _i1.ColumnSelections<IngestionJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<IngestionJob>(
      rows,
      columns: columns?.call(IngestionJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IngestionJob]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<IngestionJob> updateRow(
    _i1.Session session,
    IngestionJob row, {
    _i1.ColumnSelections<IngestionJobTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<IngestionJob>(
      row,
      columns: columns?.call(IngestionJob.t),
      transaction: transaction,
    );
  }

  /// Updates a single [IngestionJob] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<IngestionJob?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<IngestionJobUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<IngestionJob>(
      id,
      columnValues: columnValues(IngestionJob.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [IngestionJob]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<IngestionJob>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<IngestionJobUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<IngestionJobTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<IngestionJobTable>? orderBy,
    _i1.OrderByListBuilder<IngestionJobTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<IngestionJob>(
      columnValues: columnValues(IngestionJob.t.updateTable),
      where: where(IngestionJob.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(IngestionJob.t),
      orderByList: orderByList?.call(IngestionJob.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [IngestionJob]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<IngestionJob>> delete(
    _i1.Session session,
    List<IngestionJob> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<IngestionJob>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [IngestionJob].
  Future<IngestionJob> deleteRow(
    _i1.Session session,
    IngestionJob row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<IngestionJob>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<IngestionJob>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<IngestionJobTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<IngestionJob>(
      where: where(IngestionJob.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<IngestionJobTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<IngestionJob>(
      where: where?.call(IngestionJob.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
