import 'package:continuum/application/auth_service.dart';
import 'package:continuum/data/user_repository.dart';
import 'package:continuum/domain/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_service.g.dart';

class UserService {
  UserService(this.ref);
  final Ref ref;

  Future<bool> userExists(String userId) async {
    final user = await ref.read(userRepositoryProvider).fetchUserById(userId);
    return user != null;
  }

  Future<void> createUser(auth.User authUser) async {
    await ref
        .read(userRepositoryProvider)
        .createUser(
          User(
            id: authUser.uid,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            lastCheckInAt: DateTime.now(),
            name: authUser.displayName ?? 'Unknown',
            email: authUser.email,
            photoUrl: authUser.photoURL,
          ),
        );
  }

  Future<void> handleSignin({
    required auth.User? user,
    void Function()? onLoginComplete,
  }) async {
    if (user == null) throw Exception('Could not login');
    onLoginComplete?.call();
    if (!(await userExists(user.uid))) {
      // If user doesn't exist, create a new user
      await createUser(user);
    }
  }

  Future<void> updateCurrentUser(Map<String, dynamic> data) async {
    final uid = ref.read(authStateChangesProvider).value?.uid;
    debugPrint('uid: $uid');
    if (uid == null) throw Exception('User not logged in');
    return ref.read(userRepositoryProvider).updateUser(uid, data);
  }
}

@riverpod
UserService userService(Ref ref) => UserService(ref);
