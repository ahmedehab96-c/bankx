import 'package:equatable/equatable.dart';

abstract class AccountsEvent extends Equatable {
  const AccountsEvent();

  @override
  List<Object?> get props => [];
}

class AccountDetailsLoaded extends AccountsEvent {
  const AccountDetailsLoaded(this.id);

  final String id;

  @override
  List<Object?> get props => [id];
}
