part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Create extends ContactEvent {
  final String name;
  final String number;
  Create(this.name, this.number);
}

class GetData extends ContactEvent {
  GetData();
}
