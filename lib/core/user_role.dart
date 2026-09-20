import 'package:flutter/foundation.dart';

/// The two dashboard roles from the spec (PM vs Member).
///
/// This is a placeholder for real authentication/role assignment, which is
/// deferred until the backend (Firebase vs custom API) is decided.
enum UserRole { pm, member }

/// Holds which dashboard is currently active. Phase 0 has no auth, so the
/// role is picked from a landing screen and kept in memory only.
class SessionController extends ValueNotifier<UserRole?> {
  SessionController() : super(null);

  void selectRole(UserRole role) => value = role;

  void signOut() => value = null;
}
