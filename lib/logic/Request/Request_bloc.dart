import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reserviov1/formz/email.dart';
import 'package:reserviov1/formz/password.dart';



part 'Request_state.dart';
part 'Request_event.dart';
part 'Request_bloc.freezed.dart';

class RequestBloc extends Bloc<RequestEvent,RequestState>{
  RequestBloc() : super( RequestState.initial()){
    on<_EmailChanged>(onEmailChanged);
    on<_PassChanged>(onPassChanged);
    on<_Submit>(onSubmit);
    }
     onEmailChanged(_EmailChanged event, Emitter<RequestState> emit) {
    final emailS = Email.dirty(event.emailS);
    emit(state.copyWith(emailS: emailS,
    isValid: Formz.validate([emailS,state.passS])));
  }

  onPassChanged(_PassChanged event, Emitter<RequestState> emit) {
    final passS = Password.dirty(event.passS);
    emit(state.copyWith(passS: passS,
    isValid: Formz.validate([passS,state.emailS])
    ));
  }

  onSubmit(_Submit event, Emitter<RequestState> emit) {
    final userInformation = state;
    emit(userInformation);
  }
}