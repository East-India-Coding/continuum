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

abstract class GraphEdge
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  GraphEdge._({
    this.id,
    required this.userId,
    required this.sourceNodeId,
    required this.targetNodeId,
    required this.weight,
  });

  factory GraphEdge({
    int? id,
    required String userId,
    required int sourceNodeId,
    required int targetNodeId,
    required double weight,
  }) = _GraphEdgeImpl;

  factory GraphEdge.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphEdge(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      sourceNodeId: jsonSerialization['sourceNodeId'] as int,
      targetNodeId: jsonSerialization['targetNodeId'] as int,
      weight: (jsonSerialization['weight'] as num).toDouble(),
    );
  }

  static final t = GraphEdgeTable();

  static const db = GraphEdgeRepository._();

  @override
  int? id;

  String userId;

  int sourceNodeId;

  int targetNodeId;

  double weight;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [GraphEdge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphEdge copyWith({
    int? id,
    String? userId,
    int? sourceNodeId,
    int? targetNodeId,
    double? weight,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphEdge',
      if (id != null) 'id': id,
      'userId': userId,
      'sourceNodeId': sourceNodeId,
      'targetNodeId': targetNodeId,
      'weight': weight,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphEdge',
      if (id != null) 'id': id,
      'userId': userId,
      'sourceNodeId': sourceNodeId,
      'targetNodeId': targetNodeId,
      'weight': weight,
    };
  }

  static GraphEdgeInclude include() {
    return GraphEdgeInclude._();
  }

  static GraphEdgeIncludeList includeList({
    _i1.WhereExpressionBuilder<GraphEdgeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphEdgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphEdgeTable>? orderByList,
    GraphEdgeInclude? include,
  }) {
    return GraphEdgeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GraphEdge.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GraphEdge.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GraphEdgeImpl extends GraphEdge {
  _GraphEdgeImpl({
    int? id,
    required String userId,
    required int sourceNodeId,
    required int targetNodeId,
    required double weight,
  }) : super._(
         id: id,
         userId: userId,
         sourceNodeId: sourceNodeId,
         targetNodeId: targetNodeId,
         weight: weight,
       );

  /// Returns a shallow copy of this [GraphEdge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphEdge copyWith({
    Object? id = _Undefined,
    String? userId,
    int? sourceNodeId,
    int? targetNodeId,
    double? weight,
  }) {
    return GraphEdge(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      sourceNodeId: sourceNodeId ?? this.sourceNodeId,
      targetNodeId: targetNodeId ?? this.targetNodeId,
      weight: weight ?? this.weight,
    );
  }
}

class GraphEdgeUpdateTable extends _i1.UpdateTable<GraphEdgeTable> {
  GraphEdgeUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<int, int> sourceNodeId(int value) => _i1.ColumnValue(
    table.sourceNodeId,
    value,
  );

  _i1.ColumnValue<int, int> targetNodeId(int value) => _i1.ColumnValue(
    table.targetNodeId,
    value,
  );

  _i1.ColumnValue<double, double> weight(double value) => _i1.ColumnValue(
    table.weight,
    value,
  );
}

class GraphEdgeTable extends _i1.Table<int?> {
  GraphEdgeTable({super.tableRelation}) : super(tableName: 'graph_edge') {
    updateTable = GraphEdgeUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    sourceNodeId = _i1.ColumnInt(
      'sourceNodeId',
      this,
    );
    targetNodeId = _i1.ColumnInt(
      'targetNodeId',
      this,
    );
    weight = _i1.ColumnDouble(
      'weight',
      this,
    );
  }

  late final GraphEdgeUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnInt sourceNodeId;

  late final _i1.ColumnInt targetNodeId;

  late final _i1.ColumnDouble weight;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    sourceNodeId,
    targetNodeId,
    weight,
  ];
}

class GraphEdgeInclude extends _i1.IncludeObject {
  GraphEdgeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => GraphEdge.t;
}

class GraphEdgeIncludeList extends _i1.IncludeList {
  GraphEdgeIncludeList._({
    _i1.WhereExpressionBuilder<GraphEdgeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GraphEdge.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GraphEdge.t;
}

class GraphEdgeRepository {
  const GraphEdgeRepository._();

  /// Returns a list of [GraphEdge]s matching the given query parameters.
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
  Future<List<GraphEdge>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphEdgeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphEdgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphEdgeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<GraphEdge>(
      where: where?.call(GraphEdge.t),
      orderBy: orderBy?.call(GraphEdge.t),
      orderByList: orderByList?.call(GraphEdge.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [GraphEdge] matching the given query parameters.
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
  Future<GraphEdge?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphEdgeTable>? where,
    int? offset,
    _i1.OrderByBuilder<GraphEdgeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphEdgeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<GraphEdge>(
      where: where?.call(GraphEdge.t),
      orderBy: orderBy?.call(GraphEdge.t),
      orderByList: orderByList?.call(GraphEdge.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [GraphEdge] by its [id] or null if no such row exists.
  Future<GraphEdge?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<GraphEdge>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [GraphEdge]s in the list and returns the inserted rows.
  ///
  /// The returned [GraphEdge]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<GraphEdge>> insert(
    _i1.Session session,
    List<GraphEdge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<GraphEdge>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [GraphEdge] and returns the inserted row.
  ///
  /// The returned [GraphEdge] will have its `id` field set.
  Future<GraphEdge> insertRow(
    _i1.Session session,
    GraphEdge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GraphEdge>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GraphEdge]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GraphEdge>> update(
    _i1.Session session,
    List<GraphEdge> rows, {
    _i1.ColumnSelections<GraphEdgeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GraphEdge>(
      rows,
      columns: columns?.call(GraphEdge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GraphEdge]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GraphEdge> updateRow(
    _i1.Session session,
    GraphEdge row, {
    _i1.ColumnSelections<GraphEdgeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GraphEdge>(
      row,
      columns: columns?.call(GraphEdge.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GraphEdge] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GraphEdge?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<GraphEdgeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<GraphEdge>(
      id,
      columnValues: columnValues(GraphEdge.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GraphEdge]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<GraphEdge>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<GraphEdgeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GraphEdgeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphEdgeTable>? orderBy,
    _i1.OrderByListBuilder<GraphEdgeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<GraphEdge>(
      columnValues: columnValues(GraphEdge.t.updateTable),
      where: where(GraphEdge.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GraphEdge.t),
      orderByList: orderByList?.call(GraphEdge.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [GraphEdge]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GraphEdge>> delete(
    _i1.Session session,
    List<GraphEdge> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GraphEdge>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GraphEdge].
  Future<GraphEdge> deleteRow(
    _i1.Session session,
    GraphEdge row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GraphEdge>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GraphEdge>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GraphEdgeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GraphEdge>(
      where: where(GraphEdge.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphEdgeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GraphEdge>(
      where: where?.call(GraphEdge.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
