import 'package:continuum_client/continuum_client.dart';
import 'package:continuum_flutter/application/serverpod_client.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

part 'auth_service.g.dart';

class AuthService {
  AuthService(this.client);
  final Client client;

  String? get currentUserId => client.auth.authInfo?.authUserId.uuid;

  bool get isAuthenticated => client.auth.isAuthenticated;

  ValueListenable<AuthSuccess?> get authInfoListenable =>
      client.auth.authInfoListenable;

  Future<UserProfileModel?> getCurrentUserProfile() async {
    if (!isAuthenticated) return null;
    final userProfile = await client.modules.serverpod_auth_core.userProfileInfo
        .get();
    return userProfile;
  }

  Future<void> signOut() async {
    await client.auth.signOutDevice();
  }
}

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) {
  final client = ref.watch(serverpodClientProvider);
  return AuthService(client);
}

@riverpod
Future<UserProfileModel?> getCurrentUserProfile(Ref ref) async {
  final authService = ref.read(authServiceProvider);
  return authService.getCurrentUserProfile();
}
