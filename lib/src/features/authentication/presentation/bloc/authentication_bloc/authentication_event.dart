part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

class AuthenticationOnUserChanged extends AuthenticationEvent {
  final User? user;
  const AuthenticationOnUserChanged(this.user);
}
