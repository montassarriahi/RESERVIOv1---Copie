// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'Request_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RequestState {
  Email get emailS => throw _privateConstructorUsedError;
  Password get passS => throw _privateConstructorUsedError;
  bool get isValid => throw _privateConstructorUsedError;
  FormzSubmissionStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RequestStateCopyWith<RequestState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestStateCopyWith<$Res> {
  factory $RequestStateCopyWith(
          RequestState value, $Res Function(RequestState) then) =
      _$RequestStateCopyWithImpl<$Res, RequestState>;
  @useResult
  $Res call(
      {Email emailS,
      Password passS,
      bool isValid,
      FormzSubmissionStatus status});
}

/// @nodoc
class _$RequestStateCopyWithImpl<$Res, $Val extends RequestState>
    implements $RequestStateCopyWith<$Res> {
  _$RequestStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailS = null,
    Object? passS = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      emailS: null == emailS
          ? _value.emailS
          : emailS // ignore: cast_nullable_to_non_nullable
              as Email,
      passS: null == passS
          ? _value.passS
          : passS // ignore: cast_nullable_to_non_nullable
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
abstract class _$$RequestStateImplCopyWith<$Res>
    implements $RequestStateCopyWith<$Res> {
  factory _$$RequestStateImplCopyWith(
          _$RequestStateImpl value, $Res Function(_$RequestStateImpl) then) =
      __$$RequestStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Email emailS,
      Password passS,
      bool isValid,
      FormzSubmissionStatus status});
}

/// @nodoc
class __$$RequestStateImplCopyWithImpl<$Res>
    extends _$RequestStateCopyWithImpl<$Res, _$RequestStateImpl>
    implements _$$RequestStateImplCopyWith<$Res> {
  __$$RequestStateImplCopyWithImpl(
      _$RequestStateImpl _value, $Res Function(_$RequestStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailS = null,
    Object? passS = null,
    Object? isValid = null,
    Object? status = null,
  }) {
    return _then(_$RequestStateImpl(
      emailS: null == emailS
          ? _value.emailS
          : emailS // ignore: cast_nullable_to_non_nullable
              as Email,
      passS: null == passS
          ? _value.passS
          : passS // ignore: cast_nullable_to_non_nullable
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

class _$RequestStateImpl implements _RequestState {
  const _$RequestStateImpl(
      {required this.emailS,
      required this.passS,
      required this.isValid,
      required this.status});

  @override
  final Email emailS;
  @override
  final Password passS;
  @override
  final bool isValid;
  @override
  final FormzSubmissionStatus status;

  @override
  String toString() {
    return 'RequestState(emailS: $emailS, passS: $passS, isValid: $isValid, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestStateImpl &&
            (identical(other.emailS, emailS) || other.emailS == emailS) &&
            (identical(other.passS, passS) || other.passS == passS) &&
            (identical(other.isValid, isValid) || other.isValid == isValid) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, emailS, passS, isValid, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestStateImplCopyWith<_$RequestStateImpl> get copyWith =>
      __$$RequestStateImplCopyWithImpl<_$RequestStateImpl>(this, _$identity);
}

abstract class _RequestState implements RequestState {
  const factory _RequestState(
      {required final Email emailS,
      required final Password passS,
      required final bool isValid,
      required final FormzSubmissionStatus status}) = _$RequestStateImpl;

  @override
  Email get emailS;
  @override
  Password get passS;
  @override
  bool get isValid;
  @override
  FormzSubmissionStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$RequestStateImplCopyWith<_$RequestStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RequestEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailS) emailChanged,
    required TResult Function(String passS) passChanged,
    required TResult Function() Submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailS)? emailChanged,
    TResult? Function(String passS)? passChanged,
    TResult? Function()? Submit,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailS)? emailChanged,
    TResult Function(String passS)? passChanged,
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
abstract class $RequestEventCopyWith<$Res> {
  factory $RequestEventCopyWith(
          RequestEvent value, $Res Function(RequestEvent) then) =
      _$RequestEventCopyWithImpl<$Res, RequestEvent>;
}

/// @nodoc
class _$RequestEventCopyWithImpl<$Res, $Val extends RequestEvent>
    implements $RequestEventCopyWith<$Res> {
  _$RequestEventCopyWithImpl(this._value, this._then);

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
  $Res call({String emailS});
}

/// @nodoc
class __$$EmailChangedImplCopyWithImpl<$Res>
    extends _$RequestEventCopyWithImpl<$Res, _$EmailChangedImpl>
    implements _$$EmailChangedImplCopyWith<$Res> {
  __$$EmailChangedImplCopyWithImpl(
      _$EmailChangedImpl _value, $Res Function(_$EmailChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailS = null,
  }) {
    return _then(_$EmailChangedImpl(
      null == emailS
          ? _value.emailS
          : emailS // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$EmailChangedImpl implements _EmailChanged {
  const _$EmailChangedImpl(this.emailS);

  @override
  final String emailS;

  @override
  String toString() {
    return 'RequestEvent.emailChanged(emailS: $emailS)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmailChangedImpl &&
            (identical(other.emailS, emailS) || other.emailS == emailS));
  }

  @override
  int get hashCode => Object.hash(runtimeType, emailS);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EmailChangedImplCopyWith<_$EmailChangedImpl> get copyWith =>
      __$$EmailChangedImplCopyWithImpl<_$EmailChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailS) emailChanged,
    required TResult Function(String passS) passChanged,
    required TResult Function() Submit,
  }) {
    return emailChanged(emailS);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailS)? emailChanged,
    TResult? Function(String passS)? passChanged,
    TResult? Function()? Submit,
  }) {
    return emailChanged?.call(emailS);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailS)? emailChanged,
    TResult Function(String passS)? passChanged,
    TResult Function()? Submit,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(emailS);
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

abstract class _EmailChanged implements RequestEvent {
  const factory _EmailChanged(final String emailS) = _$EmailChangedImpl;

  String get emailS;
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
  $Res call({String passS});
}

/// @nodoc
class __$$PassChangedImplCopyWithImpl<$Res>
    extends _$RequestEventCopyWithImpl<$Res, _$PassChangedImpl>
    implements _$$PassChangedImplCopyWith<$Res> {
  __$$PassChangedImplCopyWithImpl(
      _$PassChangedImpl _value, $Res Function(_$PassChangedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passS = null,
  }) {
    return _then(_$PassChangedImpl(
      null == passS
          ? _value.passS
          : passS // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PassChangedImpl implements _PassChanged {
  const _$PassChangedImpl(this.passS);

  @override
  final String passS;

  @override
  String toString() {
    return 'RequestEvent.passChanged(passS: $passS)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PassChangedImpl &&
            (identical(other.passS, passS) || other.passS == passS));
  }

  @override
  int get hashCode => Object.hash(runtimeType, passS);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PassChangedImplCopyWith<_$PassChangedImpl> get copyWith =>
      __$$PassChangedImplCopyWithImpl<_$PassChangedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String emailS) emailChanged,
    required TResult Function(String passS) passChanged,
    required TResult Function() Submit,
  }) {
    return passChanged(passS);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailS)? emailChanged,
    TResult? Function(String passS)? passChanged,
    TResult? Function()? Submit,
  }) {
    return passChanged?.call(passS);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailS)? emailChanged,
    TResult Function(String passS)? passChanged,
    TResult Function()? Submit,
    required TResult orElse(),
  }) {
    if (passChanged != null) {
      return passChanged(passS);
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

abstract class _PassChanged implements RequestEvent {
  const factory _PassChanged(final String passS) = _$PassChangedImpl;

  String get passS;
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
    extends _$RequestEventCopyWithImpl<$Res, _$SubmitImpl>
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
    return 'RequestEvent.Submit()';
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
    required TResult Function(String emailS) emailChanged,
    required TResult Function(String passS) passChanged,
    required TResult Function() Submit,
  }) {
    return Submit();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String emailS)? emailChanged,
    TResult? Function(String passS)? passChanged,
    TResult? Function()? Submit,
  }) {
    return Submit?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String emailS)? emailChanged,
    TResult Function(String passS)? passChanged,
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

abstract class _Submit implements RequestEvent {
  const factory _Submit() = _$SubmitImpl;
}
