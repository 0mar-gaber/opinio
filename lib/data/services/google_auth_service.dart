import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../../data/models/base_model.dart';
import '../../domain/entities/base_entity.dart';

class GoogleAuthResult {
  final AuthUser? user;
  final bool redirectToSignUp;
  final bool redirectToSignIn;
  final bool canceled;
  final String? errorMessage;

  GoogleAuthResult({
    this.user,
    this.redirectToSignUp = false,
    this.redirectToSignIn = false,
    this.canceled = false,
    this.errorMessage,
  });

  factory GoogleAuthResult.success(AuthUser user) =>
      GoogleAuthResult(user: user);
  factory GoogleAuthResult.redirect() =>
      GoogleAuthResult(redirectToSignUp: true);
  factory GoogleAuthResult.redirectSignIn() =>
      GoogleAuthResult(redirectToSignIn: true);
  factory GoogleAuthResult.canceled() => GoogleAuthResult(canceled: true);
  factory GoogleAuthResult.error(String message) =>
      GoogleAuthResult(errorMessage: message);
}

class GoogleAuthService {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final FirebaseFirestore _firestore;

  GoogleAuthService({
    FirebaseAuth? auth,
    GoogleSignIn? googleSignIn,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: const ['email', 'profile'],
            ),
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<GoogleAuthResult> signInWithGoogle({bool forceAccountSelection = true}) async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.setCustomParameters({'prompt': 'select_account'});
        final userCredential = await _auth.signInWithPopup(provider);
        final isNew = userCredential.additionalUserInfo?.isNewUser ?? false;
        final user = userCredential.user;
        if (user == null) return GoogleAuthResult.error('No user returned');
        if (isNew) {
          try {
            await user.delete();
          } catch (_) {}
          await _auth.signOut();
          return GoogleAuthResult.redirect();
        }
        return GoogleAuthResult.success(AuthUserModel.fromFirebaseUser(user).toEntity());
      } else {
        if (forceAccountSelection) {
          await _googleSignIn.signOut();
        }
        final account = await _googleSignIn.signIn();
        if (account == null) {
          return GoogleAuthResult.canceled();
        }
        final authTokens = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: authTokens.accessToken,
          idToken: authTokens.idToken,
        );
        final result = await _auth.signInWithCredential(credential);
        final isNew = result.additionalUserInfo?.isNewUser ?? false;
        final user = result.user;
        if (user == null) {
          return GoogleAuthResult.error('No user returned');
        }
        if (isNew) {
          try {
            await user.delete();
          } catch (_) {}
          await _auth.signOut();
          return GoogleAuthResult.redirect();
        }
        return GoogleAuthResult.success(AuthUserModel.fromFirebaseUser(user).toEntity());
      }
    } on FirebaseAuthException catch (e) {
      final mapped = _mapFirebaseError(e);
      if (mapped == 'canceled') {
        return GoogleAuthResult.canceled();
      }
      return GoogleAuthResult.error(mapped);
    } on PlatformException catch (e) {
      final mapped = _mapPlatformError(e);
      if (mapped == 'canceled') {
        return GoogleAuthResult.canceled();
      }
      return GoogleAuthResult.error(mapped);
    } catch (e) {
      return GoogleAuthResult.error('Something went wrong. Please try again');
    }
  }

  Future<GoogleAuthResult> signUpWithGoogle({bool forceAccountSelection = true}) async {
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider();
        provider.setCustomParameters({'prompt': 'select_account'});
        final userCredential = await _auth.signInWithPopup(provider);
        final isNew = userCredential.additionalUserInfo?.isNewUser ?? false;
        final user = userCredential.user;
        if (user == null) return GoogleAuthResult.error('No user returned');
        if (!isNew) {
          await _auth.signOut();
          return GoogleAuthResult.redirectSignIn();
        } else {
          await _ensureUserDocument(user);
          return GoogleAuthResult.success(AuthUserModel.fromFirebaseUser(user).toEntity());
        }
      } else {
        if (forceAccountSelection) {
          await _googleSignIn.signOut();
        }
        final account = await _googleSignIn.signIn();
        if (account == null) {
          return GoogleAuthResult.canceled();
        }
        final authTokens = await account.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: authTokens.accessToken,
          idToken: authTokens.idToken,
        );
        final result = await _auth.signInWithCredential(credential);
        final isNew = result.additionalUserInfo?.isNewUser ?? false;
        final user = result.user;
        if (user == null) {
          return GoogleAuthResult.error('No user returned');
        }
        if (!isNew) {
          await _auth.signOut();
          return GoogleAuthResult.redirectSignIn();
        } else {
          await _ensureUserDocument(user);
          return GoogleAuthResult.success(AuthUserModel.fromFirebaseUser(user).toEntity());
        }
      }
    } on FirebaseAuthException catch (e) {
      final mapped = _mapFirebaseError(e);
      if (mapped == 'canceled') {
        return GoogleAuthResult.canceled();
      }
      return GoogleAuthResult.error(mapped);
    } on PlatformException catch (e) {
      final mapped = _mapPlatformError(e);
      if (mapped == 'canceled') {
        return GoogleAuthResult.canceled();
      }
      return GoogleAuthResult.error(mapped);
    } catch (e) {
      return GoogleAuthResult.error('Something went wrong. Please try again');
    }
  }

  Future<void> _ensureUserDocument(User user) async {
    final uid = user.uid;
    final email = user.email ?? '';
    final displayName = user.displayName ?? '';
    final docRef = _firestore.collection('users').doc(uid);
    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set({
        'uid': uid,
        'email': email,
        'displayName': displayName,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  String _mapFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'network-request-failed':
        return 'Network error. Check your connection';
      case 'account-exists-with-different-credential':
        return 'Account exists with different credentials';
      case 'operation-not-allowed':
        return 'Google sign-in not enabled in Firebase project';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later';
      case 'invalid-credential':
        return 'Invalid Google credential';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'popup-closed-by-user':
        return 'canceled';
      case 'web-context-canceled':
        return 'canceled';
      default:
        return 'Authentication failed (${e.code}). Please try again';
    }
  }

  String _mapPlatformError(PlatformException e) {
    final code = e.code.toLowerCase();
    if (code.contains('cancel')) return 'canceled';
    if (code.contains('network')) return 'Network error. Check your connection';
    if (code.contains('failed')) return 'Google sign-in failed';
    return 'Google sign-in failed (${e.code})';
  }
}
