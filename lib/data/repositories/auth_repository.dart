import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../datasources/remote_datasource.dart';
import '../../data/models/base_model.dart';
import '../../domain/entities/base_entity.dart';

abstract class AuthRepository {
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<AuthUser> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<AuthUser?> getCurrentUser();

  Future<AuthUser?> reloadCurrentUser();

  Future<void> sendEmailVerification();
}

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource _remote;

  AuthRepositoryImpl(this._remote);

  @override
  Future<AuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _remote.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;
    return AuthUserModel.fromFirebaseUser(user).toEntity();
  }

  @override
  Future<AuthUser> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _remote.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credential.user!;
    try {
      await user.updateDisplayName(name);
      await user.reload();
      final refreshed = FirebaseAuth.instance.currentUser ?? user;
      try {
        final firestore = FirebaseFirestore.instance;
        final docRef = firestore.collection('users').doc(refreshed.uid);
        final snapshot = await docRef.get();
        if (!snapshot.exists) {
          await docRef.set({
            'uid': refreshed.uid,
            'email': refreshed.email ?? email,
            'displayName': refreshed.displayName ?? name,
            'profileCompleted': false,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      } catch (_) {}
      return AuthUserModel.fromFirebaseUser(refreshed).toEntity();
    } catch (_) {
      return AuthUserModel.fromFirebaseUser(user).toEntity();
    }
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    final user = _remote.getCurrentUser();
    if (user == null) return null;
    return AuthUserModel.fromFirebaseUser(user).toEntity();
  }

  @override
  Future<AuthUser?> reloadCurrentUser() async {
    final user = await _remote.reloadCurrentUser();
    if (user == null) return null;
    return AuthUserModel.fromFirebaseUser(user).toEntity();
  }

  @override
  Future<void> sendEmailVerification() {
    return _remote.sendEmailVerification();
  }
}
