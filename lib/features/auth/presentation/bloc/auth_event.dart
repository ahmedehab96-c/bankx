import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  const AuthLoginRequested({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

class AuthLogoutRequested extends AuthEvent {
  const AuthLogoutRequested();
}

class AuthOtpVerified extends AuthEvent {
  const AuthOtpVerified(this.code);

  final String code;

  @override
  List<Object?> get props => [code];
}

class AuthRegisterRequested extends AuthEvent {
  const AuthRegisterRequested({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<Object?> get props => [name, email, password];
}

class AuthResetPasswordRequested extends AuthEvent {
  const AuthResetPasswordRequested(this.email);

  final String email;

  @override
  List<Object?> get props => [email];
}

class AuthMessagesCleared extends AuthEvent {
  const AuthMessagesCleared();
}

class AuthSessionRestored extends AuthEvent {
  const AuthSessionRestored();
}
