part of 'Request_bloc.dart';

@freezed
class RequestState with _$RequestState {
  const factory RequestState({
    required Email emailS,
    required Password passS,
    required bool isValid,
    required FormzSubmissionStatus status,
  }) = _RequestState;

  factory RequestState.initial() {
    return RequestState(
        emailS: const Email.pure(),
        passS: Password.pure(),
        isValid: false,
        status: FormzSubmissionStatus.initial);
  }
}
