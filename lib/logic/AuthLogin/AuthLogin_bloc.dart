import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reserviov1/formz/email.dart';
import 'package:reserviov1/formz/password.dart';

part 'AuthLogin_state.dart';
part 'AuthLogin_event.dart';
part 'AuthLogin_bloc.freezed.dart';

class AuthLoginBloc extends Bloc<AuthLoginEvent, AuthloginState> {
  AuthLoginBloc() : super(AuthloginState.initial()) {
    on<_EmailChanged>(onEmailChanged);
    on<_PassChanged>(onPassChanged);
    on<_Submit>(onSubmit);
  }
  onEmailChanged(_EmailChanged event, Emitter<AuthloginState> emit) {
    final email = Email.dirty(event.email);
    emit(state.copyWith(email: email,
    isValid: Formz.validate([email,state.pass])));
  }

  onPassChanged(_PassChanged event, Emitter<AuthloginState> emit) {
    final pass = Password.dirty(event.pass);
    emit(state.copyWith(pass: pass,
    isValid: Formz.validate([pass,state.email])
    ));
  }

  onSubmit(_Submit event, Emitter<AuthloginState> emit) {
    final userInformation = state;
    emit(userInformation);
  }
}
