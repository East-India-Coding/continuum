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

abstract class Podcast
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Podcast._({
    this.id,
    required this.youtubeUrl,
    required this.userId,
    required this.videoId,
    this.title,
    this.channelName,
    this.thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  }) : createdAt = createdAt ?? DateTime.now(),
       graphExists = graphExists ?? false;

  factory Podcast({
    int? id,
    required String youtubeUrl,
    required String userId,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  }) = _PodcastImpl;

  factory Podcast.fromJson(Map<String, dynamic> jsonSerialization) {
    return Podcast(
      id: jsonSerialization['id'] as int?,
      youtubeUrl: jsonSerialization['youtubeUrl'] as String,
      userId: jsonSerialization['userId'] as String,
      videoId: jsonSerialization['videoId'] as String,
      title: jsonSerialization['title'] as String?,
      channelName: jsonSerialization['channelName'] as String?,
      thumbnailUrl: jsonSerialization['thumbnailUrl'] as String?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      graphExists: jsonSerialization['graphExists'] as bool?,
    );
  }

  static final t = PodcastTable();

  static const db = PodcastRepository._();

  @override
  int? id;

  String youtubeUrl;

  String userId;

  String videoId;

  String? title;

  String? channelName;

  String? thumbnailUrl;

  DateTime createdAt;

  bool graphExists;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Podcast]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Podcast copyWith({
    int? id,
    String? youtubeUrl,
    String? userId,
    String? videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Podcast',
      if (id != null) 'id': id,
      'youtubeUrl': youtubeUrl,
      'userId': userId,
      'videoId': videoId,
      if (title != null) 'title': title,
      if (channelName != null) 'channelName': channelName,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt.toJson(),
      'graphExists': graphExists,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Podcast',
      if (id != null) 'id': id,
      'youtubeUrl': youtubeUrl,
      'userId': userId,
      'videoId': videoId,
      if (title != null) 'title': title,
      if (channelName != null) 'channelName': channelName,
      if (thumbnailUrl != null) 'thumbnailUrl': thumbnailUrl,
      'createdAt': createdAt.toJson(),
      'graphExists': graphExists,
    };
  }

  static PodcastInclude include() {
    return PodcastInclude._();
  }

  static PodcastIncludeList includeList({
    _i1.WhereExpressionBuilder<PodcastTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PodcastTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PodcastTable>? orderByList,
    PodcastInclude? include,
  }) {
    return PodcastIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Podcast.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Podcast.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PodcastImpl extends Podcast {
  _PodcastImpl({
    int? id,
    required String youtubeUrl,
    required String userId,
    required String videoId,
    String? title,
    String? channelName,
    String? thumbnailUrl,
    DateTime? createdAt,
    bool? graphExists,
  }) : super._(
         id: id,
         youtubeUrl: youtubeUrl,
         userId: userId,
         videoId: videoId,
         title: title,
         channelName: channelName,
         thumbnailUrl: thumbnailUrl,
         createdAt: createdAt,
         graphExists: graphExists,
       );

  /// Returns a shallow copy of this [Podcast]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Podcast copyWith({
    Object? id = _Undefined,
    String? youtubeUrl,
    String? userId,
    String? videoId,
    Object? title = _Undefined,
    Object? channelName = _Undefined,
    Object? thumbnailUrl = _Undefined,
    DateTime? createdAt,
    bool? graphExists,
  }) {
    return Podcast(
      id: id is int? ? id : this.id,
      youtubeUrl: youtubeUrl ?? this.youtubeUrl,
      userId: userId ?? this.userId,
      videoId: videoId ?? this.videoId,
      title: title is String? ? title : this.title,
      channelName: channelName is String? ? channelName : this.channelName,
      thumbnailUrl: thumbnailUrl is String? ? thumbnailUrl : this.thumbnailUrl,
      createdAt: createdAt ?? this.createdAt,
      graphExists: graphExists ?? this.graphExists,
    );
  }
}

class PodcastUpdateTable extends _i1.UpdateTable<PodcastTable> {
  PodcastUpdateTable(super.table);

  _i1.ColumnValue<String, String> youtubeUrl(String value) => _i1.ColumnValue(
    table.youtubeUrl,
    value,
  );

  _i1.ColumnValue<String, String> userId(String value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> videoId(String value) => _i1.ColumnValue(
    table.videoId,
    value,
  );

  _i1.ColumnValue<String, String> title(String? value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> channelName(String? value) => _i1.ColumnValue(
    table.channelName,
    value,
  );

  _i1.ColumnValue<String, String> thumbnailUrl(String? value) =>
      _i1.ColumnValue(
        table.thumbnailUrl,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<bool, bool> graphExists(bool value) => _i1.ColumnValue(
    table.graphExists,
    value,
  );
}

class PodcastTable extends _i1.Table<int?> {
  PodcastTable({super.tableRelation}) : super(tableName: 'podcast') {
    updateTable = PodcastUpdateTable(this);
    youtubeUrl = _i1.ColumnString(
      'youtubeUrl',
      this,
    );
    userId = _i1.ColumnString(
      'userId',
      this,
    );
    videoId = _i1.ColumnString(
      'videoId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    channelName = _i1.ColumnString(
      'channelName',
      this,
    );
    thumbnailUrl = _i1.ColumnString(
      'thumbnailUrl',
      this,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    graphExists = _i1.ColumnBool(
      'graphExists',
      this,
      hasDefault: true,
    );
  }

  late final PodcastUpdateTable updateTable;

  late final _i1.ColumnString youtubeUrl;

  late final _i1.ColumnString userId;

  late final _i1.ColumnString videoId;

  late final _i1.ColumnString title;

  late final _i1.ColumnString channelName;

  late final _i1.ColumnString thumbnailUrl;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnBool graphExists;

  @override
  List<_i1.Column> get columns => [
    id,
    youtubeUrl,
    userId,
    videoId,
    title,
    channelName,
    thumbnailUrl,
    createdAt,
    graphExists,
  ];
}

class PodcastInclude extends _i1.IncludeObject {
  PodcastInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Podcast.t;
}

class PodcastIncludeList extends _i1.IncludeList {
  PodcastIncludeList._({
    _i1.WhereExpressionBuilder<PodcastTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Podcast.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Podcast.t;
}

class PodcastRepository {
  const PodcastRepository._();

  /// Returns a list of [Podcast]s matching the given query parameters.
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
  Future<List<Podcast>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PodcastTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PodcastTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PodcastTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Podcast>(
      where: where?.call(Podcast.t),
      orderBy: orderBy?.call(Podcast.t),
      orderByList: orderByList?.call(Podcast.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Podcast] matching the given query parameters.
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
  Future<Podcast?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PodcastTable>? where,
    int? offset,
    _i1.OrderByBuilder<PodcastTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PodcastTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Podcast>(
      where: where?.call(Podcast.t),
      orderBy: orderBy?.call(Podcast.t),
      orderByList: orderByList?.call(Podcast.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Podcast] by its [id] or null if no such row exists.
  Future<Podcast?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Podcast>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Podcast]s in the list and returns the inserted rows.
  ///
  /// The returned [Podcast]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Podcast>> insert(
    _i1.Session session,
    List<Podcast> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Podcast>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Podcast] and returns the inserted row.
  ///
  /// The returned [Podcast] will have its `id` field set.
  Future<Podcast> insertRow(
    _i1.Session session,
    Podcast row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Podcast>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Podcast]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Podcast>> update(
    _i1.Session session,
    List<Podcast> rows, {
    _i1.ColumnSelections<PodcastTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Podcast>(
      rows,
      columns: columns?.call(Podcast.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Podcast]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Podcast> updateRow(
    _i1.Session session,
    Podcast row, {
    _i1.ColumnSelections<PodcastTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Podcast>(
      row,
      columns: columns?.call(Podcast.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Podcast] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Podcast?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<PodcastUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Podcast>(
      id,
      columnValues: columnValues(Podcast.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Podcast]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Podcast>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<PodcastUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<PodcastTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PodcastTable>? orderBy,
    _i1.OrderByListBuilder<PodcastTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Podcast>(
      columnValues: columnValues(Podcast.t.updateTable),
      where: where(Podcast.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Podcast.t),
      orderByList: orderByList?.call(Podcast.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Podcast]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Podcast>> delete(
    _i1.Session session,
    List<Podcast> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Podcast>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Podcast].
  Future<Podcast> deleteRow(
    _i1.Session session,
    Podcast row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Podcast>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Podcast>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PodcastTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Podcast>(
      where: where(Podcast.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PodcastTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Podcast>(
      where: where?.call(Podcast.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
