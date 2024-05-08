part of 'AuthLogin_bloc.dart';

@freezed
class AuthloginState with _$AuthloginState {
  const factory AuthloginState({
    required Email email,
    required Password pass,
    required bool isValid,
    required FormzSubmissionStatus status,
  }) = _AuthloginState;

  factory AuthloginState.initial() {
    return AuthloginState(
        email: const Email.pure(),
        pass: Password.pure(),
        isValid: false,
        status: FormzSubmissionStatus.initial);
  }
}
