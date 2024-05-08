part of 'Request_bloc.dart';

@freezed
class RequestEvent with _$RequestEvent {
  const factory RequestEvent.emailChanged(String emailS) = _EmailChanged;
  const factory RequestEvent.passChanged(String passS) = _PassChanged;
  const factory RequestEvent.Submit() = _Submit;
}