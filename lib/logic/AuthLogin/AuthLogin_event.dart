part of 'AuthLogin_bloc.dart';

@freezed
class AuthLoginEvent with _$AuthLoginEvent {
  const factory AuthLoginEvent.emailChanged(String email) = _EmailChanged;
  const factory AuthLoginEvent.passChanged(String pass) = _PassChanged;
  const factory AuthLoginEvent.Submit() = _Submit;

}
