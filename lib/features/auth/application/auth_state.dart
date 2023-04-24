import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initializing() = _Initializing;
  const factory AuthState.authenticated(User? user) = _Authenticated;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticateCancel() = _AuthCancelled;
  const factory AuthState.error(String error, StackTrace stackTrace) = _Error;
}
