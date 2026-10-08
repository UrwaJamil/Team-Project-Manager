import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/misc.dart' show Override;

import 'package:team_project_manager/features/auth/data/app_user.dart';
import 'package:team_project_manager/features/auth/data/auth_repository.dart';
import 'package:team_project_manager/features/auth/data/user_repository.dart';

class FakeUser implements User {
  FakeUser(this.uid);

  @override
  final String uid;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeCredential implements UserCredential {
  _FakeCredential(this.user);

  @override
  final User? user;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// In-memory stand-in for [AuthRepository]. Like Firebase, it signs the
/// user in on register/sign-in and emits on [authStateChanges]
/// asynchronously.
class FakeAuthRepository implements AuthRepository {
  final _changes = StreamController<User?>.broadcast();

  /// email -> (password, uid)
  final accounts = <String, ({String password, String uid})>{};
  final calls = <String>[];
  bool failDelete = false;
  var _nextUid = 0;

  @override
  User? currentUser;

  /// Simulates a session restored on app start.
  void restoreSession(String uid) {
    currentUser = FakeUser(uid);
    _changes.add(currentUser);
  }

  /// Emits the current state, as Firebase does on first subscription.
  void emitInitial() => _changes.add(currentUser);

  @override
  Stream<User?> authStateChanges() => _changes.stream;

  @override
  Future<UserCredential> register({
    required String email,
    required String password,
  }) async {
    calls.add('register');
    final uid = 'uid-${_nextUid++}';
    accounts[email] = (password: password, uid: uid);
    currentUser = FakeUser(uid);
    _changes.add(currentUser);
    return _FakeCredential(currentUser);
  }

  @override
  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    calls.add('signIn');
    final account = accounts[email];
    if (account == null || account.password != password) {
      throw FirebaseAuthException(code: 'invalid-credential');
    }
    currentUser = FakeUser(account.uid);
    _changes.add(currentUser);
    return _FakeCredential(currentUser);
  }

  @override
  Future<void> signOut() async {
    calls.add('signOut');
    currentUser = null;
    _changes.add(null);
  }

  @override
  Future<void> deleteUser(User user) async {
    calls.add('deleteUser');
    if (failDelete) throw FirebaseAuthException(code: 'requires-recent-login');
    accounts.removeWhere((_, a) => a.uid == user.uid);
    currentUser = null;
    _changes.add(null);
  }
}

/// In-memory `users` collection. Stores the raw maps [AppUser.toMap]
/// produces and parses them back with [AppUser.fromMap], so tests exercise
/// the real serialization.
class FakeUserRepository implements UserRepository {
  final docs = <String, Map<String, dynamic>>{};
  bool failCreate = false;

  @override
  Future<void> create(AppUser user) async {
    if (failCreate) throw StateError('forced users.create failure');
    docs[user.uid] = user.toMap();
  }

  @override
  Future<AppUser?> fetch(String uid) async {
    final data = docs[uid];
    return data == null ? null : AppUser.fromMap(uid, data);
  }

  @override
  Future<void> update(String uid, Map<String, dynamic> patch) async {
    docs[uid]!.addAll(patch);
  }
}

List<Override> fakeAuthOverrides({
  FakeAuthRepository? auth,
  FakeUserRepository? users,
}) => [
  authRepositoryProvider.overrideWithValue(auth ?? FakeAuthRepository()),
  userRepositoryProvider.overrideWithValue(users ?? FakeUserRepository()),
];
