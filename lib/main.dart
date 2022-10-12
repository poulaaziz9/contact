import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/contract_bloc/contact_bloc.dart';
import 'package:untitled1/repository/contact_repository.dart';
import 'package:untitled1/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts App ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => ContactRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

    return BlocProvider(
      create: (context) => ContactBloc(
          contactRepository: RepositoryProvider.of<ContactRepository>(context)),
      child: Scaffold(
          key: scaffoldKey,
          body: BlocListener<ContactBloc, ContactState>(
              listener: (context, state) {
            if (state is ContactAdded) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("contact added"),
                duration: Duration(seconds: 2),
              ));
            }
          }, child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              if (state is ContactAdding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ContactError) {
                return const Center(child: Text("Error"));
              }
              return const HomeScreen();
            },
          ))),
    );
  }
}
