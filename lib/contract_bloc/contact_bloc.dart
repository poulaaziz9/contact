import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/models/model_contact.dart';
import 'package:untitled1/repository/contact_repository.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository contactRepository;
  ContactBloc({required this.contactRepository}) : super(ContactInitial()) {
    on<Create>((event, emit) async {
      emit(ContactAdding());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await contactRepository.create(name: event.name, number: event.number);
        emit(ContactAdded());
      } catch (e) {
        emit(ContactError(e.toString()));
      }
    });
    on<GetData>((event, emit) async {
      emit(ContactLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await contactRepository.get();
        emit(ContactLoaded(data));
      } catch (e) {
        emit(ContactError(e.toString()));
      }
    });
  }
}
