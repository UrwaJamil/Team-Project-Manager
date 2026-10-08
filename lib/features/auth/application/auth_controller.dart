import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/app_user.dart';
import '../data/auth_repository.dart';
import '../data/user_repository.dart';

class AuthState {
  const AuthState({this.user, this.profile, this.sessionRole, this.loading = true});

  final User? user;
  final AppUser? profile;

  /// Which dashboard this session lands on. Always the account's real
  /// `users/{uid}.defaultRole` (FR-1.3) — never whatever the login
  /// screen's role toggle happened to show, which is a pre-fill/visual
  /// convenience only and must not affect routing.
  final UserRole? sessionRole;

  final bool loading;

  bool get isLoggedIn => user != null;

  AuthState copyWith({
    User? user,
    AppUser? profile,
    UserRole? sessionRole,
    bool? loading,
  }) {
    return AuthState(
      user: user ?? this.user,
      profile: profile ?? this.profile,
      sessionRole: sessionRole ?? this.sessionRole,
      loading: loading ?? this.loading,
    );
  }
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(
  AuthController.new,
);

class AuthController extends Notifier<AuthState> {
  StreamSubscription<User?>? _authSub;

  @override
  AuthState build() {
    final repo = ref.watch(authRepositoryProvider);
    _authSub = repo.authStateChanges().listen(_onAuthChanged);
    ref.onDispose(() => _authSub?.cancel());
    return const AuthState(loading: true);
  }

  Future<void> _onAuthChanged(User? user) async {
    if (user == null) {
      state = const AuthState(loading: false);
      return;
    }
    // An explicit sessionRole already resolved for this same uid (just
    // logged in/registered via the methods below) — keep it as-is.
    if (state.sessionRole != null && state.user?.uid == user.uid) {
      state = state.copyWith(user: user, loading: false);
      return;
    }
    await _settleSessionFor(user);
  }

  /// Always resolves the landing dashboard from the account's real,
  /// stored `defaultRole` — this is the single source of truth for
  /// routing, whether this is a fresh login, a freshly-restored session
  /// on app start, or (just after `register`) the role just written.
  Future<void> _settleSessionFor(User user) async {
    final profile = await ref.read(userRepositoryProvider).fetch(user.uid);
    // Re-check: another call may have already settled this same uid
    // while this fetch was in flight — don't stomp it.
    if (state.sessionRole != null && state.user?.uid == user.uid) {
      state = state.copyWith(profile: profile, loading: false);
      return;
    }
    state = AuthState(
      user: user,
      profile: profile,
      sessionRole: profile?.defaultRole ?? UserRole.leader,
      loading: false,
    );
  }

  /// Deliberately takes no role parameter: the login screen's role toggle
  /// is a pre-fill/visual convenience only and must not affect routing —
  /// the account's real, stored `defaultRole` always decides the
  /// dashboard (FR-1.3).
  Future<void> login({required String email, required String password}) async {
    final credential = await ref
        .read(authRepositoryProvider)
        .signIn(email: email, password: password);
    await _settleSessionFor(credential.user!);
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required UserRole defaultRole,
  }) async {
    final credential = await ref
        .read(authRepositoryProvider)
        .register(email: email, password: password);
    final user = credential.user!;
    final profile = AppUser(
      uid: user.uid,
      name: name,
      email: email,
      defaultRole: defaultRole,
      skillTags: const [],
      createdAt: DateTime.now(),
    );
    // TEMPORARY DEBUG — remove after confirming the toggle's value reaches
    // the write correctly.
    debugPrint(
      'register(): toggle selected defaultRole=$defaultRole -> '
      'writing defaultRole="${profile.toMap()['defaultRole']}" for uid=${user.uid}',
    );
    await ref.read(userRepositoryProvider).create(profile);
    state = AuthState(
      user: user,
      profile: profile,
      sessionRole: profile.defaultRole,
      loading: false,
    );
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    state = const AuthState(loading: false);
  }

  Future<void> updateProfile({String? name, List<String>? skillTags}) async {
    final current = state.profile;
    if (current == null) return;
    final updated = current.copyWith(name: name, skillTags: skillTags);
    final patch = <String, dynamic>{
      if (name != null) 'name': updated.name,
      if (skillTags != null) 'skillTags': updated.skillTags,
    };
    await ref.read(userRepositoryProvider).update(current.uid, patch);
    state = state.copyWith(profile: updated);
  }
}
