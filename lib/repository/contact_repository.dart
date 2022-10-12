import 'package:flutter/foundation.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled1/models/model_contact.dart';

class ContactRepository {
  final fireCloud = FirebaseFirestore.instance.collection("contacts");

  Future<void> create({required String name, required String number}) async {
    try {
      await fireCloud.add({"name": name, "number": number});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error ' ${e.code} ' : ${e.message}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<ContactModel>> get() async {
    List<ContactModel> proList = [];
    try {
      final pro = await FirebaseFirestore.instance.collection("contacts").get();
      pro.docs.forEach((element) {
        return proList.add(ContactModel.fromJson(element.data()));
      });
      return proList;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("Failed with error ' ${e.code} ' : ${e.message}");
      }
      return proList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
