// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'banking_dtos.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthTokensDto {

@JsonKey(name: 'access_token') String get accessToken;@JsonKey(name: 'refresh_token') String get refreshToken;
/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthTokensDtoCopyWith<AuthTokensDto> get copyWith => _$AuthTokensDtoCopyWithImpl<AuthTokensDto>(this as AuthTokensDto, _$identity);

  /// Serializes this AuthTokensDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthTokensDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'AuthTokensDto(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class $AuthTokensDtoCopyWith<$Res>  {
  factory $AuthTokensDtoCopyWith(AuthTokensDto value, $Res Function(AuthTokensDto) _then) = _$AuthTokensDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class _$AuthTokensDtoCopyWithImpl<$Res>
    implements $AuthTokensDtoCopyWith<$Res> {
  _$AuthTokensDtoCopyWithImpl(this._self, this._then);

  final AuthTokensDto _self;
  final $Res Function(AuthTokensDto) _then;

/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthTokensDto].
extension AuthTokensDtoPatterns on AuthTokensDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthTokensDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthTokensDto value)  $default,){
final _that = this;
switch (_that) {
case _AuthTokensDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthTokensDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken)  $default,) {final _that = this;
switch (_that) {
case _AuthTokensDto():
return $default(_that.accessToken,_that.refreshToken);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'access_token')  String accessToken, @JsonKey(name: 'refresh_token')  String refreshToken)?  $default,) {final _that = this;
switch (_that) {
case _AuthTokensDto() when $default != null:
return $default(_that.accessToken,_that.refreshToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthTokensDto implements AuthTokensDto {
  const _AuthTokensDto({@JsonKey(name: 'access_token') required this.accessToken, @JsonKey(name: 'refresh_token') required this.refreshToken});
  factory _AuthTokensDto.fromJson(Map<String, dynamic> json) => _$AuthTokensDtoFromJson(json);

@override@JsonKey(name: 'access_token') final  String accessToken;
@override@JsonKey(name: 'refresh_token') final  String refreshToken;

/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthTokensDtoCopyWith<_AuthTokensDto> get copyWith => __$AuthTokensDtoCopyWithImpl<_AuthTokensDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthTokensDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthTokensDto&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.refreshToken, refreshToken) || other.refreshToken == refreshToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,refreshToken);

@override
String toString() {
  return 'AuthTokensDto(accessToken: $accessToken, refreshToken: $refreshToken)';
}


}

/// @nodoc
abstract mixin class _$AuthTokensDtoCopyWith<$Res> implements $AuthTokensDtoCopyWith<$Res> {
  factory _$AuthTokensDtoCopyWith(_AuthTokensDto value, $Res Function(_AuthTokensDto) _then) = __$AuthTokensDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'access_token') String accessToken,@JsonKey(name: 'refresh_token') String refreshToken
});




}
/// @nodoc
class __$AuthTokensDtoCopyWithImpl<$Res>
    implements _$AuthTokensDtoCopyWith<$Res> {
  __$AuthTokensDtoCopyWithImpl(this._self, this._then);

  final _AuthTokensDto _self;
  final $Res Function(_AuthTokensDto) _then;

/// Create a copy of AuthTokensDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? refreshToken = null,}) {
  return _then(_AuthTokensDto(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,refreshToken: null == refreshToken ? _self.refreshToken : refreshToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$LoginRequestDto {

 String get email; String get password;
/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestDtoCopyWith<LoginRequestDto> get copyWith => _$LoginRequestDtoCopyWithImpl<LoginRequestDto>(this as LoginRequestDto, _$identity);

  /// Serializes this LoginRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginRequestDto(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginRequestDtoCopyWith<$Res>  {
  factory $LoginRequestDtoCopyWith(LoginRequestDto value, $Res Function(LoginRequestDto) _then) = _$LoginRequestDtoCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$LoginRequestDtoCopyWithImpl<$Res>
    implements $LoginRequestDtoCopyWith<$Res> {
  _$LoginRequestDtoCopyWithImpl(this._self, this._then);

  final LoginRequestDto _self;
  final $Res Function(LoginRequestDto) _then;

/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginRequestDto].
extension LoginRequestDtoPatterns on LoginRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _LoginRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that.email,_that.password);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String password)  $default,) {final _that = this;
switch (_that) {
case _LoginRequestDto():
return $default(_that.email,_that.password);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String password)?  $default,) {final _that = this;
switch (_that) {
case _LoginRequestDto() when $default != null:
return $default(_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoginRequestDto implements LoginRequestDto {
  const _LoginRequestDto({required this.email, required this.password});
  factory _LoginRequestDto.fromJson(Map<String, dynamic> json) => _$LoginRequestDtoFromJson(json);

@override final  String email;
@override final  String password;

/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginRequestDtoCopyWith<_LoginRequestDto> get copyWith => __$LoginRequestDtoCopyWithImpl<_LoginRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoginRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginRequestDto&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'LoginRequestDto(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$LoginRequestDtoCopyWith<$Res> implements $LoginRequestDtoCopyWith<$Res> {
  factory _$LoginRequestDtoCopyWith(_LoginRequestDto value, $Res Function(_LoginRequestDto) _then) = __$LoginRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class __$LoginRequestDtoCopyWithImpl<$Res>
    implements _$LoginRequestDtoCopyWith<$Res> {
  __$LoginRequestDtoCopyWithImpl(this._self, this._then);

  final _LoginRequestDto _self;
  final $Res Function(_LoginRequestDto) _then;

/// Create a copy of LoginRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(_LoginRequestDto(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$RegisterRequestDto {

 String get name; String get email; String get password;
/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestDtoCopyWith<RegisterRequestDto> get copyWith => _$RegisterRequestDtoCopyWithImpl<RegisterRequestDto>(this as RegisterRequestDto, _$identity);

  /// Serializes this RegisterRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequestDto&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,password);

@override
String toString() {
  return 'RegisterRequestDto(name: $name, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $RegisterRequestDtoCopyWith<$Res>  {
  factory $RegisterRequestDtoCopyWith(RegisterRequestDto value, $Res Function(RegisterRequestDto) _then) = _$RegisterRequestDtoCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password
});




}
/// @nodoc
class _$RegisterRequestDtoCopyWithImpl<$Res>
    implements $RegisterRequestDtoCopyWith<$Res> {
  _$RegisterRequestDtoCopyWithImpl(this._self, this._then);

  final RegisterRequestDto _self;
  final $Res Function(RegisterRequestDto) _then;

/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? password = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RegisterRequestDto].
extension RegisterRequestDtoPatterns on RegisterRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RegisterRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RegisterRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RegisterRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
return $default(_that.name,_that.email,_that.password);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String password)  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestDto():
return $default(_that.name,_that.email,_that.password);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String password)?  $default,) {final _that = this;
switch (_that) {
case _RegisterRequestDto() when $default != null:
return $default(_that.name,_that.email,_that.password);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RegisterRequestDto implements RegisterRequestDto {
  const _RegisterRequestDto({required this.name, required this.email, required this.password});
  factory _RegisterRequestDto.fromJson(Map<String, dynamic> json) => _$RegisterRequestDtoFromJson(json);

@override final  String name;
@override final  String email;
@override final  String password;

/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RegisterRequestDtoCopyWith<_RegisterRequestDto> get copyWith => __$RegisterRequestDtoCopyWithImpl<_RegisterRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RegisterRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RegisterRequestDto&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,password);

@override
String toString() {
  return 'RegisterRequestDto(name: $name, email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class _$RegisterRequestDtoCopyWith<$Res> implements $RegisterRequestDtoCopyWith<$Res> {
  factory _$RegisterRequestDtoCopyWith(_RegisterRequestDto value, $Res Function(_RegisterRequestDto) _then) = __$RegisterRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String password
});




}
/// @nodoc
class __$RegisterRequestDtoCopyWithImpl<$Res>
    implements _$RegisterRequestDtoCopyWith<$Res> {
  __$RegisterRequestDtoCopyWithImpl(this._self, this._then);

  final _RegisterRequestDto _self;
  final $Res Function(_RegisterRequestDto) _then;

/// Create a copy of RegisterRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,}) {
  return _then(_RegisterRequestDto(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$AuthResponseDto {

 AuthTokensDto get tokens; UserDto get user;
/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResponseDtoCopyWith<AuthResponseDto> get copyWith => _$AuthResponseDtoCopyWithImpl<AuthResponseDto>(this as AuthResponseDto, _$identity);

  /// Serializes this AuthResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResponseDto&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokens,user);

@override
String toString() {
  return 'AuthResponseDto(tokens: $tokens, user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthResponseDtoCopyWith<$Res>  {
  factory $AuthResponseDtoCopyWith(AuthResponseDto value, $Res Function(AuthResponseDto) _then) = _$AuthResponseDtoCopyWithImpl;
@useResult
$Res call({
 AuthTokensDto tokens, UserDto user
});


$AuthTokensDtoCopyWith<$Res> get tokens;$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthResponseDtoCopyWithImpl<$Res>
    implements $AuthResponseDtoCopyWith<$Res> {
  _$AuthResponseDtoCopyWithImpl(this._self, this._then);

  final AuthResponseDto _self;
  final $Res Function(AuthResponseDto) _then;

/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tokens = null,Object? user = null,}) {
  return _then(_self.copyWith(
tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as AuthTokensDto,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,
  ));
}
/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthTokensDtoCopyWith<$Res> get tokens {
  
  return $AuthTokensDtoCopyWith<$Res>(_self.tokens, (value) {
    return _then(_self.copyWith(tokens: value));
  });
}/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [AuthResponseDto].
extension AuthResponseDtoPatterns on AuthResponseDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthResponseDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _AuthResponseDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _AuthResponseDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AuthTokensDto tokens,  UserDto user)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthResponseDto() when $default != null:
return $default(_that.tokens,_that.user);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AuthTokensDto tokens,  UserDto user)  $default,) {final _that = this;
switch (_that) {
case _AuthResponseDto():
return $default(_that.tokens,_that.user);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AuthTokensDto tokens,  UserDto user)?  $default,) {final _that = this;
switch (_that) {
case _AuthResponseDto() when $default != null:
return $default(_that.tokens,_that.user);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthResponseDto implements AuthResponseDto {
  const _AuthResponseDto({required this.tokens, required this.user});
  factory _AuthResponseDto.fromJson(Map<String, dynamic> json) => _$AuthResponseDtoFromJson(json);

@override final  AuthTokensDto tokens;
@override final  UserDto user;

/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthResponseDtoCopyWith<_AuthResponseDto> get copyWith => __$AuthResponseDtoCopyWithImpl<_AuthResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthResponseDto&&(identical(other.tokens, tokens) || other.tokens == tokens)&&(identical(other.user, user) || other.user == user));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tokens,user);

@override
String toString() {
  return 'AuthResponseDto(tokens: $tokens, user: $user)';
}


}

/// @nodoc
abstract mixin class _$AuthResponseDtoCopyWith<$Res> implements $AuthResponseDtoCopyWith<$Res> {
  factory _$AuthResponseDtoCopyWith(_AuthResponseDto value, $Res Function(_AuthResponseDto) _then) = __$AuthResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 AuthTokensDto tokens, UserDto user
});


@override $AuthTokensDtoCopyWith<$Res> get tokens;@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$AuthResponseDtoCopyWithImpl<$Res>
    implements _$AuthResponseDtoCopyWith<$Res> {
  __$AuthResponseDtoCopyWithImpl(this._self, this._then);

  final _AuthResponseDto _self;
  final $Res Function(_AuthResponseDto) _then;

/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tokens = null,Object? user = null,}) {
  return _then(_AuthResponseDto(
tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as AuthTokensDto,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,
  ));
}

/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthTokensDtoCopyWith<$Res> get tokens {
  
  return $AuthTokensDtoCopyWith<$Res>(_self.tokens, (value) {
    return _then(_self.copyWith(tokens: value));
  });
}/// Create a copy of AuthResponseDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$UserDto {

 String get id; String get name; String get email;
/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDtoCopyWith<UserDto> get copyWith => _$UserDtoCopyWithImpl<UserDto>(this as UserDto, _$identity);

  /// Serializes this UserDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email);

@override
String toString() {
  return 'UserDto(id: $id, name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class $UserDtoCopyWith<$Res>  {
  factory $UserDtoCopyWith(UserDto value, $Res Function(UserDto) _then) = _$UserDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email
});




}
/// @nodoc
class _$UserDtoCopyWithImpl<$Res>
    implements $UserDtoCopyWith<$Res> {
  _$UserDtoCopyWithImpl(this._self, this._then);

  final UserDto _self;
  final $Res Function(UserDto) _then;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserDto].
extension UserDtoPatterns on UserDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDto value)  $default,){
final _that = this;
switch (_that) {
case _UserDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDto value)?  $default,){
final _that = this;
switch (_that) {
case _UserDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDto() when $default != null:
return $default(_that.id,_that.name,_that.email);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email)  $default,) {final _that = this;
switch (_that) {
case _UserDto():
return $default(_that.id,_that.name,_that.email);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email)?  $default,) {final _that = this;
switch (_that) {
case _UserDto() when $default != null:
return $default(_that.id,_that.name,_that.email);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserDto implements UserDto {
  const _UserDto({required this.id, required this.name, required this.email});
  factory _UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDtoCopyWith<_UserDto> get copyWith => __$UserDtoCopyWithImpl<_UserDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email);

@override
String toString() {
  return 'UserDto(id: $id, name: $name, email: $email)';
}


}

/// @nodoc
abstract mixin class _$UserDtoCopyWith<$Res> implements $UserDtoCopyWith<$Res> {
  factory _$UserDtoCopyWith(_UserDto value, $Res Function(_UserDto) _then) = __$UserDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email
});




}
/// @nodoc
class __$UserDtoCopyWithImpl<$Res>
    implements _$UserDtoCopyWith<$Res> {
  __$UserDtoCopyWithImpl(this._self, this._then);

  final _UserDto _self;
  final $Res Function(_UserDto) _then;

/// Create a copy of UserDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,}) {
  return _then(_UserDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ProfileDto {

 UserDto get user;@JsonKey(name: 'card_count') int get cardCount; String? get phone;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'member_since') String? get memberSince;
/// Create a copy of ProfileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDtoCopyWith<ProfileDto> get copyWith => _$ProfileDtoCopyWithImpl<ProfileDto>(this as ProfileDto, _$identity);

  /// Serializes this ProfileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileDto&&(identical(other.user, user) || other.user == user)&&(identical(other.cardCount, cardCount) || other.cardCount == cardCount)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,cardCount,phone,avatarUrl,memberSince);

@override
String toString() {
  return 'ProfileDto(user: $user, cardCount: $cardCount, phone: $phone, avatarUrl: $avatarUrl, memberSince: $memberSince)';
}


}

/// @nodoc
abstract mixin class $ProfileDtoCopyWith<$Res>  {
  factory $ProfileDtoCopyWith(ProfileDto value, $Res Function(ProfileDto) _then) = _$ProfileDtoCopyWithImpl;
@useResult
$Res call({
 UserDto user,@JsonKey(name: 'card_count') int cardCount, String? phone,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'member_since') String? memberSince
});


$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$ProfileDtoCopyWithImpl<$Res>
    implements $ProfileDtoCopyWith<$Res> {
  _$ProfileDtoCopyWithImpl(this._self, this._then);

  final ProfileDto _self;
  final $Res Function(ProfileDto) _then;

/// Create a copy of ProfileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? cardCount = null,Object? phone = freezed,Object? avatarUrl = freezed,Object? memberSince = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,cardCount: null == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,memberSince: freezed == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileDto].
extension ProfileDtoPatterns on ProfileDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileDto value)  $default,){
final _that = this;
switch (_that) {
case _ProfileDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileDto value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserDto user, @JsonKey(name: 'card_count')  int cardCount,  String? phone, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'member_since')  String? memberSince)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileDto() when $default != null:
return $default(_that.user,_that.cardCount,_that.phone,_that.avatarUrl,_that.memberSince);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserDto user, @JsonKey(name: 'card_count')  int cardCount,  String? phone, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'member_since')  String? memberSince)  $default,) {final _that = this;
switch (_that) {
case _ProfileDto():
return $default(_that.user,_that.cardCount,_that.phone,_that.avatarUrl,_that.memberSince);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserDto user, @JsonKey(name: 'card_count')  int cardCount,  String? phone, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'member_since')  String? memberSince)?  $default,) {final _that = this;
switch (_that) {
case _ProfileDto() when $default != null:
return $default(_that.user,_that.cardCount,_that.phone,_that.avatarUrl,_that.memberSince);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileDto implements ProfileDto {
  const _ProfileDto({required this.user, @JsonKey(name: 'card_count') required this.cardCount, this.phone, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'member_since') this.memberSince});
  factory _ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

@override final  UserDto user;
@override@JsonKey(name: 'card_count') final  int cardCount;
@override final  String? phone;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'member_since') final  String? memberSince;

/// Create a copy of ProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDtoCopyWith<_ProfileDto> get copyWith => __$ProfileDtoCopyWithImpl<_ProfileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileDto&&(identical(other.user, user) || other.user == user)&&(identical(other.cardCount, cardCount) || other.cardCount == cardCount)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,cardCount,phone,avatarUrl,memberSince);

@override
String toString() {
  return 'ProfileDto(user: $user, cardCount: $cardCount, phone: $phone, avatarUrl: $avatarUrl, memberSince: $memberSince)';
}


}

/// @nodoc
abstract mixin class _$ProfileDtoCopyWith<$Res> implements $ProfileDtoCopyWith<$Res> {
  factory _$ProfileDtoCopyWith(_ProfileDto value, $Res Function(_ProfileDto) _then) = __$ProfileDtoCopyWithImpl;
@override @useResult
$Res call({
 UserDto user,@JsonKey(name: 'card_count') int cardCount, String? phone,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'member_since') String? memberSince
});


@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$ProfileDtoCopyWithImpl<$Res>
    implements _$ProfileDtoCopyWith<$Res> {
  __$ProfileDtoCopyWithImpl(this._self, this._then);

  final _ProfileDto _self;
  final $Res Function(_ProfileDto) _then;

/// Create a copy of ProfileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? cardCount = null,Object? phone = freezed,Object? avatarUrl = freezed,Object? memberSince = freezed,}) {
  return _then(_ProfileDto(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,cardCount: null == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,memberSince: freezed == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ProfileDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$AccountDto {

 String get id; String get name;@JsonKey(name: 'account_number') String get accountNumber; String get iban; double get balance; String get currency; String get type; int get color;
/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<AccountDto> get copyWith => _$AccountDtoCopyWithImpl<AccountDto>(this as AccountDto, _$identity);

  /// Serializes this AccountDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,accountNumber,iban,balance,currency,type,color);

@override
String toString() {
  return 'AccountDto(id: $id, name: $name, accountNumber: $accountNumber, iban: $iban, balance: $balance, currency: $currency, type: $type, color: $color)';
}


}

/// @nodoc
abstract mixin class $AccountDtoCopyWith<$Res>  {
  factory $AccountDtoCopyWith(AccountDto value, $Res Function(AccountDto) _then) = _$AccountDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'account_number') String accountNumber, String iban, double balance, String currency, String type, int color
});




}
/// @nodoc
class _$AccountDtoCopyWithImpl<$Res>
    implements $AccountDtoCopyWith<$Res> {
  _$AccountDtoCopyWithImpl(this._self, this._then);

  final AccountDto _self;
  final $Res Function(AccountDto) _then;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? accountNumber = null,Object? iban = null,Object? balance = null,Object? currency = null,Object? type = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,iban: null == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountDto].
extension AccountDtoPatterns on AccountDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountDto value)  $default,){
final _that = this;
switch (_that) {
case _AccountDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountDto value)?  $default,){
final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'account_number')  String accountNumber,  String iban,  double balance,  String currency,  String type,  int color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that.id,_that.name,_that.accountNumber,_that.iban,_that.balance,_that.currency,_that.type,_that.color);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'account_number')  String accountNumber,  String iban,  double balance,  String currency,  String type,  int color)  $default,) {final _that = this;
switch (_that) {
case _AccountDto():
return $default(_that.id,_that.name,_that.accountNumber,_that.iban,_that.balance,_that.currency,_that.type,_that.color);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'account_number')  String accountNumber,  String iban,  double balance,  String currency,  String type,  int color)?  $default,) {final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that.id,_that.name,_that.accountNumber,_that.iban,_that.balance,_that.currency,_that.type,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountDto implements AccountDto {
  const _AccountDto({required this.id, required this.name, @JsonKey(name: 'account_number') required this.accountNumber, required this.iban, required this.balance, required this.currency, required this.type, required this.color});
  factory _AccountDto.fromJson(Map<String, dynamic> json) => _$AccountDtoFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'account_number') final  String accountNumber;
@override final  String iban;
@override final  double balance;
@override final  String currency;
@override final  String type;
@override final  int color;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountDtoCopyWith<_AccountDto> get copyWith => __$AccountDtoCopyWithImpl<_AccountDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,accountNumber,iban,balance,currency,type,color);

@override
String toString() {
  return 'AccountDto(id: $id, name: $name, accountNumber: $accountNumber, iban: $iban, balance: $balance, currency: $currency, type: $type, color: $color)';
}


}

/// @nodoc
abstract mixin class _$AccountDtoCopyWith<$Res> implements $AccountDtoCopyWith<$Res> {
  factory _$AccountDtoCopyWith(_AccountDto value, $Res Function(_AccountDto) _then) = __$AccountDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'account_number') String accountNumber, String iban, double balance, String currency, String type, int color
});




}
/// @nodoc
class __$AccountDtoCopyWithImpl<$Res>
    implements _$AccountDtoCopyWith<$Res> {
  __$AccountDtoCopyWithImpl(this._self, this._then);

  final _AccountDto _self;
  final $Res Function(_AccountDto) _then;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? accountNumber = null,Object? iban = null,Object? balance = null,Object? currency = null,Object? type = null,Object? color = null,}) {
  return _then(_AccountDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,iban: null == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TransactionDto {

 String get id; String get title; String get subtitle; double get amount; String get currency; String get type; String get status; String get date; String get category; String get icon; String get reference;@JsonKey(name: 'account_id') String get accountId;
/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionDtoCopyWith<TransactionDto> get copyWith => _$TransactionDtoCopyWithImpl<TransactionDto>(this as TransactionDto, _$identity);

  /// Serializes this TransactionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,amount,currency,type,status,date,category,icon,reference,accountId);

@override
String toString() {
  return 'TransactionDto(id: $id, title: $title, subtitle: $subtitle, amount: $amount, currency: $currency, type: $type, status: $status, date: $date, category: $category, icon: $icon, reference: $reference, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class $TransactionDtoCopyWith<$Res>  {
  factory $TransactionDtoCopyWith(TransactionDto value, $Res Function(TransactionDto) _then) = _$TransactionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String subtitle, double amount, String currency, String type, String status, String date, String category, String icon, String reference,@JsonKey(name: 'account_id') String accountId
});




}
/// @nodoc
class _$TransactionDtoCopyWithImpl<$Res>
    implements $TransactionDtoCopyWith<$Res> {
  _$TransactionDtoCopyWithImpl(this._self, this._then);

  final TransactionDto _self;
  final $Res Function(TransactionDto) _then;

/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? amount = null,Object? currency = null,Object? type = null,Object? status = null,Object? date = null,Object? category = null,Object? icon = null,Object? reference = null,Object? accountId = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionDto].
extension TransactionDtoPatterns on TransactionDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionDto value)  $default,){
final _that = this;
switch (_that) {
case _TransactionDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  double amount,  String currency,  String type,  String status,  String date,  String category,  String icon,  String reference, @JsonKey(name: 'account_id')  String accountId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.amount,_that.currency,_that.type,_that.status,_that.date,_that.category,_that.icon,_that.reference,_that.accountId);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String subtitle,  double amount,  String currency,  String type,  String status,  String date,  String category,  String icon,  String reference, @JsonKey(name: 'account_id')  String accountId)  $default,) {final _that = this;
switch (_that) {
case _TransactionDto():
return $default(_that.id,_that.title,_that.subtitle,_that.amount,_that.currency,_that.type,_that.status,_that.date,_that.category,_that.icon,_that.reference,_that.accountId);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String subtitle,  double amount,  String currency,  String type,  String status,  String date,  String category,  String icon,  String reference, @JsonKey(name: 'account_id')  String accountId)?  $default,) {final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
return $default(_that.id,_that.title,_that.subtitle,_that.amount,_that.currency,_that.type,_that.status,_that.date,_that.category,_that.icon,_that.reference,_that.accountId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionDto implements TransactionDto {
  const _TransactionDto({required this.id, required this.title, required this.subtitle, required this.amount, required this.currency, required this.type, required this.status, required this.date, required this.category, required this.icon, required this.reference, @JsonKey(name: 'account_id') required this.accountId});
  factory _TransactionDto.fromJson(Map<String, dynamic> json) => _$TransactionDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String subtitle;
@override final  double amount;
@override final  String currency;
@override final  String type;
@override final  String status;
@override final  String date;
@override final  String category;
@override final  String icon;
@override final  String reference;
@override@JsonKey(name: 'account_id') final  String accountId;

/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionDtoCopyWith<_TransactionDto> get copyWith => __$TransactionDtoCopyWithImpl<_TransactionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.subtitle, subtitle) || other.subtitle == subtitle)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.reference, reference) || other.reference == reference)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,subtitle,amount,currency,type,status,date,category,icon,reference,accountId);

@override
String toString() {
  return 'TransactionDto(id: $id, title: $title, subtitle: $subtitle, amount: $amount, currency: $currency, type: $type, status: $status, date: $date, category: $category, icon: $icon, reference: $reference, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class _$TransactionDtoCopyWith<$Res> implements $TransactionDtoCopyWith<$Res> {
  factory _$TransactionDtoCopyWith(_TransactionDto value, $Res Function(_TransactionDto) _then) = __$TransactionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String subtitle, double amount, String currency, String type, String status, String date, String category, String icon, String reference,@JsonKey(name: 'account_id') String accountId
});




}
/// @nodoc
class __$TransactionDtoCopyWithImpl<$Res>
    implements _$TransactionDtoCopyWith<$Res> {
  __$TransactionDtoCopyWithImpl(this._self, this._then);

  final _TransactionDto _self;
  final $Res Function(_TransactionDto) _then;

/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? subtitle = null,Object? amount = null,Object? currency = null,Object? type = null,Object? status = null,Object? date = null,Object? category = null,Object? icon = null,Object? reference = null,Object? accountId = null,}) {
  return _then(_TransactionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,subtitle: null == subtitle ? _self.subtitle : subtitle // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$BeneficiaryDto {

 String get id; String get name;@JsonKey(name: 'bank_name') String get bankName;@JsonKey(name: 'account_number') String get accountNumber;@JsonKey(name: 'avatar_initials') String get avatarInitials; int get color;
/// Create a copy of BeneficiaryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BeneficiaryDtoCopyWith<BeneficiaryDto> get copyWith => _$BeneficiaryDtoCopyWithImpl<BeneficiaryDto>(this as BeneficiaryDto, _$identity);

  /// Serializes this BeneficiaryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BeneficiaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.avatarInitials, avatarInitials) || other.avatarInitials == avatarInitials)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,bankName,accountNumber,avatarInitials,color);

@override
String toString() {
  return 'BeneficiaryDto(id: $id, name: $name, bankName: $bankName, accountNumber: $accountNumber, avatarInitials: $avatarInitials, color: $color)';
}


}

/// @nodoc
abstract mixin class $BeneficiaryDtoCopyWith<$Res>  {
  factory $BeneficiaryDtoCopyWith(BeneficiaryDto value, $Res Function(BeneficiaryDto) _then) = _$BeneficiaryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name,@JsonKey(name: 'bank_name') String bankName,@JsonKey(name: 'account_number') String accountNumber,@JsonKey(name: 'avatar_initials') String avatarInitials, int color
});




}
/// @nodoc
class _$BeneficiaryDtoCopyWithImpl<$Res>
    implements $BeneficiaryDtoCopyWith<$Res> {
  _$BeneficiaryDtoCopyWithImpl(this._self, this._then);

  final BeneficiaryDto _self;
  final $Res Function(BeneficiaryDto) _then;

/// Create a copy of BeneficiaryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? bankName = null,Object? accountNumber = null,Object? avatarInitials = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,avatarInitials: null == avatarInitials ? _self.avatarInitials : avatarInitials // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BeneficiaryDto].
extension BeneficiaryDtoPatterns on BeneficiaryDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BeneficiaryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BeneficiaryDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BeneficiaryDto value)  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BeneficiaryDto value)?  $default,){
final _that = this;
switch (_that) {
case _BeneficiaryDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'bank_name')  String bankName, @JsonKey(name: 'account_number')  String accountNumber, @JsonKey(name: 'avatar_initials')  String avatarInitials,  int color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BeneficiaryDto() when $default != null:
return $default(_that.id,_that.name,_that.bankName,_that.accountNumber,_that.avatarInitials,_that.color);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name, @JsonKey(name: 'bank_name')  String bankName, @JsonKey(name: 'account_number')  String accountNumber, @JsonKey(name: 'avatar_initials')  String avatarInitials,  int color)  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryDto():
return $default(_that.id,_that.name,_that.bankName,_that.accountNumber,_that.avatarInitials,_that.color);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name, @JsonKey(name: 'bank_name')  String bankName, @JsonKey(name: 'account_number')  String accountNumber, @JsonKey(name: 'avatar_initials')  String avatarInitials,  int color)?  $default,) {final _that = this;
switch (_that) {
case _BeneficiaryDto() when $default != null:
return $default(_that.id,_that.name,_that.bankName,_that.accountNumber,_that.avatarInitials,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BeneficiaryDto implements BeneficiaryDto {
  const _BeneficiaryDto({required this.id, required this.name, @JsonKey(name: 'bank_name') required this.bankName, @JsonKey(name: 'account_number') required this.accountNumber, @JsonKey(name: 'avatar_initials') required this.avatarInitials, required this.color});
  factory _BeneficiaryDto.fromJson(Map<String, dynamic> json) => _$BeneficiaryDtoFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey(name: 'bank_name') final  String bankName;
@override@JsonKey(name: 'account_number') final  String accountNumber;
@override@JsonKey(name: 'avatar_initials') final  String avatarInitials;
@override final  int color;

/// Create a copy of BeneficiaryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BeneficiaryDtoCopyWith<_BeneficiaryDto> get copyWith => __$BeneficiaryDtoCopyWithImpl<_BeneficiaryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BeneficiaryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BeneficiaryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.bankName, bankName) || other.bankName == bankName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.avatarInitials, avatarInitials) || other.avatarInitials == avatarInitials)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,bankName,accountNumber,avatarInitials,color);

@override
String toString() {
  return 'BeneficiaryDto(id: $id, name: $name, bankName: $bankName, accountNumber: $accountNumber, avatarInitials: $avatarInitials, color: $color)';
}


}

/// @nodoc
abstract mixin class _$BeneficiaryDtoCopyWith<$Res> implements $BeneficiaryDtoCopyWith<$Res> {
  factory _$BeneficiaryDtoCopyWith(_BeneficiaryDto value, $Res Function(_BeneficiaryDto) _then) = __$BeneficiaryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name,@JsonKey(name: 'bank_name') String bankName,@JsonKey(name: 'account_number') String accountNumber,@JsonKey(name: 'avatar_initials') String avatarInitials, int color
});




}
/// @nodoc
class __$BeneficiaryDtoCopyWithImpl<$Res>
    implements _$BeneficiaryDtoCopyWith<$Res> {
  __$BeneficiaryDtoCopyWithImpl(this._self, this._then);

  final _BeneficiaryDto _self;
  final $Res Function(_BeneficiaryDto) _then;

/// Create a copy of BeneficiaryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? bankName = null,Object? accountNumber = null,Object? avatarInitials = null,Object? color = null,}) {
  return _then(_BeneficiaryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,bankName: null == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,avatarInitials: null == avatarInitials ? _self.avatarInitials : avatarInitials // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TransferRequestDto {

@JsonKey(name: 'from_account_id') String get fromAccountId;@JsonKey(name: 'beneficiary_id') String get beneficiaryId; double get amount; String? get note;
/// Create a copy of TransferRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransferRequestDtoCopyWith<TransferRequestDto> get copyWith => _$TransferRequestDtoCopyWithImpl<TransferRequestDto>(this as TransferRequestDto, _$identity);

  /// Serializes this TransferRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransferRequestDto&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.beneficiaryId, beneficiaryId) || other.beneficiaryId == beneficiaryId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromAccountId,beneficiaryId,amount,note);

@override
String toString() {
  return 'TransferRequestDto(fromAccountId: $fromAccountId, beneficiaryId: $beneficiaryId, amount: $amount, note: $note)';
}


}

/// @nodoc
abstract mixin class $TransferRequestDtoCopyWith<$Res>  {
  factory $TransferRequestDtoCopyWith(TransferRequestDto value, $Res Function(TransferRequestDto) _then) = _$TransferRequestDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'from_account_id') String fromAccountId,@JsonKey(name: 'beneficiary_id') String beneficiaryId, double amount, String? note
});




}
/// @nodoc
class _$TransferRequestDtoCopyWithImpl<$Res>
    implements $TransferRequestDtoCopyWith<$Res> {
  _$TransferRequestDtoCopyWithImpl(this._self, this._then);

  final TransferRequestDto _self;
  final $Res Function(TransferRequestDto) _then;

/// Create a copy of TransferRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fromAccountId = null,Object? beneficiaryId = null,Object? amount = null,Object? note = freezed,}) {
  return _then(_self.copyWith(
fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,beneficiaryId: null == beneficiaryId ? _self.beneficiaryId : beneficiaryId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransferRequestDto].
extension TransferRequestDtoPatterns on TransferRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransferRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransferRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransferRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _TransferRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransferRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransferRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_account_id')  String fromAccountId, @JsonKey(name: 'beneficiary_id')  String beneficiaryId,  double amount,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransferRequestDto() when $default != null:
return $default(_that.fromAccountId,_that.beneficiaryId,_that.amount,_that.note);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'from_account_id')  String fromAccountId, @JsonKey(name: 'beneficiary_id')  String beneficiaryId,  double amount,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TransferRequestDto():
return $default(_that.fromAccountId,_that.beneficiaryId,_that.amount,_that.note);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'from_account_id')  String fromAccountId, @JsonKey(name: 'beneficiary_id')  String beneficiaryId,  double amount,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TransferRequestDto() when $default != null:
return $default(_that.fromAccountId,_that.beneficiaryId,_that.amount,_that.note);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransferRequestDto implements TransferRequestDto {
  const _TransferRequestDto({@JsonKey(name: 'from_account_id') required this.fromAccountId, @JsonKey(name: 'beneficiary_id') required this.beneficiaryId, required this.amount, this.note});
  factory _TransferRequestDto.fromJson(Map<String, dynamic> json) => _$TransferRequestDtoFromJson(json);

@override@JsonKey(name: 'from_account_id') final  String fromAccountId;
@override@JsonKey(name: 'beneficiary_id') final  String beneficiaryId;
@override final  double amount;
@override final  String? note;

/// Create a copy of TransferRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransferRequestDtoCopyWith<_TransferRequestDto> get copyWith => __$TransferRequestDtoCopyWithImpl<_TransferRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransferRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransferRequestDto&&(identical(other.fromAccountId, fromAccountId) || other.fromAccountId == fromAccountId)&&(identical(other.beneficiaryId, beneficiaryId) || other.beneficiaryId == beneficiaryId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.note, note) || other.note == note));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fromAccountId,beneficiaryId,amount,note);

@override
String toString() {
  return 'TransferRequestDto(fromAccountId: $fromAccountId, beneficiaryId: $beneficiaryId, amount: $amount, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TransferRequestDtoCopyWith<$Res> implements $TransferRequestDtoCopyWith<$Res> {
  factory _$TransferRequestDtoCopyWith(_TransferRequestDto value, $Res Function(_TransferRequestDto) _then) = __$TransferRequestDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'from_account_id') String fromAccountId,@JsonKey(name: 'beneficiary_id') String beneficiaryId, double amount, String? note
});




}
/// @nodoc
class __$TransferRequestDtoCopyWithImpl<$Res>
    implements _$TransferRequestDtoCopyWith<$Res> {
  __$TransferRequestDtoCopyWithImpl(this._self, this._then);

  final _TransferRequestDto _self;
  final $Res Function(_TransferRequestDto) _then;

/// Create a copy of TransferRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fromAccountId = null,Object? beneficiaryId = null,Object? amount = null,Object? note = freezed,}) {
  return _then(_TransferRequestDto(
fromAccountId: null == fromAccountId ? _self.fromAccountId : fromAccountId // ignore: cast_nullable_to_non_nullable
as String,beneficiaryId: null == beneficiaryId ? _self.beneficiaryId : beneficiaryId // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$CardDto {

 String get id;@JsonKey(name: 'card_number') String get cardNumber;@JsonKey(name: 'holder_name') String get holderName;@JsonKey(name: 'expiry_date') String get expiryDate; String get cvv; String get type; String get status; double get balance; String get currency;@JsonKey(name: 'gradient_colors') List<int> get gradientColors;
/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardDtoCopyWith<CardDto> get copyWith => _$CardDtoCopyWithImpl<CardDto>(this as CardDto, _$identity);

  /// Serializes this CardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardDto&&(identical(other.id, id) || other.id == id)&&(identical(other.cardNumber, cardNumber) || other.cardNumber == cardNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.cvv, cvv) || other.cvv == cvv)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other.gradientColors, gradientColors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardNumber,holderName,expiryDate,cvv,type,status,balance,currency,const DeepCollectionEquality().hash(gradientColors));

@override
String toString() {
  return 'CardDto(id: $id, cardNumber: $cardNumber, holderName: $holderName, expiryDate: $expiryDate, cvv: $cvv, type: $type, status: $status, balance: $balance, currency: $currency, gradientColors: $gradientColors)';
}


}

/// @nodoc
abstract mixin class $CardDtoCopyWith<$Res>  {
  factory $CardDtoCopyWith(CardDto value, $Res Function(CardDto) _then) = _$CardDtoCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'card_number') String cardNumber,@JsonKey(name: 'holder_name') String holderName,@JsonKey(name: 'expiry_date') String expiryDate, String cvv, String type, String status, double balance, String currency,@JsonKey(name: 'gradient_colors') List<int> gradientColors
});




}
/// @nodoc
class _$CardDtoCopyWithImpl<$Res>
    implements $CardDtoCopyWith<$Res> {
  _$CardDtoCopyWithImpl(this._self, this._then);

  final CardDto _self;
  final $Res Function(CardDto) _then;

/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? cardNumber = null,Object? holderName = null,Object? expiryDate = null,Object? cvv = null,Object? type = null,Object? status = null,Object? balance = null,Object? currency = null,Object? gradientColors = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cardNumber: null == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,cvv: null == cvv ? _self.cvv : cvv // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,gradientColors: null == gradientColors ? _self.gradientColors : gradientColors // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [CardDto].
extension CardDtoPatterns on CardDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardDto value)  $default,){
final _that = this;
switch (_that) {
case _CardDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardDto value)?  $default,){
final _that = this;
switch (_that) {
case _CardDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'card_number')  String cardNumber, @JsonKey(name: 'holder_name')  String holderName, @JsonKey(name: 'expiry_date')  String expiryDate,  String cvv,  String type,  String status,  double balance,  String currency, @JsonKey(name: 'gradient_colors')  List<int> gradientColors)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardDto() when $default != null:
return $default(_that.id,_that.cardNumber,_that.holderName,_that.expiryDate,_that.cvv,_that.type,_that.status,_that.balance,_that.currency,_that.gradientColors);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'card_number')  String cardNumber, @JsonKey(name: 'holder_name')  String holderName, @JsonKey(name: 'expiry_date')  String expiryDate,  String cvv,  String type,  String status,  double balance,  String currency, @JsonKey(name: 'gradient_colors')  List<int> gradientColors)  $default,) {final _that = this;
switch (_that) {
case _CardDto():
return $default(_that.id,_that.cardNumber,_that.holderName,_that.expiryDate,_that.cvv,_that.type,_that.status,_that.balance,_that.currency,_that.gradientColors);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'card_number')  String cardNumber, @JsonKey(name: 'holder_name')  String holderName, @JsonKey(name: 'expiry_date')  String expiryDate,  String cvv,  String type,  String status,  double balance,  String currency, @JsonKey(name: 'gradient_colors')  List<int> gradientColors)?  $default,) {final _that = this;
switch (_that) {
case _CardDto() when $default != null:
return $default(_that.id,_that.cardNumber,_that.holderName,_that.expiryDate,_that.cvv,_that.type,_that.status,_that.balance,_that.currency,_that.gradientColors);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardDto implements CardDto {
  const _CardDto({required this.id, @JsonKey(name: 'card_number') required this.cardNumber, @JsonKey(name: 'holder_name') required this.holderName, @JsonKey(name: 'expiry_date') required this.expiryDate, required this.cvv, required this.type, required this.status, required this.balance, required this.currency, @JsonKey(name: 'gradient_colors') required final  List<int> gradientColors}): _gradientColors = gradientColors;
  factory _CardDto.fromJson(Map<String, dynamic> json) => _$CardDtoFromJson(json);

@override final  String id;
@override@JsonKey(name: 'card_number') final  String cardNumber;
@override@JsonKey(name: 'holder_name') final  String holderName;
@override@JsonKey(name: 'expiry_date') final  String expiryDate;
@override final  String cvv;
@override final  String type;
@override final  String status;
@override final  double balance;
@override final  String currency;
 final  List<int> _gradientColors;
@override@JsonKey(name: 'gradient_colors') List<int> get gradientColors {
  if (_gradientColors is EqualUnmodifiableListView) return _gradientColors;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_gradientColors);
}


/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardDtoCopyWith<_CardDto> get copyWith => __$CardDtoCopyWithImpl<_CardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardDto&&(identical(other.id, id) || other.id == id)&&(identical(other.cardNumber, cardNumber) || other.cardNumber == cardNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName)&&(identical(other.expiryDate, expiryDate) || other.expiryDate == expiryDate)&&(identical(other.cvv, cvv) || other.cvv == cvv)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.currency, currency) || other.currency == currency)&&const DeepCollectionEquality().equals(other._gradientColors, _gradientColors));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardNumber,holderName,expiryDate,cvv,type,status,balance,currency,const DeepCollectionEquality().hash(_gradientColors));

@override
String toString() {
  return 'CardDto(id: $id, cardNumber: $cardNumber, holderName: $holderName, expiryDate: $expiryDate, cvv: $cvv, type: $type, status: $status, balance: $balance, currency: $currency, gradientColors: $gradientColors)';
}


}

/// @nodoc
abstract mixin class _$CardDtoCopyWith<$Res> implements $CardDtoCopyWith<$Res> {
  factory _$CardDtoCopyWith(_CardDto value, $Res Function(_CardDto) _then) = __$CardDtoCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'card_number') String cardNumber,@JsonKey(name: 'holder_name') String holderName,@JsonKey(name: 'expiry_date') String expiryDate, String cvv, String type, String status, double balance, String currency,@JsonKey(name: 'gradient_colors') List<int> gradientColors
});




}
/// @nodoc
class __$CardDtoCopyWithImpl<$Res>
    implements _$CardDtoCopyWith<$Res> {
  __$CardDtoCopyWithImpl(this._self, this._then);

  final _CardDto _self;
  final $Res Function(_CardDto) _then;

/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? cardNumber = null,Object? holderName = null,Object? expiryDate = null,Object? cvv = null,Object? type = null,Object? status = null,Object? balance = null,Object? currency = null,Object? gradientColors = null,}) {
  return _then(_CardDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,cardNumber: null == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,expiryDate: null == expiryDate ? _self.expiryDate : expiryDate // ignore: cast_nullable_to_non_nullable
as String,cvv: null == cvv ? _self.cvv : cvv // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,gradientColors: null == gradientColors ? _self._gradientColors : gradientColors // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}


/// @nodoc
mixin _$NotificationDto {

 String get id; String get title; String get body; String get time;@JsonKey(name: 'is_read') bool get isRead; String get icon; int get color;
/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationDtoCopyWith<NotificationDto> get copyWith => _$NotificationDtoCopyWithImpl<NotificationDto>(this as NotificationDto, _$identity);

  /// Serializes this NotificationDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.time, time) || other.time == time)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,time,isRead,icon,color);

@override
String toString() {
  return 'NotificationDto(id: $id, title: $title, body: $body, time: $time, isRead: $isRead, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class $NotificationDtoCopyWith<$Res>  {
  factory $NotificationDtoCopyWith(NotificationDto value, $Res Function(NotificationDto) _then) = _$NotificationDtoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String body, String time,@JsonKey(name: 'is_read') bool isRead, String icon, int color
});




}
/// @nodoc
class _$NotificationDtoCopyWithImpl<$Res>
    implements $NotificationDtoCopyWith<$Res> {
  _$NotificationDtoCopyWithImpl(this._self, this._then);

  final NotificationDto _self;
  final $Res Function(NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? time = null,Object? isRead = null,Object? icon = null,Object? color = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationDto].
extension NotificationDtoPatterns on NotificationDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationDto value)  $default,){
final _that = this;
switch (_that) {
case _NotificationDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationDto value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String body,  String time, @JsonKey(name: 'is_read')  bool isRead,  String icon,  int color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.time,_that.isRead,_that.icon,_that.color);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String body,  String time, @JsonKey(name: 'is_read')  bool isRead,  String icon,  int color)  $default,) {final _that = this;
switch (_that) {
case _NotificationDto():
return $default(_that.id,_that.title,_that.body,_that.time,_that.isRead,_that.icon,_that.color);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String body,  String time, @JsonKey(name: 'is_read')  bool isRead,  String icon,  int color)?  $default,) {final _that = this;
switch (_that) {
case _NotificationDto() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.time,_that.isRead,_that.icon,_that.color);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationDto implements NotificationDto {
  const _NotificationDto({required this.id, required this.title, required this.body, required this.time, @JsonKey(name: 'is_read') required this.isRead, required this.icon, required this.color});
  factory _NotificationDto.fromJson(Map<String, dynamic> json) => _$NotificationDtoFromJson(json);

@override final  String id;
@override final  String title;
@override final  String body;
@override final  String time;
@override@JsonKey(name: 'is_read') final  bool isRead;
@override final  String icon;
@override final  int color;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationDtoCopyWith<_NotificationDto> get copyWith => __$NotificationDtoCopyWithImpl<_NotificationDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationDto&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.time, time) || other.time == time)&&(identical(other.isRead, isRead) || other.isRead == isRead)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,time,isRead,icon,color);

@override
String toString() {
  return 'NotificationDto(id: $id, title: $title, body: $body, time: $time, isRead: $isRead, icon: $icon, color: $color)';
}


}

/// @nodoc
abstract mixin class _$NotificationDtoCopyWith<$Res> implements $NotificationDtoCopyWith<$Res> {
  factory _$NotificationDtoCopyWith(_NotificationDto value, $Res Function(_NotificationDto) _then) = __$NotificationDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String body, String time,@JsonKey(name: 'is_read') bool isRead, String icon, int color
});




}
/// @nodoc
class __$NotificationDtoCopyWithImpl<$Res>
    implements _$NotificationDtoCopyWith<$Res> {
  __$NotificationDtoCopyWithImpl(this._self, this._then);

  final _NotificationDto _self;
  final $Res Function(_NotificationDto) _then;

/// Create a copy of NotificationDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? time = null,Object? isRead = null,Object? icon = null,Object? color = null,}) {
  return _then(_NotificationDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,isRead: null == isRead ? _self.isRead : isRead // ignore: cast_nullable_to_non_nullable
as bool,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DashboardDto {

 UserDto get user;@JsonKey(name: 'total_balance') double get totalBalance; List<AccountDto> get accounts;@JsonKey(name: 'recent_transactions') List<TransactionDto> get recentTransactions;@JsonKey(name: 'weekly_spending') List<double> get weeklySpending;@JsonKey(name: 'weekly_labels') List<String> get weeklyLabels;
/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardDtoCopyWith<DashboardDto> get copyWith => _$DashboardDtoCopyWithImpl<DashboardDto>(this as DashboardDto, _$identity);

  /// Serializes this DashboardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardDto&&(identical(other.user, user) || other.user == user)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.recentTransactions, recentTransactions)&&const DeepCollectionEquality().equals(other.weeklySpending, weeklySpending)&&const DeepCollectionEquality().equals(other.weeklyLabels, weeklyLabels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,totalBalance,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(recentTransactions),const DeepCollectionEquality().hash(weeklySpending),const DeepCollectionEquality().hash(weeklyLabels));

@override
String toString() {
  return 'DashboardDto(user: $user, totalBalance: $totalBalance, accounts: $accounts, recentTransactions: $recentTransactions, weeklySpending: $weeklySpending, weeklyLabels: $weeklyLabels)';
}


}

/// @nodoc
abstract mixin class $DashboardDtoCopyWith<$Res>  {
  factory $DashboardDtoCopyWith(DashboardDto value, $Res Function(DashboardDto) _then) = _$DashboardDtoCopyWithImpl;
@useResult
$Res call({
 UserDto user,@JsonKey(name: 'total_balance') double totalBalance, List<AccountDto> accounts,@JsonKey(name: 'recent_transactions') List<TransactionDto> recentTransactions,@JsonKey(name: 'weekly_spending') List<double> weeklySpending,@JsonKey(name: 'weekly_labels') List<String> weeklyLabels
});


$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$DashboardDtoCopyWithImpl<$Res>
    implements $DashboardDtoCopyWith<$Res> {
  _$DashboardDtoCopyWithImpl(this._self, this._then);

  final DashboardDto _self;
  final $Res Function(DashboardDto) _then;

/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? totalBalance = null,Object? accounts = null,Object? recentTransactions = null,Object? weeklySpending = null,Object? weeklyLabels = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountDto>,recentTransactions: null == recentTransactions ? _self.recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionDto>,weeklySpending: null == weeklySpending ? _self.weeklySpending : weeklySpending // ignore: cast_nullable_to_non_nullable
as List<double>,weeklyLabels: null == weeklyLabels ? _self.weeklyLabels : weeklyLabels // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}
/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [DashboardDto].
extension DashboardDtoPatterns on DashboardDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardDto value)  $default,){
final _that = this;
switch (_that) {
case _DashboardDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardDto value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserDto user, @JsonKey(name: 'total_balance')  double totalBalance,  List<AccountDto> accounts, @JsonKey(name: 'recent_transactions')  List<TransactionDto> recentTransactions, @JsonKey(name: 'weekly_spending')  List<double> weeklySpending, @JsonKey(name: 'weekly_labels')  List<String> weeklyLabels)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
return $default(_that.user,_that.totalBalance,_that.accounts,_that.recentTransactions,_that.weeklySpending,_that.weeklyLabels);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserDto user, @JsonKey(name: 'total_balance')  double totalBalance,  List<AccountDto> accounts, @JsonKey(name: 'recent_transactions')  List<TransactionDto> recentTransactions, @JsonKey(name: 'weekly_spending')  List<double> weeklySpending, @JsonKey(name: 'weekly_labels')  List<String> weeklyLabels)  $default,) {final _that = this;
switch (_that) {
case _DashboardDto():
return $default(_that.user,_that.totalBalance,_that.accounts,_that.recentTransactions,_that.weeklySpending,_that.weeklyLabels);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserDto user, @JsonKey(name: 'total_balance')  double totalBalance,  List<AccountDto> accounts, @JsonKey(name: 'recent_transactions')  List<TransactionDto> recentTransactions, @JsonKey(name: 'weekly_spending')  List<double> weeklySpending, @JsonKey(name: 'weekly_labels')  List<String> weeklyLabels)?  $default,) {final _that = this;
switch (_that) {
case _DashboardDto() when $default != null:
return $default(_that.user,_that.totalBalance,_that.accounts,_that.recentTransactions,_that.weeklySpending,_that.weeklyLabels);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DashboardDto implements DashboardDto {
  const _DashboardDto({required this.user, @JsonKey(name: 'total_balance') required this.totalBalance, required final  List<AccountDto> accounts, @JsonKey(name: 'recent_transactions') required final  List<TransactionDto> recentTransactions, @JsonKey(name: 'weekly_spending') required final  List<double> weeklySpending, @JsonKey(name: 'weekly_labels') required final  List<String> weeklyLabels}): _accounts = accounts,_recentTransactions = recentTransactions,_weeklySpending = weeklySpending,_weeklyLabels = weeklyLabels;
  factory _DashboardDto.fromJson(Map<String, dynamic> json) => _$DashboardDtoFromJson(json);

@override final  UserDto user;
@override@JsonKey(name: 'total_balance') final  double totalBalance;
 final  List<AccountDto> _accounts;
@override List<AccountDto> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<TransactionDto> _recentTransactions;
@override@JsonKey(name: 'recent_transactions') List<TransactionDto> get recentTransactions {
  if (_recentTransactions is EqualUnmodifiableListView) return _recentTransactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentTransactions);
}

 final  List<double> _weeklySpending;
@override@JsonKey(name: 'weekly_spending') List<double> get weeklySpending {
  if (_weeklySpending is EqualUnmodifiableListView) return _weeklySpending;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklySpending);
}

 final  List<String> _weeklyLabels;
@override@JsonKey(name: 'weekly_labels') List<String> get weeklyLabels {
  if (_weeklyLabels is EqualUnmodifiableListView) return _weeklyLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyLabels);
}


/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardDtoCopyWith<_DashboardDto> get copyWith => __$DashboardDtoCopyWithImpl<_DashboardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardDto&&(identical(other.user, user) || other.user == user)&&(identical(other.totalBalance, totalBalance) || other.totalBalance == totalBalance)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._recentTransactions, _recentTransactions)&&const DeepCollectionEquality().equals(other._weeklySpending, _weeklySpending)&&const DeepCollectionEquality().equals(other._weeklyLabels, _weeklyLabels));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,totalBalance,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_recentTransactions),const DeepCollectionEquality().hash(_weeklySpending),const DeepCollectionEquality().hash(_weeklyLabels));

@override
String toString() {
  return 'DashboardDto(user: $user, totalBalance: $totalBalance, accounts: $accounts, recentTransactions: $recentTransactions, weeklySpending: $weeklySpending, weeklyLabels: $weeklyLabels)';
}


}

/// @nodoc
abstract mixin class _$DashboardDtoCopyWith<$Res> implements $DashboardDtoCopyWith<$Res> {
  factory _$DashboardDtoCopyWith(_DashboardDto value, $Res Function(_DashboardDto) _then) = __$DashboardDtoCopyWithImpl;
@override @useResult
$Res call({
 UserDto user,@JsonKey(name: 'total_balance') double totalBalance, List<AccountDto> accounts,@JsonKey(name: 'recent_transactions') List<TransactionDto> recentTransactions,@JsonKey(name: 'weekly_spending') List<double> weeklySpending,@JsonKey(name: 'weekly_labels') List<String> weeklyLabels
});


@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$DashboardDtoCopyWithImpl<$Res>
    implements _$DashboardDtoCopyWith<$Res> {
  __$DashboardDtoCopyWithImpl(this._self, this._then);

  final _DashboardDto _self;
  final $Res Function(_DashboardDto) _then;

/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? totalBalance = null,Object? accounts = null,Object? recentTransactions = null,Object? weeklySpending = null,Object? weeklyLabels = null,}) {
  return _then(_DashboardDto(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,totalBalance: null == totalBalance ? _self.totalBalance : totalBalance // ignore: cast_nullable_to_non_nullable
as double,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountDto>,recentTransactions: null == recentTransactions ? _self._recentTransactions : recentTransactions // ignore: cast_nullable_to_non_nullable
as List<TransactionDto>,weeklySpending: null == weeklySpending ? _self._weeklySpending : weeklySpending // ignore: cast_nullable_to_non_nullable
as List<double>,weeklyLabels: null == weeklyLabels ? _self._weeklyLabels : weeklyLabels // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

/// Create a copy of DashboardDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$AnalyticsDto {

@JsonKey(name: 'weekly_spending') List<double> get weeklySpending;@JsonKey(name: 'weekly_labels') List<String> get weeklyLabels;@JsonKey(name: 'total_income') double get totalIncome;@JsonKey(name: 'total_expense') double get totalExpense;
/// Create a copy of AnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyticsDtoCopyWith<AnalyticsDto> get copyWith => _$AnalyticsDtoCopyWithImpl<AnalyticsDto>(this as AnalyticsDto, _$identity);

  /// Serializes this AnalyticsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsDto&&const DeepCollectionEquality().equals(other.weeklySpending, weeklySpending)&&const DeepCollectionEquality().equals(other.weeklyLabels, weeklyLabels)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(weeklySpending),const DeepCollectionEquality().hash(weeklyLabels),totalIncome,totalExpense);

@override
String toString() {
  return 'AnalyticsDto(weeklySpending: $weeklySpending, weeklyLabels: $weeklyLabels, totalIncome: $totalIncome, totalExpense: $totalExpense)';
}


}

/// @nodoc
abstract mixin class $AnalyticsDtoCopyWith<$Res>  {
  factory $AnalyticsDtoCopyWith(AnalyticsDto value, $Res Function(AnalyticsDto) _then) = _$AnalyticsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'weekly_spending') List<double> weeklySpending,@JsonKey(name: 'weekly_labels') List<String> weeklyLabels,@JsonKey(name: 'total_income') double totalIncome,@JsonKey(name: 'total_expense') double totalExpense
});




}
/// @nodoc
class _$AnalyticsDtoCopyWithImpl<$Res>
    implements $AnalyticsDtoCopyWith<$Res> {
  _$AnalyticsDtoCopyWithImpl(this._self, this._then);

  final AnalyticsDto _self;
  final $Res Function(AnalyticsDto) _then;

/// Create a copy of AnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weeklySpending = null,Object? weeklyLabels = null,Object? totalIncome = null,Object? totalExpense = null,}) {
  return _then(_self.copyWith(
weeklySpending: null == weeklySpending ? _self.weeklySpending : weeklySpending // ignore: cast_nullable_to_non_nullable
as List<double>,weeklyLabels: null == weeklyLabels ? _self.weeklyLabels : weeklyLabels // ignore: cast_nullable_to_non_nullable
as List<String>,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [AnalyticsDto].
extension AnalyticsDtoPatterns on AnalyticsDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyticsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyticsDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyticsDto value)  $default,){
final _that = this;
switch (_that) {
case _AnalyticsDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyticsDto value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyticsDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'weekly_spending')  List<double> weeklySpending, @JsonKey(name: 'weekly_labels')  List<String> weeklyLabels, @JsonKey(name: 'total_income')  double totalIncome, @JsonKey(name: 'total_expense')  double totalExpense)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyticsDto() when $default != null:
return $default(_that.weeklySpending,_that.weeklyLabels,_that.totalIncome,_that.totalExpense);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'weekly_spending')  List<double> weeklySpending, @JsonKey(name: 'weekly_labels')  List<String> weeklyLabels, @JsonKey(name: 'total_income')  double totalIncome, @JsonKey(name: 'total_expense')  double totalExpense)  $default,) {final _that = this;
switch (_that) {
case _AnalyticsDto():
return $default(_that.weeklySpending,_that.weeklyLabels,_that.totalIncome,_that.totalExpense);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'weekly_spending')  List<double> weeklySpending, @JsonKey(name: 'weekly_labels')  List<String> weeklyLabels, @JsonKey(name: 'total_income')  double totalIncome, @JsonKey(name: 'total_expense')  double totalExpense)?  $default,) {final _that = this;
switch (_that) {
case _AnalyticsDto() when $default != null:
return $default(_that.weeklySpending,_that.weeklyLabels,_that.totalIncome,_that.totalExpense);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AnalyticsDto implements AnalyticsDto {
  const _AnalyticsDto({@JsonKey(name: 'weekly_spending') required final  List<double> weeklySpending, @JsonKey(name: 'weekly_labels') required final  List<String> weeklyLabels, @JsonKey(name: 'total_income') required this.totalIncome, @JsonKey(name: 'total_expense') required this.totalExpense}): _weeklySpending = weeklySpending,_weeklyLabels = weeklyLabels;
  factory _AnalyticsDto.fromJson(Map<String, dynamic> json) => _$AnalyticsDtoFromJson(json);

 final  List<double> _weeklySpending;
@override@JsonKey(name: 'weekly_spending') List<double> get weeklySpending {
  if (_weeklySpending is EqualUnmodifiableListView) return _weeklySpending;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklySpending);
}

 final  List<String> _weeklyLabels;
@override@JsonKey(name: 'weekly_labels') List<String> get weeklyLabels {
  if (_weeklyLabels is EqualUnmodifiableListView) return _weeklyLabels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklyLabels);
}

@override@JsonKey(name: 'total_income') final  double totalIncome;
@override@JsonKey(name: 'total_expense') final  double totalExpense;

/// Create a copy of AnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyticsDtoCopyWith<_AnalyticsDto> get copyWith => __$AnalyticsDtoCopyWithImpl<_AnalyticsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AnalyticsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyticsDto&&const DeepCollectionEquality().equals(other._weeklySpending, _weeklySpending)&&const DeepCollectionEquality().equals(other._weeklyLabels, _weeklyLabels)&&(identical(other.totalIncome, totalIncome) || other.totalIncome == totalIncome)&&(identical(other.totalExpense, totalExpense) || other.totalExpense == totalExpense));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_weeklySpending),const DeepCollectionEquality().hash(_weeklyLabels),totalIncome,totalExpense);

@override
String toString() {
  return 'AnalyticsDto(weeklySpending: $weeklySpending, weeklyLabels: $weeklyLabels, totalIncome: $totalIncome, totalExpense: $totalExpense)';
}


}

/// @nodoc
abstract mixin class _$AnalyticsDtoCopyWith<$Res> implements $AnalyticsDtoCopyWith<$Res> {
  factory _$AnalyticsDtoCopyWith(_AnalyticsDto value, $Res Function(_AnalyticsDto) _then) = __$AnalyticsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'weekly_spending') List<double> weeklySpending,@JsonKey(name: 'weekly_labels') List<String> weeklyLabels,@JsonKey(name: 'total_income') double totalIncome,@JsonKey(name: 'total_expense') double totalExpense
});




}
/// @nodoc
class __$AnalyticsDtoCopyWithImpl<$Res>
    implements _$AnalyticsDtoCopyWith<$Res> {
  __$AnalyticsDtoCopyWithImpl(this._self, this._then);

  final _AnalyticsDto _self;
  final $Res Function(_AnalyticsDto) _then;

/// Create a copy of AnalyticsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weeklySpending = null,Object? weeklyLabels = null,Object? totalIncome = null,Object? totalExpense = null,}) {
  return _then(_AnalyticsDto(
weeklySpending: null == weeklySpending ? _self._weeklySpending : weeklySpending // ignore: cast_nullable_to_non_nullable
as List<double>,weeklyLabels: null == weeklyLabels ? _self._weeklyLabels : weeklyLabels // ignore: cast_nullable_to_non_nullable
as List<String>,totalIncome: null == totalIncome ? _self.totalIncome : totalIncome // ignore: cast_nullable_to_non_nullable
as double,totalExpense: null == totalExpense ? _self.totalExpense : totalExpense // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$QrPaymentDto {

 UserDto get user;@JsonKey(name: 'account_name') String get accountName;@JsonKey(name: 'account_number') String get accountNumber; String get iban;@JsonKey(name: 'qr_payload') String? get qrPayload;
/// Create a copy of QrPaymentDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QrPaymentDtoCopyWith<QrPaymentDto> get copyWith => _$QrPaymentDtoCopyWithImpl<QrPaymentDto>(this as QrPaymentDto, _$identity);

  /// Serializes this QrPaymentDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QrPaymentDto&&(identical(other.user, user) || other.user == user)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.qrPayload, qrPayload) || other.qrPayload == qrPayload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,accountName,accountNumber,iban,qrPayload);

@override
String toString() {
  return 'QrPaymentDto(user: $user, accountName: $accountName, accountNumber: $accountNumber, iban: $iban, qrPayload: $qrPayload)';
}


}

/// @nodoc
abstract mixin class $QrPaymentDtoCopyWith<$Res>  {
  factory $QrPaymentDtoCopyWith(QrPaymentDto value, $Res Function(QrPaymentDto) _then) = _$QrPaymentDtoCopyWithImpl;
@useResult
$Res call({
 UserDto user,@JsonKey(name: 'account_name') String accountName,@JsonKey(name: 'account_number') String accountNumber, String iban,@JsonKey(name: 'qr_payload') String? qrPayload
});


$UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class _$QrPaymentDtoCopyWithImpl<$Res>
    implements $QrPaymentDtoCopyWith<$Res> {
  _$QrPaymentDtoCopyWithImpl(this._self, this._then);

  final QrPaymentDto _self;
  final $Res Function(QrPaymentDto) _then;

/// Create a copy of QrPaymentDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? accountName = null,Object? accountNumber = null,Object? iban = null,Object? qrPayload = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,iban: null == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String,qrPayload: freezed == qrPayload ? _self.qrPayload : qrPayload // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of QrPaymentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [QrPaymentDto].
extension QrPaymentDtoPatterns on QrPaymentDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QrPaymentDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QrPaymentDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QrPaymentDto value)  $default,){
final _that = this;
switch (_that) {
case _QrPaymentDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QrPaymentDto value)?  $default,){
final _that = this;
switch (_that) {
case _QrPaymentDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserDto user, @JsonKey(name: 'account_name')  String accountName, @JsonKey(name: 'account_number')  String accountNumber,  String iban, @JsonKey(name: 'qr_payload')  String? qrPayload)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QrPaymentDto() when $default != null:
return $default(_that.user,_that.accountName,_that.accountNumber,_that.iban,_that.qrPayload);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserDto user, @JsonKey(name: 'account_name')  String accountName, @JsonKey(name: 'account_number')  String accountNumber,  String iban, @JsonKey(name: 'qr_payload')  String? qrPayload)  $default,) {final _that = this;
switch (_that) {
case _QrPaymentDto():
return $default(_that.user,_that.accountName,_that.accountNumber,_that.iban,_that.qrPayload);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserDto user, @JsonKey(name: 'account_name')  String accountName, @JsonKey(name: 'account_number')  String accountNumber,  String iban, @JsonKey(name: 'qr_payload')  String? qrPayload)?  $default,) {final _that = this;
switch (_that) {
case _QrPaymentDto() when $default != null:
return $default(_that.user,_that.accountName,_that.accountNumber,_that.iban,_that.qrPayload);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QrPaymentDto implements QrPaymentDto {
  const _QrPaymentDto({required this.user, @JsonKey(name: 'account_name') required this.accountName, @JsonKey(name: 'account_number') required this.accountNumber, required this.iban, @JsonKey(name: 'qr_payload') this.qrPayload});
  factory _QrPaymentDto.fromJson(Map<String, dynamic> json) => _$QrPaymentDtoFromJson(json);

@override final  UserDto user;
@override@JsonKey(name: 'account_name') final  String accountName;
@override@JsonKey(name: 'account_number') final  String accountNumber;
@override final  String iban;
@override@JsonKey(name: 'qr_payload') final  String? qrPayload;

/// Create a copy of QrPaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QrPaymentDtoCopyWith<_QrPaymentDto> get copyWith => __$QrPaymentDtoCopyWithImpl<_QrPaymentDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QrPaymentDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QrPaymentDto&&(identical(other.user, user) || other.user == user)&&(identical(other.accountName, accountName) || other.accountName == accountName)&&(identical(other.accountNumber, accountNumber) || other.accountNumber == accountNumber)&&(identical(other.iban, iban) || other.iban == iban)&&(identical(other.qrPayload, qrPayload) || other.qrPayload == qrPayload));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,accountName,accountNumber,iban,qrPayload);

@override
String toString() {
  return 'QrPaymentDto(user: $user, accountName: $accountName, accountNumber: $accountNumber, iban: $iban, qrPayload: $qrPayload)';
}


}

/// @nodoc
abstract mixin class _$QrPaymentDtoCopyWith<$Res> implements $QrPaymentDtoCopyWith<$Res> {
  factory _$QrPaymentDtoCopyWith(_QrPaymentDto value, $Res Function(_QrPaymentDto) _then) = __$QrPaymentDtoCopyWithImpl;
@override @useResult
$Res call({
 UserDto user,@JsonKey(name: 'account_name') String accountName,@JsonKey(name: 'account_number') String accountNumber, String iban,@JsonKey(name: 'qr_payload') String? qrPayload
});


@override $UserDtoCopyWith<$Res> get user;

}
/// @nodoc
class __$QrPaymentDtoCopyWithImpl<$Res>
    implements _$QrPaymentDtoCopyWith<$Res> {
  __$QrPaymentDtoCopyWithImpl(this._self, this._then);

  final _QrPaymentDto _self;
  final $Res Function(_QrPaymentDto) _then;

/// Create a copy of QrPaymentDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? accountName = null,Object? accountNumber = null,Object? iban = null,Object? qrPayload = freezed,}) {
  return _then(_QrPaymentDto(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserDto,accountName: null == accountName ? _self.accountName : accountName // ignore: cast_nullable_to_non_nullable
as String,accountNumber: null == accountNumber ? _self.accountNumber : accountNumber // ignore: cast_nullable_to_non_nullable
as String,iban: null == iban ? _self.iban : iban // ignore: cast_nullable_to_non_nullable
as String,qrPayload: freezed == qrPayload ? _self.qrPayload : qrPayload // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of QrPaymentDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDtoCopyWith<$Res> get user {
  
  return $UserDtoCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// @nodoc
mixin _$BillPaymentRequestDto {

 double get amount;@JsonKey(name: 'bill_type') String get billType;
/// Create a copy of BillPaymentRequestDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BillPaymentRequestDtoCopyWith<BillPaymentRequestDto> get copyWith => _$BillPaymentRequestDtoCopyWithImpl<BillPaymentRequestDto>(this as BillPaymentRequestDto, _$identity);

  /// Serializes this BillPaymentRequestDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BillPaymentRequestDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.billType, billType) || other.billType == billType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,billType);

@override
String toString() {
  return 'BillPaymentRequestDto(amount: $amount, billType: $billType)';
}


}

/// @nodoc
abstract mixin class $BillPaymentRequestDtoCopyWith<$Res>  {
  factory $BillPaymentRequestDtoCopyWith(BillPaymentRequestDto value, $Res Function(BillPaymentRequestDto) _then) = _$BillPaymentRequestDtoCopyWithImpl;
@useResult
$Res call({
 double amount,@JsonKey(name: 'bill_type') String billType
});




}
/// @nodoc
class _$BillPaymentRequestDtoCopyWithImpl<$Res>
    implements $BillPaymentRequestDtoCopyWith<$Res> {
  _$BillPaymentRequestDtoCopyWithImpl(this._self, this._then);

  final BillPaymentRequestDto _self;
  final $Res Function(BillPaymentRequestDto) _then;

/// Create a copy of BillPaymentRequestDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? billType = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,billType: null == billType ? _self.billType : billType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BillPaymentRequestDto].
extension BillPaymentRequestDtoPatterns on BillPaymentRequestDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BillPaymentRequestDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BillPaymentRequestDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BillPaymentRequestDto value)  $default,){
final _that = this;
switch (_that) {
case _BillPaymentRequestDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BillPaymentRequestDto value)?  $default,){
final _that = this;
switch (_that) {
case _BillPaymentRequestDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount, @JsonKey(name: 'bill_type')  String billType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BillPaymentRequestDto() when $default != null:
return $default(_that.amount,_that.billType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount, @JsonKey(name: 'bill_type')  String billType)  $default,) {final _that = this;
switch (_that) {
case _BillPaymentRequestDto():
return $default(_that.amount,_that.billType);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount, @JsonKey(name: 'bill_type')  String billType)?  $default,) {final _that = this;
switch (_that) {
case _BillPaymentRequestDto() when $default != null:
return $default(_that.amount,_that.billType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BillPaymentRequestDto implements BillPaymentRequestDto {
  const _BillPaymentRequestDto({required this.amount, @JsonKey(name: 'bill_type') required this.billType});
  factory _BillPaymentRequestDto.fromJson(Map<String, dynamic> json) => _$BillPaymentRequestDtoFromJson(json);

@override final  double amount;
@override@JsonKey(name: 'bill_type') final  String billType;

/// Create a copy of BillPaymentRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BillPaymentRequestDtoCopyWith<_BillPaymentRequestDto> get copyWith => __$BillPaymentRequestDtoCopyWithImpl<_BillPaymentRequestDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BillPaymentRequestDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BillPaymentRequestDto&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.billType, billType) || other.billType == billType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,billType);

@override
String toString() {
  return 'BillPaymentRequestDto(amount: $amount, billType: $billType)';
}


}

/// @nodoc
abstract mixin class _$BillPaymentRequestDtoCopyWith<$Res> implements $BillPaymentRequestDtoCopyWith<$Res> {
  factory _$BillPaymentRequestDtoCopyWith(_BillPaymentRequestDto value, $Res Function(_BillPaymentRequestDto) _then) = __$BillPaymentRequestDtoCopyWithImpl;
@override @useResult
$Res call({
 double amount,@JsonKey(name: 'bill_type') String billType
});




}
/// @nodoc
class __$BillPaymentRequestDtoCopyWithImpl<$Res>
    implements _$BillPaymentRequestDtoCopyWith<$Res> {
  __$BillPaymentRequestDtoCopyWithImpl(this._self, this._then);

  final _BillPaymentRequestDto _self;
  final $Res Function(_BillPaymentRequestDto) _then;

/// Create a copy of BillPaymentRequestDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? billType = null,}) {
  return _then(_BillPaymentRequestDto(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,billType: null == billType ? _self.billType : billType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$SettingsDto {

@JsonKey(name: 'theme_mode') String get themeMode; String get locale;
/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsDtoCopyWith<SettingsDto> get copyWith => _$SettingsDtoCopyWithImpl<SettingsDto>(this as SettingsDto, _$identity);

  /// Serializes this SettingsDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsDto&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,locale);

@override
String toString() {
  return 'SettingsDto(themeMode: $themeMode, locale: $locale)';
}


}

/// @nodoc
abstract mixin class $SettingsDtoCopyWith<$Res>  {
  factory $SettingsDtoCopyWith(SettingsDto value, $Res Function(SettingsDto) _then) = _$SettingsDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'theme_mode') String themeMode, String locale
});




}
/// @nodoc
class _$SettingsDtoCopyWithImpl<$Res>
    implements $SettingsDtoCopyWith<$Res> {
  _$SettingsDtoCopyWithImpl(this._self, this._then);

  final SettingsDto _self;
  final $Res Function(SettingsDto) _then;

/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? themeMode = null,Object? locale = null,}) {
  return _then(_self.copyWith(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SettingsDto].
extension SettingsDtoPatterns on SettingsDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsDto value)  $default,){
final _that = this;
switch (_that) {
case _SettingsDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsDto value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'theme_mode')  String themeMode,  String locale)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsDto() when $default != null:
return $default(_that.themeMode,_that.locale);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'theme_mode')  String themeMode,  String locale)  $default,) {final _that = this;
switch (_that) {
case _SettingsDto():
return $default(_that.themeMode,_that.locale);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'theme_mode')  String themeMode,  String locale)?  $default,) {final _that = this;
switch (_that) {
case _SettingsDto() when $default != null:
return $default(_that.themeMode,_that.locale);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SettingsDto implements SettingsDto {
  const _SettingsDto({@JsonKey(name: 'theme_mode') required this.themeMode, required this.locale});
  factory _SettingsDto.fromJson(Map<String, dynamic> json) => _$SettingsDtoFromJson(json);

@override@JsonKey(name: 'theme_mode') final  String themeMode;
@override final  String locale;

/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsDtoCopyWith<_SettingsDto> get copyWith => __$SettingsDtoCopyWithImpl<_SettingsDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SettingsDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsDto&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.locale, locale) || other.locale == locale));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,themeMode,locale);

@override
String toString() {
  return 'SettingsDto(themeMode: $themeMode, locale: $locale)';
}


}

/// @nodoc
abstract mixin class _$SettingsDtoCopyWith<$Res> implements $SettingsDtoCopyWith<$Res> {
  factory _$SettingsDtoCopyWith(_SettingsDto value, $Res Function(_SettingsDto) _then) = __$SettingsDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'theme_mode') String themeMode, String locale
});




}
/// @nodoc
class __$SettingsDtoCopyWithImpl<$Res>
    implements _$SettingsDtoCopyWith<$Res> {
  __$SettingsDtoCopyWithImpl(this._self, this._then);

  final _SettingsDto _self;
  final $Res Function(_SettingsDto) _then;

/// Create a copy of SettingsDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? themeMode = null,Object? locale = null,}) {
  return _then(_SettingsDto(
themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
