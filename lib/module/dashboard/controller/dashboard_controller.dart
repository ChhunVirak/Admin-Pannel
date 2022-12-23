import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/app_model.dart';

class DashboardController extends GetxController {
  static final _firebase = FirebaseFirestore.instance;

  final listApp = <AppModel>[].obs;
  Future<void> getApplist() async {
    listApp.clear();
    await _firebase
        .collection('allapplist')
        .doc("PzFIM1vAROeDI5RBHzIB")
        .collection('applist')
        .get()
        .then((value) {
      value.docs.map(
        (e) {
          debugPrint("------------->hello");
          var item = AppModel.fromJson(e.data());
          listApp.add(item);
        },
      ).toList();
    }).onError((error, stackTrace) {
      debugPrint("ERROR -------> ${error.toString()}");
    });
  }
}
