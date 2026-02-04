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
import 'quote_reference.dart' as _i2;
import 'package:continuum_server/src/generated/protocol.dart' as _i3;

abstract class GraphNode
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  GraphNode._({
    this.id,
    required this.userId,
    required this.videoId,
    required this.label,
    required this.impactScore,
    required this.summary,
    required this.primarySpeakerId,
    required this.references,
    required this.embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : isBookmarked = isBookmarked ?? false,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory GraphNode({
    int? id,
    required String userId,
    required String videoId,
    required String label,
    required double impactScore,
    required String summary,
    required int primarySpeakerId,
    required List<_i2.QuoteReference> references,
    required _i1.Vector embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _GraphNodeImpl;

  factory GraphNode.fromJson(Map<String, dynamic> jsonSerialization) {
    return GraphNode(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as String,
      label: jsonSerialization['label'] as String,
      impactScore: (jsonSerialization['impactScore'] as num).toDouble(),
      summary: jsonSerialization['summary'] as String,
      primarySpeakerId: jsonSerialization['primarySpeakerId'] as int,
      references: _i3.Protocol().deserialize<List<_i2.QuoteReference>>(
        jsonSerialization['references'],
      ),
      embedding: _i1.VectorJsonExtension.fromJson(
        jsonSerialization['embedding'],
      ),
      isBookmarked: jsonSerialization['isBookmarked'] as bool?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = GraphNodeTable();

  static const db = GraphNodeRepository._();

  @override
  int? id;

  String userId;

  String videoId;

  String label;

  double impactScore;

  String summary;

  int primarySpeakerId;

  List<_i2.QuoteReference> references;

  _i1.Vector embedding;

  bool isBookmarked;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [GraphNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GraphNode copyWith({
    int? id,
    String? userId,
    String? videoId,
    String? label,
    double? impactScore,
    String? summary,
    int? primarySpeakerId,
    List<_i2.QuoteReference>? references,
    _i1.Vector? embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GraphNode',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'label': label,
      'impactScore': impactScore,
      'summary': summary,
      'primarySpeakerId': primarySpeakerId,
      'references': references.toJson(valueToJson: (v) => v.toJson()),
      'embedding': embedding.toJson(),
      'isBookmarked': isBookmarked,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'GraphNode',
      if (id != null) 'id': id,
      'userId': userId,
      'videoId': videoId,
      'label': label,
      'impactScore': impactScore,
      'summary': summary,
      'primarySpeakerId': primarySpeakerId,
      'references': references.toJson(
        valueToJson: (v) => v.toJsonForProtocol(),
      ),
      'embedding': embedding.toJson(),
      'isBookmarked': isBookmarked,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static GraphNodeInclude include() {
    return GraphNodeInclude._();
  }

  static GraphNodeIncludeList includeList({
    _i1.WhereExpressionBuilder<GraphNodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphNodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphNodeTable>? orderByList,
    GraphNodeInclude? include,
  }) {
    return GraphNodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GraphNode.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(GraphNode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _GraphNodeImpl extends GraphNode {
  _GraphNodeImpl({
    int? id,
    required String userId,
    required String videoId,
    required String label,
    required double impactScore,
    required String summary,
    required int primarySpeakerId,
    required List<_i2.QuoteReference> references,
    required _i1.Vector embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         videoId: videoId,
         label: label,
         impactScore: impactScore,
         summary: summary,
         primarySpeakerId: primarySpeakerId,
         references: references,
         embedding: embedding,
         isBookmarked: isBookmarked,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [GraphNode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GraphNode copyWith({
    Object? id = _Undefined,
    String? userId,
    String? videoId,
    String? label,
    double? impactScore,
    String? summary,
    int? primarySpeakerId,
    List<_i2.QuoteReference>? references,
    _i1.Vector? embedding,
    bool? isBookmarked,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return GraphNode(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      label: label ?? this.label,
      impactScore: impactScore ?? this.impactScore,
      summary: summary ?? this.summary,
      primarySpeakerId: primarySpeakerId ?? this.primarySpeakerId,
      references:
          references ?? this.references.map((e0) => e0.copyWith()).toList(),
      embedding: embedding ?? this.embedding.clone(),
      isBookmarked: isBookmarked ?? this.isBookmarked,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class GraphNodeUpdateTable extends _i1.UpdateTable<GraphNodeTable> {
  GraphNodeUpdateTable(super.table);

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> videoId(String value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<String, String> label(String value) => _i1.ColumnValue(
    table.label,
    value,
  );

  _i1.ColumnValue<double, double> impactScore(double value) => _i1.ColumnValue(
    table.impactScore,
    value,
  );

  _i1.ColumnValue<String, String> summary(String value) => _i1.ColumnValue(
    table.summary,
    value,
  );

  _i1.ColumnValue<int, int> primarySpeakerId(int value) => _i1.ColumnValue(
    table.primarySpeakerId,
    value,
  );

  _i1.ColumnValue<List<_i2.QuoteReference>, List<_i2.QuoteReference>>
  references(List<_i2.QuoteReference> value) => _i1.ColumnValue(
    table.references,
    value,
  );

  _i1.ColumnValue<_i1.Vector, _i1.Vector> embedding(_i1.Vector value) =>
      _i1.ColumnValue(
        table.embedding,
        value,
      );

  _i1.ColumnValue<bool, bool> isBookmarked(bool value) => _i1.ColumnValue(
    table.isBookmarked,
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

class GraphNodeTable extends _i1.Table<int?> {
  GraphNodeTable({super.tableRelation}) : super(tableName: 'graph_node') {
    updateTable = GraphNodeUpdateTable(this);
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    videoId = _i1.ColumnString(
      'videoId',
      this,
    );
    label = _i1.ColumnString(
      'label',
      this,
    );
    impactScore = _i1.ColumnDouble(
      'impactScore',
      this,
    );
    summary = _i1.ColumnString(
      'summary',
      this,
    );
    primarySpeakerId = _i1.ColumnInt(
      'primarySpeakerId',
      this,
    );
    references = _i1.ColumnSerializable<List<_i2.QuoteReference>>(
      'references',
      this,
    );
    embedding = _i1.ColumnVector(
      'embedding',
      this,
      dimension: 768,
    );
    isBookmarked = _i1.ColumnBool(
      'isBookmarked',
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
  }

  late final GraphNodeUpdateTable updateTable;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString videoId;

  late final _i1.ColumnString label;

  late final _i1.ColumnDouble impactScore;

  late final _i1.ColumnString summary;

  late final _i1.ColumnInt primarySpeakerId;

  late final _i1.ColumnSerializable<List<_i2.QuoteReference>> references;

  late final _i1.ColumnVector embedding;

  late final _i1.ColumnBool isBookmarked;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    videoId,
    label,
    impactScore,
    summary,
    primarySpeakerId,
    references,
    embedding,
    isBookmarked,
    createdAt,
    updatedAt,
  ];
}

class GraphNodeInclude extends _i1.IncludeObject {
  GraphNodeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => GraphNode.t;
}

class GraphNodeIncludeList extends _i1.IncludeList {
  GraphNodeIncludeList._({
    _i1.WhereExpressionBuilder<GraphNodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(GraphNode.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => GraphNode.t;
}

class GraphNodeRepository {
  const GraphNodeRepository._();

  /// Returns a list of [GraphNode]s matching the given query parameters.
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
  Future<List<GraphNode>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphNodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphNodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphNodeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<GraphNode>(
      where: where?.call(GraphNode.t),
      orderBy: orderBy?.call(GraphNode.t),
      orderByList: orderByList?.call(GraphNode.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [GraphNode] matching the given query parameters.
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
  Future<GraphNode?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphNodeTable>? where,
    int? offset,
    _i1.OrderByBuilder<GraphNodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<GraphNodeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<GraphNode>(
      where: where?.call(GraphNode.t),
      orderBy: orderBy?.call(GraphNode.t),
      orderByList: orderByList?.call(GraphNode.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [GraphNode] by its [id] or null if no such row exists.
  Future<GraphNode?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<GraphNode>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [GraphNode]s in the list and returns the inserted rows.
  ///
  /// The returned [GraphNode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<GraphNode>> insert(
    _i1.Session session,
    List<GraphNode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<GraphNode>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [GraphNode] and returns the inserted row.
  ///
  /// The returned [GraphNode] will have its `id` field set.
  Future<GraphNode> insertRow(
    _i1.Session session,
    GraphNode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<GraphNode>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [GraphNode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<GraphNode>> update(
    _i1.Session session,
    List<GraphNode> rows, {
    _i1.ColumnSelections<GraphNodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<GraphNode>(
      rows,
      columns: columns?.call(GraphNode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GraphNode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<GraphNode> updateRow(
    _i1.Session session,
    GraphNode row, {
    _i1.ColumnSelections<GraphNodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<GraphNode>(
      row,
      columns: columns?.call(GraphNode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [GraphNode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<GraphNode?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<GraphNodeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<GraphNode>(
      id,
      columnValues: columnValues(GraphNode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [GraphNode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<GraphNode>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<GraphNodeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<GraphNodeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<GraphNodeTable>? orderBy,
    _i1.OrderByListBuilder<GraphNodeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<GraphNode>(
      columnValues: columnValues(GraphNode.t.updateTable),
      where: where(GraphNode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(GraphNode.t),
      orderByList: orderByList?.call(GraphNode.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [GraphNode]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<GraphNode>> delete(
    _i1.Session session,
    List<GraphNode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<GraphNode>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [GraphNode].
  Future<GraphNode> deleteRow(
    _i1.Session session,
    GraphNode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<GraphNode>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<GraphNode>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<GraphNodeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<GraphNode>(
      where: where(GraphNode.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<GraphNodeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<GraphNode>(
      where: where?.call(GraphNode.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
