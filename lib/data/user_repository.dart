import 'package:continuum/application/firestore_service.dart';
import 'package:continuum/domain/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

class UserRepository {
  UserRepository({required this.firestoreService});
  final FirestoreService firestoreService;

  Future<User?> fetchUserById(String uid) async =>
      firestoreService.getDocument<User?>(
        path: 'users/$uid',
        builder: (data, documentID) =>
            data != null ? User.fromJson(data, documentID) : null,
      );

  Stream<User?> streamUserById(String uid) =>
      firestoreService.documentStream<User?>(
        path: 'users/$uid',
        builder: (data, documentID) =>
            data != null ? User.fromJson(data, documentID) : null,
      );

  Future<void> createUser(User user) => firestoreService.createData(
    path: 'users',
    data: user.toJson(),
    docId: user.id,
  );

  Future<void> updateUser(String uid, Map<String, dynamic> data) =>
      firestoreService.updateData(
        path: 'users/$uid',
        data: data,
      );
}

@riverpod
UserRepository userRepository(Ref ref) =>
    UserRepository(firestoreService: ref.watch(firestoreServiceProvider));

@riverpod
Stream<User?> streamUserById(Ref ref, String uid) =>
    ref.watch(userRepositoryProvider).streamUserById(uid);
