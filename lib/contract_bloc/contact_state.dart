part of 'contact_bloc.dart';

@immutable
abstract class ContactState extends Equatable {}

class ContactInitial extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactAdding extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactAdded extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactError extends ContactState {
  final String error;
  ContactError(this.error);
  @override
  List<Object?> get props => [error];
}

class ContactLoading extends ContactState {
  @override
  List<Object?> get props => [];
}

class ContactLoaded extends ContactState {
  late List<ContactModel> mydata;
  ContactLoaded(this.mydata);
  @override
  List<Object?> get props => [mydata];
}
