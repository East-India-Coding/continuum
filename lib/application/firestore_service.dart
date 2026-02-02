import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_service.g.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> createData({
    required String path,
    required Map<String, dynamic> data,
    String? docId,
  }) async {
    final reference = FirebaseFirestore.instance.collection(path).doc(docId);
    await reference.set(data);
  }

  Future<void> updateData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  Future<List<T>> collection<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
    queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    try {
      Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(
        path,
      );
      if (queryBuilder != null) {
        query = queryBuilder(query);
      }
      final snapshots = await query.get();
      final result = snapshots.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }

      return result;
    } catch (e) {
      debugPrint('Error collection: $e');
      return Future.error('Error collection: $e');
    }
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query<Map<String, dynamic>> Function(Query<Map<String, dynamic>> query)?
    queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(
      path,
    );
    if (queryBuilder != null) query = queryBuilder(query);
    final snapshots = query.snapshots();

    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) => builder(snapshot.data(), snapshot.id))
          .where((value) => value != null)
          .toList();
      if (sort != null) result.sort(sort);

      return result;
    });
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) async {
    try {
      final reference = FirebaseFirestore.instance.doc(path);
      final snapshot = await reference.get();

      return builder(snapshot.data(), snapshot.id);
    } catch (e) {
      debugPrint('Error getDocument: $e');
      return Future.error('Error getDocument: $e');
    }
  }

  String generateNewDocId(String collectionPath) =>
      FirebaseFirestore.instance.collection(collectionPath).doc().id;

  DocumentReference getRefForPath(String docPath) =>
      FirebaseFirestore.instance.doc(docPath);

  Future<bool> dataExists({
    required String collectionPath,
    required Query<Map<String, dynamic>> Function(
      Query<Map<String, dynamic>> query,
    )
    queryBuilder,
  }) async {
    try {
      Query<Map<String, dynamic>> query = FirebaseFirestore.instance.collection(
        collectionPath,
      );
      query = queryBuilder(query);

      // Limit to 1 to optimize query performance
      final snapshot = await query
          .limit(1)
          .get()
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw TimeoutException('Query timed out'),
          );
      return snapshot.docs.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking data existence: $e');
      return Future.error('Error checking data existence: $e');
    }
  }
}

@Riverpod(keepAlive: true)
FirestoreService firestoreService(Ref ref) => FirestoreService.instance;
