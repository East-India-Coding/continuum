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
import 'transcript_topic.dart' as _i2;
import 'package:continuum_server/src/generated/protocol.dart' as _i3;

abstract class SegmentedTranscript
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SegmentedTranscript._({
    this.id,
    this.videoId,
    required this.ideas,
  });

  factory SegmentedTranscript({
    int? id,
    String? videoId,
    required List<_i2.TranscriptTopic> ideas,
  }) = _SegmentedTranscriptImpl;

  factory SegmentedTranscript.fromJson(Map<String, dynamic> jsonSerialization) {
    return SegmentedTranscript(
      id: jsonSerialization['id'] as int?,
      videoId: jsonSerialization['videoId'] as String?,
      ideas: _i3.Protocol().deserialize<List<_i2.TranscriptTopic>>(
        jsonSerialization['ideas'],
      ),
    );
  }

  static final t = SegmentedTranscriptTable();

  static const db = SegmentedTranscriptRepository._();

  @override
  int? id;

  String? videoId;

  List<_i2.TranscriptTopic> ideas;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SegmentedTranscript]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SegmentedTranscript copyWith({
    int? id,
    String? videoId,
    List<_i2.TranscriptTopic>? ideas,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SegmentedTranscript',
      if (id != null) 'id': id,
      if (videoId != null) 'videoId': videoId,
      'ideas': ideas.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SegmentedTranscript',
      if (id != null) 'id': id,
      if (videoId != null) 'videoId': videoId,
      'ideas': ideas.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  static SegmentedTranscriptInclude include() {
    return SegmentedTranscriptInclude._();
  }

  static SegmentedTranscriptIncludeList includeList({
    _i1.WhereExpressionBuilder<SegmentedTranscriptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SegmentedTranscriptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SegmentedTranscriptTable>? orderByList,
    SegmentedTranscriptInclude? include,
  }) {
    return SegmentedTranscriptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SegmentedTranscript.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SegmentedTranscript.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SegmentedTranscriptImpl extends SegmentedTranscript {
  _SegmentedTranscriptImpl({
    int? id,
    String? videoId,
    required List<_i2.TranscriptTopic> ideas,
  }) : super._(
         id: id,
         videoId: videoId,
         ideas: ideas,
       );

  /// Returns a shallow copy of this [SegmentedTranscript]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SegmentedTranscript copyWith({
    Object? id = _Undefined,
    Object? videoId = _Undefined,
    List<_i2.TranscriptTopic>? ideas,
  }) {
    return SegmentedTranscript(
      id: id is int? ? id : this.id,
      videoId: videoId is String? ? videoId : this.videoId,
      ideas: ideas ?? this.ideas.map((e0) => e0.copyWith()).toList(),
    );
  }
}

class SegmentedTranscriptUpdateTable
    extends _i1.UpdateTable<SegmentedTranscriptTable> {
  SegmentedTranscriptUpdateTable(super.table);

  _i1.ColumnValue<String, String> videoId(String? value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<List<_i2.TranscriptTopic>, List<_i2.TranscriptTopic>> ideas(
    List<_i2.TranscriptTopic> value,
  ) => _i1.ColumnValue(
    table.ideas,
    value,
  );
}

class SegmentedTranscriptTable extends _i1.Table<int?> {
  SegmentedTranscriptTable({super.tableRelation})
    : super(tableName: 'segmented_transcript') {
    updateTable = SegmentedTranscriptUpdateTable(this);
    videoId = _i1.ColumnString(
      'videoId',
      this,
    );
    ideas = _i1.ColumnSerializable<List<_i2.TranscriptTopic>>(
      'ideas',
      this,
    );
  }

  late final SegmentedTranscriptUpdateTable updateTable;

  late final _i1.ColumnString videoId;

  late final _i1.ColumnSerializable<List<_i2.TranscriptTopic>> ideas;

  @override
  List<_i1.Column> get columns => [
    id,
    videoId,
    ideas,
  ];
}

class SegmentedTranscriptInclude extends _i1.IncludeObject {
  SegmentedTranscriptInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SegmentedTranscript.t;
}

class SegmentedTranscriptIncludeList extends _i1.IncludeList {
  SegmentedTranscriptIncludeList._({
    _i1.WhereExpressionBuilder<SegmentedTranscriptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SegmentedTranscript.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SegmentedTranscript.t;
}

class SegmentedTranscriptRepository {
  const SegmentedTranscriptRepository._();

  /// Returns a list of [SegmentedTranscript]s matching the given query parameters.
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
  Future<List<SegmentedTranscript>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SegmentedTranscriptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SegmentedTranscriptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SegmentedTranscriptTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SegmentedTranscript>(
      where: where?.call(SegmentedTranscript.t),
      orderBy: orderBy?.call(SegmentedTranscript.t),
      orderByList: orderByList?.call(SegmentedTranscript.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SegmentedTranscript] matching the given query parameters.
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
  Future<SegmentedTranscript?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SegmentedTranscriptTable>? where,
    int? offset,
    _i1.OrderByBuilder<SegmentedTranscriptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SegmentedTranscriptTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SegmentedTranscript>(
      where: where?.call(SegmentedTranscript.t),
      orderBy: orderBy?.call(SegmentedTranscript.t),
      orderByList: orderByList?.call(SegmentedTranscript.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SegmentedTranscript] by its [id] or null if no such row exists.
  Future<SegmentedTranscript?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SegmentedTranscript>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SegmentedTranscript]s in the list and returns the inserted rows.
  ///
  /// The returned [SegmentedTranscript]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SegmentedTranscript>> insert(
    _i1.Session session,
    List<SegmentedTranscript> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SegmentedTranscript>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SegmentedTranscript] and returns the inserted row.
  ///
  /// The returned [SegmentedTranscript] will have its `id` field set.
  Future<SegmentedTranscript> insertRow(
    _i1.Session session,
    SegmentedTranscript row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SegmentedTranscript>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SegmentedTranscript]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SegmentedTranscript>> update(
    _i1.Session session,
    List<SegmentedTranscript> rows, {
    _i1.ColumnSelections<SegmentedTranscriptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SegmentedTranscript>(
      rows,
      columns: columns?.call(SegmentedTranscript.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SegmentedTranscript]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SegmentedTranscript> updateRow(
    _i1.Session session,
    SegmentedTranscript row, {
    _i1.ColumnSelections<SegmentedTranscriptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SegmentedTranscript>(
      row,
      columns: columns?.call(SegmentedTranscript.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SegmentedTranscript] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SegmentedTranscript?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SegmentedTranscriptUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SegmentedTranscript>(
      id,
      columnValues: columnValues(SegmentedTranscript.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SegmentedTranscript]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SegmentedTranscript>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SegmentedTranscriptUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<SegmentedTranscriptTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SegmentedTranscriptTable>? orderBy,
    _i1.OrderByListBuilder<SegmentedTranscriptTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SegmentedTranscript>(
      columnValues: columnValues(SegmentedTranscript.t.updateTable),
      where: where(SegmentedTranscript.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SegmentedTranscript.t),
      orderByList: orderByList?.call(SegmentedTranscript.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SegmentedTranscript]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SegmentedTranscript>> delete(
    _i1.Session session,
    List<SegmentedTranscript> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SegmentedTranscript>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SegmentedTranscript].
  Future<SegmentedTranscript> deleteRow(
    _i1.Session session,
    SegmentedTranscript row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SegmentedTranscript>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SegmentedTranscript>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SegmentedTranscriptTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SegmentedTranscript>(
      where: where(SegmentedTranscript.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SegmentedTranscriptTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SegmentedTranscript>(
      where: where?.call(SegmentedTranscript.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
