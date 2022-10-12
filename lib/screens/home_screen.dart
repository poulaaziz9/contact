import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/contract_bloc/contact_bloc.dart';
import 'package:untitled1/models/model_contact.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  Future<void> _create() async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _numberController,
                  decoration: const InputDecoration(
                    labelText: 'Number',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? number =
                        double.tryParse(_numberController.text);
                    if (number != null) {
                      _postData(context);

                      _nameController.text = '';
                      _nameController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  void _postData(context) {
    BlocProvider.of<ContactBloc>(context).add(
      Create(_nameController.text, _numberController.text),
    );
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactBloc>(context).add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Firebase Firestore')),
        ),
        body: BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
          if (state is ContactLoaded) {
            List<ContactModel> data = state.mydata;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  return Card(
                    child: ListTile(
                      title: Text(data[index].name),
                      trailing: Text(data[index].number),
                    ),
                  );
                });
          } else if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
