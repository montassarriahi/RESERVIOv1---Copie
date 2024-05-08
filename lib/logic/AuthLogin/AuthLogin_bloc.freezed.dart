// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'AuthLogin_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AuthloginState {
  Email get email => throw _privateConstructorUsedError;
  Password get pass => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthloginStateCopyWith<AuthloginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthloginStateCopyWith<$Res> {
  factory $AuthloginStateCopyWith(
          AuthloginState value, $Res Function(AuthloginState) then) =
      _$AuthloginStateCopyWithImpl<$Res, AuthloginState>;
  @useResult
  $Res call(
      {Email email, Password pass, bool isValid, FormzSubmissionStatus status});
}

/// @nodoc
class _$AuthloginStateCopyWithImpl<$Res, $Val extends AuthloginState>
    implements $AuthloginStateCopyWith<$Res> {
  _$AuthloginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? pass = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Email,
      pass: null == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as Password,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthloginStateImplCopyWith<$Res>
    implements $AuthloginStateCopyWith<$Res> {
  factory _$$AuthloginStateImplCopyWith(_$AuthloginStateImpl value,
          $Res Function(_$AuthloginStateImpl) then) =
      __$$AuthloginStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Email email, Password pass, bool isValid, FormzSubmissionStatus status});
}

/// @nodoc
class __$$AuthloginStateImplCopyWithImpl<$Res>
    extends _$AuthloginStateCopyWithImpl<$Res, _$AuthloginStateImpl>
    implements _$$AuthloginStateImplCopyWith<$Res> {
  __$$AuthloginStateImplCopyWithImpl(
      _$AuthloginStateImpl _value, $Res Function(_$AuthloginStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? pass = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_$AuthloginStateImpl(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Email,
      pass: null == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as Password,
      isValid: null == isValid
          ? _value.isValid
          : isValid // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzSubmissionStatus,
    ));
  }
}

/// @nodoc

class _$AuthloginStateImpl implements _AuthloginState {
  const _$AuthloginStateImpl(
      {required this.email,
      required this.pass,
      required this.isValid,
      required this.status});

  @override
  final Email email;
  @override
  final Password pass;
  @override
  final bool isValid;
  @override
  final FormzSubmissionStatus status;

  @override
  String toString() {
    return 'AuthloginState(email: $email, pass: $pass, isValid: $isValid, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthloginStateImpl &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.pass, pass) || other.pass == pass) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, pass, isValid, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthloginStateImplCopyWith<_$AuthloginStateImpl> get copyWith =>
      __$$AuthloginStateImplCopyWithImpl<_$AuthloginStateImpl>(
          this, _$identity);
}

abstract class _AuthloginState implements AuthloginState {
  const factory _AuthloginState(
      {required final Email email,
      required final Password pass,
      required final bool isValid,
      required final FormzSubmissionStatus status}) = _$AuthloginStateImpl;

  @override
  Email get email;
  @override
  Password get pass;
  @override
  bool get isValid;
  @override
  FormzSubmissionStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$AuthloginStateImplCopyWith<_$AuthloginStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AuthLoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String pass) passChanged,
    required TResult Function() Submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String pass)? passChanged,
    TResult? Function()? Submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String pass)? passChanged,
    TResult Function()? Submit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmailChanged value) emailChanged,
    required TResult Function(_PassChanged value) passChanged,
    required TResult Function(_Submit value) Submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EmailChanged value)? emailChanged,
    TResult? Function(_PassChanged value)? passChanged,
    TResult? Function(_Submit value)? Submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmailChanged value)? emailChanged,
    TResult Function(_PassChanged value)? passChanged,
    TResult Function(_Submit value)? Submit,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthLoginEventCopyWith<$Res> {
  factory $AuthLoginEventCopyWith(
          AuthLoginEvent value, $Res Function(AuthLoginEvent) then) =
      _$AuthLoginEventCopyWithImpl<$Res, AuthLoginEvent>;
}

/// @nodoc
class _$AuthLoginEventCopyWithImpl<$Res, $Val extends AuthLoginEvent>
    implements $AuthLoginEventCopyWith<$Res> {
  _$AuthLoginEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$EmailChangedImplCopyWith<$Res> {
  factory _$$EmailChangedImplCopyWith(
          _$EmailChangedImpl value, $Res Function(_$EmailChangedImpl) then) =
      __$$EmailChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String email});
}

/// @nodoc
class __$$EmailChangedImplCopyWithImpl<$Res>
    extends _$AuthLoginEventCopyWithImpl<$Res, _$EmailChangedImpl>
    implements _$$EmailChangedImplCopyWith<$Res> {
  __$$EmailChangedImplCopyWithImpl(
      _$EmailChangedImpl _value, $Res Function(_$EmailChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
  }) {
    return _then(_$EmailChangedImpl(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailChangedImpl implements _EmailChanged {
  const _$EmailChangedImpl(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'AuthLoginEvent.emailChanged(email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailChangedImpl &&
            (identical(other.email, email) || other.email == email));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      __$$EmailChangedImplCopyWithImpl<_$EmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String pass) passChanged,
    required TResult Function() Submit,
  }) {
    return emailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String pass)? passChanged,
    TResult? Function()? Submit,
  }) {
    return emailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String pass)? passChanged,
    TResult Function()? Submit,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmailChanged value) emailChanged,
    required TResult Function(_PassChanged value) passChanged,
    required TResult Function(_Submit value) Submit,
  }) {
    return emailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EmailChanged value)? emailChanged,
    TResult? Function(_PassChanged value)? passChanged,
    TResult? Function(_Submit value)? Submit,
  }) {
    return emailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmailChanged value)? emailChanged,
    TResult Function(_PassChanged value)? passChanged,
    TResult Function(_Submit value)? Submit,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(this);
    }
    return orElse();
  }
}

abstract class _EmailChanged implements AuthLoginEvent {
  const factory _EmailChanged(final String email) = _$EmailChangedImpl;

  String get email;
  @JsonKey(ignore: true)
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PassChangedImplCopyWith<$Res> {
  factory _$$PassChangedImplCopyWith(
          _$PassChangedImpl value, $Res Function(_$PassChangedImpl) then) =
      __$$PassChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String pass});
}

/// @nodoc
class __$$PassChangedImplCopyWithImpl<$Res>
    extends _$AuthLoginEventCopyWithImpl<$Res, _$PassChangedImpl>
    implements _$$PassChangedImplCopyWith<$Res> {
  __$$PassChangedImplCopyWithImpl(
      _$PassChangedImpl _value, $Res Function(_$PassChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pass = null,
  }) {
    return _then(_$PassChangedImpl(
      null == pass
          ? _value.pass
          : pass // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PassChangedImpl implements _PassChanged {
  const _$PassChangedImpl(this.pass);

  @override
  final String pass;

  @override
  String toString() {
    return 'AuthLoginEvent.passChanged(pass: $pass)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassChangedImpl &&
            (identical(other.pass, pass) || other.pass == pass));
  }

  @override
  int get hashCode => Object.hash(runtimeType, pass);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PassChangedImplCopyWith<_$PassChangedImpl> get copyWith =>
      __$$PassChangedImplCopyWithImpl<_$PassChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String pass) passChanged,
    required TResult Function() Submit,
  }) {
    return passChanged(pass);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String pass)? passChanged,
    TResult? Function()? Submit,
  }) {
    return passChanged?.call(pass);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String pass)? passChanged,
    TResult Function()? Submit,
    required TResult orElse(),
  }) {
    if (passChanged != null) {
      return passChanged(pass);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmailChanged value) emailChanged,
    required TResult Function(_PassChanged value) passChanged,
    required TResult Function(_Submit value) Submit,
  }) {
    return passChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EmailChanged value)? emailChanged,
    TResult? Function(_PassChanged value)? passChanged,
    TResult? Function(_Submit value)? Submit,
  }) {
    return passChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmailChanged value)? emailChanged,
    TResult Function(_PassChanged value)? passChanged,
    TResult Function(_Submit value)? Submit,
    required TResult orElse(),
  }) {
    if (passChanged != null) {
      return passChanged(this);
    }
    return orElse();
  }
}

abstract class _PassChanged implements AuthLoginEvent {
  const factory _PassChanged(final String pass) = _$PassChangedImpl;

  String get pass;
  @JsonKey(ignore: true)
  _$$PassChangedImplCopyWith<_$PassChangedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SubmitImplCopyWith<$Res> {
  factory _$$SubmitImplCopyWith(
          _$SubmitImpl value, $Res Function(_$SubmitImpl) then) =
      __$$SubmitImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SubmitImplCopyWithImpl<$Res>
    extends _$AuthLoginEventCopyWithImpl<$Res, _$SubmitImpl>
    implements _$$SubmitImplCopyWith<$Res> {
  __$$SubmitImplCopyWithImpl(
      _$SubmitImpl _value, $Res Function(_$SubmitImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$SubmitImpl implements _Submit {
  const _$SubmitImpl();

  @override
  String toString() {
    return 'AuthLoginEvent.Submit()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SubmitImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String email) emailChanged,
    required TResult Function(String pass) passChanged,
    required TResult Function() Submit,
  }) {
    return Submit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String email)? emailChanged,
    TResult? Function(String pass)? passChanged,
    TResult? Function()? Submit,
  }) {
    return Submit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String email)? emailChanged,
    TResult Function(String pass)? passChanged,
    TResult Function()? Submit,
    required TResult orElse(),
  }) {
    if (Submit != null) {
      return Submit();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_EmailChanged value) emailChanged,
    required TResult Function(_PassChanged value) passChanged,
    required TResult Function(_Submit value) Submit,
  }) {
    return Submit(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_EmailChanged value)? emailChanged,
    TResult? Function(_PassChanged value)? passChanged,
    TResult? Function(_Submit value)? Submit,
  }) {
    return Submit?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_EmailChanged value)? emailChanged,
    TResult Function(_PassChanged value)? passChanged,
    TResult Function(_Submit value)? Submit,
    required TResult orElse(),
  }) {
    if (Submit != null) {
      return Submit(this);
    }
    return orElse();
  }
}

abstract class _Submit implements AuthLoginEvent {
  const factory _Submit() = _$SubmitImpl;
}
